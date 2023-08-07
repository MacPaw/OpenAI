//
//  StreamingSession.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 18/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class StreamingSession<ResultType: Codable>: NSObject, Identifiable, URLSessionDelegate, URLSessionDataDelegate {
    
    enum StreamingError: Error {
        case unknownContent
        case emptyContent
    }
    
    var onReceiveContent: ((StreamingSession, ResultType) -> Void)?
    var onProcessingError: ((StreamingSession, Error) -> Void)?
    var onComplete: ((StreamingSession, Error?) -> Void)?
    
    private let streamingCompletionMarker = "[DONE]"
    private let urlRequest: URLRequest
    private lazy var urlSession: URLSession = {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        return session
    }()
    
    private var accumulatedData = "" // This will hold incomplete JSON data
    
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
    }
    
    func perform() {
        self.urlSession
            .dataTask(with: self.urlRequest)
            .resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        onComplete?(self, error)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let stringContent = String(data: data, encoding: .utf8) else {
            onProcessingError?(self, StreamingError.unknownContent)
            return
        }                
        
        // As data comes in, we process it by trying to decode to JSON. Since we may not have yet received a fully valid
        // JSON string yet, we keep appending content if we're unable to decode due to a "dataCorrupted" error, trying again
        // on the next pass in case that new data has completed the string to create valid (parsable) JSON, and so on.
        // Note that while OpenAI's API doesn't appear to return partial string fragments, proxy service such as Helicone
        // do seem to do so, making this logic necessary.
        accumulatedData.append(stringContent)
        processAccumulatedData()
    }
    
    func processAccumulatedData() {
        let jsonObjects = accumulatedData
            .components(separatedBy: "data:")
            .filter { $0.isEmpty == false }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        guard !jsonObjects.isEmpty, jsonObjects.first != streamingCompletionMarker else {
            return
        }
        jsonObjects.forEach { jsonContent in
            processJsonContent(jsonContent: jsonContent)
        }
    }
    
    private func processJsonContent(jsonContent: String) {
        guard jsonContent != streamingCompletionMarker else {
            return
        }
        
        guard let jsonData = jsonContent.data(using: .utf8) else {
            onProcessingError?(self, StreamingError.unknownContent)
            return
        }
        
        do {
            if let object = try decodeResultType(from: jsonData) {
                accumulatedData = "" // Successfully decoded, so reset accumulatedData.
                onReceiveContent?(self, object)
            }
        } catch let apiError {
            handleApiError(apiError, data: jsonData)
        }
    }
    
    private func decodeResultType(from data: Data) throws -> ResultType? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(ResultType.self, from: data)
        } catch let error as DecodingError {
            if case .dataCorrupted = error {
                // Invalid JSON - this isn't an error condition, we simply don't have all the data yet.
                // We'll wait for this function to be called again, and will append the data we subsequently
                // receive to the accumulatedData variable, so that we can try to process that longer,
                // more complete string at that point.
                
                return nil // Return nil to indicate that the data is not yet complete.
            } else {
                // Handle other decoding errors
                throw error
            }
        }
    }
    
    private func handleApiError(_ error: Error, data: Data) {
        do {
            let decoded = try JSONDecoder().decode(APIErrorResponse.self, from: data)
            onProcessingError?(self, decoded)
        } catch {
            onProcessingError?(self, error)
        }
    }
}
