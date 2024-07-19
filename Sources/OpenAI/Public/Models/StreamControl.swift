//
//  StreamControl.swift
//
//
//  Created by Daniel Nguyen on 4/24/24.
//

import Foundation

public class StreamControl {
    private var session: StreamingSession<ChatStreamResult>? = nil

    func setSession(_ session: StreamingSession<ChatStreamResult>) {
        self.session = session
    }
    
    public init() {}
    
    public func cancel() {
        self.session?.cancel()
        self.session = nil
    }
}
