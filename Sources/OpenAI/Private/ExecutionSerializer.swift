//
//  ExecutionSerializer.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

protocol ExecutionSerializer {
    func dispatch(_ closure: @escaping () -> Void)
}

struct GCDQueueAsyncExecutionSerializer: ExecutionSerializer {
    let queue: DispatchQueue
    
    func dispatch(_ closure: @escaping () -> Void) {
        queue.async(execute: .init(block: closure))
    }
}
