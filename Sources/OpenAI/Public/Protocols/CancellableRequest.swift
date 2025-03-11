//
//  CancellableRequest.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 30.01.2025.
//

import Foundation

public protocol CancellableRequest: Sendable {
    func cancelRequest()
}
