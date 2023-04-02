//
//  Utilities.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

public struct Vector {
    
    /// Returns the similarity between two vectors
    ///
    /// - Parameters:
    ///     - a: The first vector
    ///     - b: The second vector
    public static func cosineSimilarity(a: [Double], b: [Double]) -> Double {
        return dot(a, b) / (mag(a) * mag(b))
    }

    /// Returns the difference between two vectors. Cosine distance is defined as `1 - cosineSimilarity(a, b)`
    ///
    /// - Parameters:
    ///     - a: The first vector
    ///     - b: The second vector
    public func cosineDifference(a: [Double], b: [Double]) -> Double {
        return 1 - Self.cosineSimilarity(a: a, b: b)
    }
}
 
private extension Vector {

    static func round(_ input: Double, to places: Int = 1) -> Double {
        let divisor = pow(10.0, Double(places))
        return (input * divisor).rounded() / divisor
    }

    static func dot(_ a: [Double], _ b: [Double]) -> Double {
        assert(a.count == b.count, "Vectors must have the same dimension")
        let result = zip(a, b)
            .map { $0 * $1 }
            .reduce(0, +)

        return result
    }

    static func mag(_ vector: [Double]) -> Double {
        return sqrt(dot(vector, vector))
    }
}
