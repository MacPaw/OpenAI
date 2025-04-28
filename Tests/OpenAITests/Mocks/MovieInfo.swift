//
//  MovieInfo.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 22.04.2025.
//

@testable import OpenAI
import Foundation

enum MovieGenre: String, Codable, JSONSchemaEnumConvertible {
    case action, drama, comedy, scifi
    var caseNames: [String] { Self.allCases.map { $0.rawValue } }
}

struct MovieInfo: JSONSchemaConvertible {
    let title: String
    let director: String
    let release: Date
    let genres: [MovieGenre]
    let cast: [String]
    
    static let example: Self = {
        .init(
            title: "Earth",
            director: "Alexander Dovzhenko",
            release: Calendar.current.date(from: DateComponents(year: 1930, month: 4, day: 1))!,
            genres: [.drama],
            cast: ["Stepan Shkurat", "Semyon Svashenko", "Yuliya Solntseva"]
        )
    }()
}
