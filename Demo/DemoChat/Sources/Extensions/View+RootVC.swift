//
//  View+RootVC.swift
//
//
//  Created by Ihor Makhnyk on 20.11.2023.
//

import SwiftUI

extension View {
    func getCurrentViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else { return nil }
        return rootViewController
    }
}
