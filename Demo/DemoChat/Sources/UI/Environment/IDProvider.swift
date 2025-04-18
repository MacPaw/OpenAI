//
//  IDProvider.swift
//  DemoChat
//
//  Created by Sihao Lu on 4/6/23.
//

import SwiftUI

extension EnvironmentValues {
    @Entry public var idProviderValue: () -> String = { UUID().uuidString }
}

extension View {
    public func idProviderValue(_ idProviderValue: @escaping () -> String) -> some View {
        environment(\.idProviderValue, idProviderValue)
    }
}
