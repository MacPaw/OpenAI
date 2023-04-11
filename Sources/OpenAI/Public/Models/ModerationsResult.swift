//
//  ModerationsResult.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsResult: Codable, Equatable {
    
    public struct CategoryResult: Codable, Equatable {
        
        public struct Categories: Codable, Equatable {
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Bool
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hateThreatening: Bool
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarm: Bool
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Bool
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexualMinors: Bool
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Bool
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violenceGraphic: Bool
            
            enum CodingKeys: String, CodingKey {
                case hate
                case hateThreatening = "hate/threatening"
                case selfHarm = "self-harm"
                case sexual
                case sexualMinors = "sexual/minors"
                case violence
                case violenceGraphic = "violence/graphic"
            }
        }
        
        public struct CategoryScores: Codable, Equatable {
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Double
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hateThreatening: Double
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarm: Double
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Double
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexualMinors: Double
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Double
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violenceGraphic: Double
            
            enum CodingKeys: String, CodingKey {
                case hate
                case hateThreatening = "hate/threatening"
                case selfHarm = "self-harm"
                case sexual
                case sexualMinors = "sexual/minors"
                case violence
                case violenceGraphic = "violence/graphic"
            }
        }
        
        /// Collection of per-category binary usage policies violation flags. For each category, the value is true if the model flags the corresponding category as violated, false otherwise.
        public let categories: Categories
        /// Collection of per-category raw scores output by the model, denoting the model's confidence that the input violates the OpenAI's policy for the category. The value is between 0 and 1, where higher values denote higher confidence. The scores should not be interpreted as probabilities.
        public let categoryScores: CategoryScores
        /// True if the model classifies the content as violating OpenAI's usage policies, false otherwise.
        public let flagged: Bool
        
        enum CodingKeys: String, CodingKey {
            case categories
            case categoryScores = "category_scores"
            case flagged
        }
    }
    
    public let id: String
    public let model: Model
    public let results: [CategoryResult]
}
