//
//  APIConfiguration.swift
//  DemoChat
//
//  Created by Govind Yadav on 9/29/26.
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var apiProvider: APIProvider = .openAI
    /// Presents the app's API configuration screen.
    @Entry public var showAPIConfiguration: () -> Void = {}
}
