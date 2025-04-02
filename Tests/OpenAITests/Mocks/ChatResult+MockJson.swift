//
//  ChatResult+MockJson.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 02.04.2025.
//

import Foundation
@testable import OpenAI

extension ChatResult {
    static let mockJsonString = """
        {
          "id": "chatcmpl-123",
          "object": "chat.completion",
          "created": 1677652288,
          "model": "gpt-4",
          "choices": [{
            "index": 0,
            "message": {
              "role": "assistant",
              "content": "Hello, world!",
              "annotations": [],
              "tool_calls": []
            },
            "finish_reason": "stop"
          }],
          "usage": {
            "prompt_tokens": 9,
            "completion_tokens": 12,
            "total_tokens": 21
          },
          "system_fingerprint": "fp_fc9f1d7035"
        }
        """
}
