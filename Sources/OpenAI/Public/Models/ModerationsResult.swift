//
//  ModerationsResult.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsResult: Codable, Equatable, Sendable {
    
    public struct Moderation: Codable, Equatable, Sendable {
        
        public struct Categories: Codable, Equatable, Sequence, Sendable {

            /// Content that expresses, incites, or promotes harassing language towards any target.
            public let harassment: Bool
            /// Harassment content that also includes violence or serious harm towards any target.
            public let harassmentThreatening: Bool
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Bool
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hateThreatening: Bool
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarm: Bool
            /// Content where the speaker expresses that they are engaging or intend to engage in acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarmIntent: Bool
            /// Content that encourages performing acts of self-harm, such as suicide, cutting, and eating disorders, or that gives instructions or advice on how to commit such acts.
            public let selfHarmInstructions: Bool
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Bool
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexualMinors: Bool
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Bool
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violenceGraphic: Bool

            public enum CodingKeys: String, CodingKey, CaseIterable {
                case harassment
                case harassmentThreatening = "harassment/threatening"
                case hate
                case hateThreatening = "hate/threatening"
                case selfHarm = "self-harm"
                case selfHarmIntent = "self-harm/intent"
                case selfHarmInstructions = "self-harm/instructions"
                case sexual
                case sexualMinors = "sexual/minors"
                case violence
                case violenceGraphic = "violence/graphic"
            }

            public func makeIterator() -> IndexingIterator<[(String, Bool)]> {
                return Mirror(reflecting: self).children.enumerated().map { (index, element) in
                    return (CodingKeys.allCases[index].stringValue, element.value) as! (String, Bool)
                }.makeIterator()
            }
        }

        public struct CategoryScores: Codable, Equatable, Sequence, Sendable {

            /// Content that expresses, incites, or promotes harassing language towards any target.
            public let harassment: Double
            /// Harassment content that also includes violence or serious harm towards any target.
            public let harassmentThreatening: Double
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Double
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hateThreatening: Double
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarm: Double
            /// Content where the speaker expresses that they are engaging or intend to engage in acts of self-harm, such as suicide, cutting, and eating disorders.
            public let selfHarmIntent: Double
            /// Content that encourages performing acts of self-harm, such as suicide, cutting, and eating disorders, or that gives instructions or advice on how to commit such acts.
            public let selfHarmInstructions: Double
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Double
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexualMinors: Double
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Double
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violenceGraphic: Double

            public enum CodingKeys: String, CodingKey, CaseIterable {
                case harassment
                case harassmentThreatening = "harassment/threatening"
                case hate
                case hateThreatening = "hate/threatening"
                case selfHarm = "self-harm"
                case selfHarmIntent = "self-harm/intent"
                case selfHarmInstructions = "self-harm/instructions"
                case sexual
                case sexualMinors = "sexual/minors"
                case violence
                case violenceGraphic = "violence/graphic"
            }

            public func makeIterator() -> IndexingIterator<[(String, Bool)]> {
                return Mirror(reflecting: self).children.enumerated().map { (index, element) in
                    return (CodingKeys.allCases[index].stringValue, element.value) as! (String, Bool)
                }.makeIterator()
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
    public let results: [Self.Moderation]
}

extension ModerationsResult: Identifiable {}
