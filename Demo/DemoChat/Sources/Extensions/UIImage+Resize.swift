//
//  UIImage+Resize.swift
//  DemoChat
//
//  Created by Oleksii Nezhyborets on 17.04.2025.
//

import UIKit

extension UIImage {
    /// Resize the image to fit within the bounding box while preserving aspect ratio.
    /// - Parameters:
    ///   - maxLongSide: Maximum allowed length for the longer side (default: 2000).
    ///   - maxShortSide: Maximum allowed length for the shorter side (default: 768).
    /// - Returns: Resized UIImage or self if no resizing needed.
    func resizedToFit(maxLongSide: CGFloat = 2000, maxShortSide: CGFloat = 768) -> UIImage {
        let width = self.size.width
        let height = self.size.height

        let longSide = max(width, height)
        let shortSide = min(width, height)

        // Determine scaling factor (never upscale)
        let longScale = maxLongSide / longSide
        let shortScale = maxShortSide / shortSide
        let scaleFactor = min(longScale, shortScale, 1)

        // If no scaling is needed
        if scaleFactor == 1 {
            return self
        }

        let newSize = CGSize(width: width * scaleFactor, height: height * scaleFactor)

        let renderer = UIGraphicsImageRenderer(size: newSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
