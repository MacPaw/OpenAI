//
//  APIConfiguration.swift
//  DemoChat
//
//  Created by Govind Yadav on 9/29/26.
//

import OpenAI
import SwiftUI

extension EnvironmentValues {
    @Entry public var apiProvider: APIProvider = .openAI
    @Entry public var configuredChatModel: Model = .gpt6_luna
    /// Presents the app's API configuration screen.
    @Entry public var showAPIConfiguration: () -> Void = {}
}
