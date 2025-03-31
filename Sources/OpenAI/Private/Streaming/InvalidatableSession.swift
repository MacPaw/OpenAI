//
//  InvalidatableSession.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.03.2025.
//

import Foundation

protocol InvalidatableSession: Sendable {
    func invalidateAndCancel()
    func finishTasksAndInvalidate()
}
