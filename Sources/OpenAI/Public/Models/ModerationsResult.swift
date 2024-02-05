//
//  ModerationsResult.swift
//  
//
//  Created by Aled Samuel on 10/04/2023.
//

import Foundation

public struct ModerationsResult: Codable, Equatable {
    
    public struct Moderation: Codable, Equatable {
        
        public struct Categories: Codable, Equatable {

            /// Content that expresses, incites, or promotes harassing language towards any target.
            public let harassment: Bool
            /// Harassment content that also includes violence or serious harm towards any target.
            public let harassment_threatening: Bool
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Bool
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hate_threatening: Bool
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let self_harm: Bool
            /// Content where the speaker expresses that they are engaging or intend to engage in acts of self-harm, such as suicide, cutting, and eating disorders.
            public let self_harm_intent: Bool
            /// Content that encourages performing acts of self-harm, such as suicide, cutting, and eating disorders, or that gives instructions or advice on how to commit such acts.
            public let self_harm_instructions: Bool
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Bool
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexual_minors: Bool
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Bool
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violence_graphic: Bool

            enum CodingKeys: String, CodingKey, CaseIterable {
                case harassment
                case harassment_threatening = "harassment/threatening"
                case hate
                case hate_threatening = "hate/threatening"
                case self_harm = "self-harm"
                case self_harm_intent = "self-harm/intent"
                case self_harm_instructions = "self-harm/instructions"
                case sexual
                case sexual_minors = "sexual/minors"
                case violence
                case violence_graphic = "violence/graphic"
            }
        }

        public struct CategoryScores: Codable, Equatable {

            /// Content that expresses, incites, or promotes harassing language towards any target.
            public let harassment: Double
            /// Harassment content that also includes violence or serious harm towards any target.
            public let harassment_threatening: Double
            /// Content that expresses, incites, or promotes hate based on race, gender, ethnicity, religion, nationality, sexual orientation, disability status, or caste.
            public let hate: Double
            /// Hateful content that also includes violence or serious harm towards the targeted group.
            public let hate_threatening: Double
            /// Content that promotes, encourages, or depicts acts of self-harm, such as suicide, cutting, and eating disorders.
            public let self_harm: Double
            /// Content where the speaker expresses that they are engaging or intend to engage in acts of self-harm, such as suicide, cutting, and eating disorders.
            public let self_harm_intent: Double
            /// Content that encourages performing acts of self-harm, such as suicide, cutting, and eating disorders, or that gives instructions or advice on how to commit such acts.
            public let self_harm_instructions: Double
            /// Content meant to arouse sexual excitement, such as the description of sexual activity, or that promotes sexual services (excluding sex education and wellness).
            public let sexual: Double
            /// Sexual content that includes an individual who is under 18 years old.
            public let sexual_minors: Double
            /// Content that promotes or glorifies violence or celebrates the suffering or humiliation of others.
            public let violence: Double
            /// Violent content that depicts death, violence, or serious physical injury in extreme graphic detail.
            public let violence_graphic: Double

            enum CodingKeys: String, CodingKey, CaseIterable {
                case harassment
                case harassment_threatening = "harassment/threatening"
                case hate
                case hate_threatening = "hate/threatening"
                case self_harm = "self-harm"
                case self_harm_intent = "self-harm/intent"
                case self_harm_instructions = "self-harm/instructions"
                case sexual
                case sexual_minors = "sexual/minors"
                case violence
                case violence_graphic = "violence/graphic"
            }
        }

        /// Collection of per-category binary usage policies violation flags. For each category, the value is true if the model flags the corresponding category as violated, false otherwise.
        public let categories: Categories
        /// Collection of per-category raw scores output by the model, denoting the model's confidence that the input violates the OpenAI's policy for the category. The value is between 0 and 1, where higher values denote higher confidence. The scores should not be interpreted as probabilities.
        public let category_scores: CategoryScores
        /// True if the model classifies the content as violating OpenAI's usage policies, false otherwise.
        public let flagged: Bool
    }

    public let id: String
    public let model: Model
    public let results: [Self.Moderation]
}

extension ModerationsResult: Identifiable {}
