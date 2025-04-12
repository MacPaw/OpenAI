//
//  DescribedError.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 11.04.2025.
//

import Foundation

protocol DescribedError: LocalizedError {
}

extension DescribedError {
    var errorDescription: String? {
        String(describing: self)
    }
}
