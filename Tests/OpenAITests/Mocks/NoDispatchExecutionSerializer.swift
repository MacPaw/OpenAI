//
//  NoDispatchExecutionSerializer.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 28.06.2025.
//

import Foundation
@testable import OpenAI

struct NoDispatchExecutionSerializer: ExecutionSerializer {
    func dispatch(_ closure: @escaping () -> Void) {
        closure()
    }
}
