//
//  ArrayWithThreadSafety.swift
//  
//
//  Created by James J Kalafus on 2024-02-01.
//

import Foundation

internal class ArrayWithThreadSafety<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "us.kalaf.OpenAI.threadSafeArray", attributes: .concurrent)

    @inlinable public func append(_ element: T) {
        queue.async(flags: .barrier) {
            self.array.append(element)
        }
    }

    @inlinable public func removeAll(where shouldBeRemoved: @escaping (T) throws -> Bool) rethrows {
        try queue.sync(flags: .barrier) {
            try self.array.removeAll(where: shouldBeRemoved)
        }
    }
}
