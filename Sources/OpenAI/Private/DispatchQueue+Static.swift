//
//  DispatchQueue+Static.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 04.03.2025.
//

import Foundation

extension DispatchQueue {
    static let userInitiated = DispatchQueue(label: "com.macpaw.OpenAI", qos: .userInitiated)
}
