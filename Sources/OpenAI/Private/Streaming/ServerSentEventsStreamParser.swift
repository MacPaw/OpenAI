//
//  ServerSentEventsStreamInterpreter.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

/// https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation
/// 9.2.6 Interpreting an event stream
final class ServerSentEventsStreamParser: @unchecked Sendable {
    private var onEventDispatched: ((Event) -> Void)?
    private var onError: ((Error) -> Void)?
    
    private var isFirstChunk = true
    private var dataBuffer: Data = .init()
    private var eventTypeBuffer: String = .init()
    private var retry: Int?
    private var lastEventIdBuffer: String?
    private var incompleteLine: Data?
    
    private let cr: UInt8 = 0x0D // carriage return
    private let lf: UInt8 = 0x0A // line feed
    private let colon: UInt8 = 0x3A
    private let space: UInt8 = 0x20
    
    struct Event {
        let id: String?
        let data: Data
        let decodedData: String
        let eventType: String
        let retry: Int?
    }
    
    enum ParsingError: Error {
        case decodingFieldNameFailed(fieldNameData: Data, lineData: Data)
        case decodingFieldValueFailed(valueData: Data, lineData: Data)
        case retryIsNotImplemented
    }
    
    /// Sets closures an instance of type in a thread safe manner
    ///
    /// - Parameters:
    ///     - onEventDispatched: Can be called multiple times per `processData`
    ///     - onError: Will only be called once per `processData`
    func setCallbackClosures(onEventDispatched: @escaping @Sendable (Event) -> Void, onError: @escaping @Sendable (Error) -> Void) {
        self.onEventDispatched = onEventDispatched
        self.onError = onError
    }
    
    func processData(data: Data) {
        var chunk = data
        
        /// The [UTF-8 decode](https://encoding.spec.whatwg.org/#utf-8-decode) algorithm strips one leading UTF-8 Byte Order Mark (BOM), if any.
        if isFirstChunk && data.starts(with: [0xEF, 0xBB, 0xBF]) {
            chunk = data.advanced(by: 3)
        }
        
        if let incompleteLine {
            chunk = incompleteLine + chunk
        }
        
        let (lines, incompleteLine) = lines(fromStream: chunk)
        
        for line in lines {
            do {
                try parseLine(lineData: line)
            } catch {
                onError?(error)
            }
        }
        
        self.incompleteLine = incompleteLine
        isFirstChunk = false
    }
    
    private func lines(fromStream streamData: Data) -> (complete: [Data], incomplete: Data?) {
        guard !streamData.isEmpty else {
            return ([], nil)
        }
        
        // The stream must then be parsed by reading everything line by line, with a U+000D CARRIAGE RETURN U+000A LINE FEED (CRLF) character pair, a single U+000A LINE FEED (LF) character not preceded by a U+000D CARRIAGE RETURN (CR) character, and a single U+000D CARRIAGE RETURN (CR) character not followed by a U+000A LINE FEED (LF) character being the ways in which a line can end.
        var previousCharacter: UInt8 = 0
        var lineBeginningIndex = 0
        var lines: [Data] = []
        
        for i in 0..<streamData.count {
            let currentChar = streamData[i]
            if currentChar == lf {
                // The description above basically says that "if the char is LF - it's end if line, regardless what precedes or follows it.
                // But if previous chat was CR we should exclude that, too
                let lineEndIndex = previousCharacter == cr ? i - 1 : i
                lines.append(streamData.subdata(in: lineBeginningIndex..<lineEndIndex))
                lineBeginningIndex = i + 1
            } else if currentChar == cr {
                // The description above basically says that "CR is not end of line only if followed by LF"
                // So we skip CR to make sure that the next one is not LF
            } else if previousCharacter == cr {
                // The char is not CR or LF, but the previous char was CR, so it was the end of line
                lines.append(streamData.subdata(in: lineBeginningIndex..<i-1))
                lineBeginningIndex = i
            } else {
                // The char is not CR or LF, and the previous one is not either
                // Simply skipping
            }
            
            previousCharacter = currentChar
        }
        
        if lineBeginningIndex < streamData.count - 1 {
            return (lines, streamData.subdata(in: lineBeginningIndex..<streamData.count))
        } else {
            return (lines, nil)
        }
    }
    
    private func parseLine(lineData: Data) throws {
        // If the line is empty (a blank line)
        // - Dispatch the event
        if lineData.isEmpty {
            dispatchEvent()
            return
        }
        
        // If the line starts with a U+003A COLON character (:)
        // - Ignore the line.
        if lineData.first == colon {
            return
        }
        
        // Collect the characters on the line before the first U+003A COLON character (:), and let field be that string.
        //
        // Collect the characters on the line after the first U+003A COLON character (:), and let value be that string.
        // If value starts with a U+0020 SPACE character, remove it from value.
        //
        // Process the field using the steps described below, using field as the field name and value as the field value.
        let fieldNameData = lineData.prefix(while: { $0 != colon })
        
        guard let fieldName = String(data: fieldNameData, encoding: .utf8) else {
            throw ParsingError.decodingFieldNameFailed(fieldNameData: fieldNameData, lineData: lineData)
        }
        
        // If the line contains a U+003A COLON character (:)
        if fieldNameData.count != lineData.count {
            // Collect the characters on the line before the first U+003A COLON character (:), and let field be that string.
            //
            // Collect the characters on the line after the first U+003A COLON character (:), and let value be that string.
            // If value starts with a U+0020 SPACE character, remove it from value.
            //
            // Process the field using field as the field name and value as the field value.
            
            // Collect the characters on the line after the first U+003A COLON character (:), and let value be that string.
            var valueData = lineData.suffix(from: fieldNameData.count + 1)
            // If value starts with a U+0020 SPACE character, remove it from value.
            if valueData.first == space {
                valueData.removeFirst()
            }
            
            try processField(name: fieldName, valueData: valueData, lineData: lineData)
        } else {
            // Otherwise, the string is not empty but does not contain a U+003A COLON character (:)
            //
            // Process the field using the whole line as the field name, and the empty string as the field value.
            try processField(name: fieldName, valueData: .init(), lineData: lineData)
        }
    }
    
    /// https://html.spec.whatwg.org/multipage/server-sent-events.html#dispatchMessage
    ///
    /// When the user agent is required to dispatch the event, the user agent must process the data buffer, the event type buffer, and the last event ID buffer using steps appropriate for the user agent.
    ///
    /// The link above has a defined list of step for Web Browsers. For other user agents (like this one), it says:
    /// "the appropriate steps to dispatch the event are implementation dependent, but at a minimum they must set the data and event type buffers to the empty string before returning."
    ///
    /// We would partially use that list for the implementation
    private func dispatchEvent() {
        // 1. Set the last event ID string of the event source to the value of the last event ID buffer. The buffer does not get reset, so the last event ID string of the event source remains set to this value until the next time it is set by the server.
        // Current Implementation Note: As don't have EventSource, the only thing we take is the ID buffer should not get reset
        
        // 2. If the data buffer is an empty string, set the data buffer and the event type buffer to the empty string and return.
        if dataBuffer.isEmpty {
            eventTypeBuffer = .init()
            retry = nil
            return
        }
        
        // 3. If the data buffer's last character is a U+000A LINE FEED (LF) character, then remove the last character from the data buffer.
        if dataBuffer.last == lf {
            dataBuffer.removeLast()
        }
        
        // 4. Let event be the result of creating an event using MessageEvent, in the relevant realm of the EventSource object.
        // Current Implementation Note: we ignore this point as we don't have said MessageEvent and EventSource types
        
        // 5. Initialize event's type attribute to "message", its data attribute to data, its origin attribute to the serialization of the origin of the event stream's final URL (i.e., the URL after redirects), and its lastEventId attribute to the last event ID string of the event source.
        // Current Implementation Notes:
        // - we'll use "message" for event type if not specified otherwise
        // - we ignore origin for now, will implement later if needed
        // - we don't have a notion of event source, so we'll just put id into the event itself
        
        // 6. If the event type buffer has a value other than the empty string, change the type of the newly created event to equal the value of the event type buffer.
        let event = Event(
            id: lastEventIdBuffer,
            data: dataBuffer,
            decodedData: .init(data: dataBuffer, encoding: .utf8) ?? "",
            eventType: eventTypeBuffer.isEmpty ? "message" : eventTypeBuffer,
            retry: retry
        )
        
        // 7. Set the data buffer and the event type buffer to the empty string.
        dataBuffer = .init()
        eventTypeBuffer = .init()
        retry = nil
        
        // 8. Queue a task which, if the readyState attribute is set to a value other than CLOSED, dispatches the newly created event at the EventSource object.
        // Current Implementation Note: we don't have said states at the moment, so we'll just dispatch the event
        onEventDispatched?(event)
    }
    
    /// https://html.spec.whatwg.org/multipage/server-sent-events.html#processField
    ///
    /// The steps to process the field given a field name and a field value depend on the field name, as given in the following list. Field names must be compared literally, with no case folding performed.
    private func processField(name: String, valueData: Data, lineData: Data) throws {
        switch name {
        case "event":
            /// **If the field name is "event"**
            /// Set the event type buffer to field value.
            let valueString = try value(fromData: valueData, lineData: lineData)
            eventTypeBuffer = valueString
        case "data":
            /// **If the field name is "data"**
            /// Append the field value to the data buffer, then append a single U+000A LINE FEED (LF) character to the data buffer.
            dataBuffer += valueData
            dataBuffer += Data([lf])
        case "id":
            /// **If the field name is "id"
            ///
            /// If the field value does not contain U+0000 NULL...
            if valueData.first(where: { $0 == 0x00 }) == nil {
                // ...set the last event ID buffer to the field value.
                let valueString = try value(fromData: valueData, lineData: lineData)
                lastEventIdBuffer = valueString
            } else {
                // Otherwise, ignore the field.
            }
        case "retry":
            /// **If the field value consists of only ASCII digits...**
            if valueData.allSatisfy({ $0 >= 0x30 && $0 <= 0x39 }) {
                // ...interpret the field value as an integer in base ten, and set the event stream's reconnection time to that integer.
                let valueString = try value(fromData: valueData, lineData: lineData)
                if let valueInt = Int(valueString) {
                    retry = valueInt
                }
            } else {
                // Otherwise, ignore the field.
            }
        default:
            /// **Otherwise**
            ///
            /// The field is ignored.
            break
        }
    }
    
    private func value(fromData valueData: Data, lineData: Data) throws -> String {
        guard let valueString = String(data: valueData, encoding: .utf8) else {
            throw ParsingError.decodingFieldValueFailed(valueData: valueData, lineData: lineData)
        }
        
        return valueString
    }
}
