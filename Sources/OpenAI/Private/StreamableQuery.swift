//
//  Streamable.swift
//
//
//  Created by Sergii Kryvoblotskyi on 15/05/2023.
//

import Foundation

protocol Streamable {

    var stream: Bool { get set }
    func makeStreamable() -> Self
    func makeNonStreamable() -> Self
}

extension Streamable {

    func makeStreamable() -> Self {
        guard !stream else {
            return self
        }
        var copy = self
        copy.stream = true
        return copy
    }

    func makeNonStreamable() -> Self {
        guard stream else {
            return self
        }
        var copy = self
        copy.stream = false
        return copy
    }
}
