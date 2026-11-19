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
            /// Content that includes instructions or advice that facilitate the planning or execution of wrongdoing, or that gives advice or instruction on how to commit illicit acts. Only returned by newer moderation models.
            public let illicit: Bool?
            /// Illicit content that also includes references to violence or procuring a weapon. Only returned by newer moderation models.
            public let illicitViolent: Bool?

            public init(harassment: Bool, harassmentThreatening: Bool, hate: Bool, hateThreatening: Bool, selfHarm: Bool, selfHarmIntent: Bool, selfHarmInstructions: Bool, sexual: Bool, sexualMinors: Bool, violence: Bool, violenceGraphic: Bool, illicit: Bool? = nil, illicitViolent: Bool? = nil) {
                self.harassment = harassment
                self.harassmentThreatening = harassmentThreatening
                self.hate = hate
                self.hateThreatening = hateThreatening
                self.selfHarm = selfHarm
                self.selfHarmIntent = selfHarmIntent
                self.selfHarmInstructions = selfHarmInstructions
                self.sexual = sexual
                self.sexualMinors = sexualMinors
                self.violence = violence
                self.violenceGraphic = violenceGraphic
                self.illicit = illicit
                self.illicitViolent = illicitViolent
            }

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
                case illicit
                case illicitViolent = "illicit/violent"
            }

            public func makeIterator() -> IndexingIterator<[(String, Bool)]> {
                var entries: [(String, Bool)] = [
                    (CodingKeys.harassment.stringValue, harassment),
                    (CodingKeys.harassmentThreatening.stringValue, harassmentThreatening),
                    (CodingKeys.hate.stringValue, hate),
                    (CodingKeys.hateThreatening.stringValue, hateThreatening),
                    (CodingKeys.selfHarm.stringValue, selfHarm),
                    (CodingKeys.selfHarmIntent.stringValue, selfHarmIntent),
                    (CodingKeys.selfHarmInstructions.stringValue, selfHarmInstructions),
                    (CodingKeys.sexual.stringValue, sexual),
                    (CodingKeys.sexualMinors.stringValue, sexualMinors),
                    (CodingKeys.violence.stringValue, violence),
                    (CodingKeys.violenceGraphic.stringValue, violenceGraphic)
                ]
                if let illicit {
                    entries.append((CodingKeys.illicit.stringValue, illicit))
                }
                if let illicitViolent {
                    entries.append((CodingKeys.illicitViolent.stringValue, illicitViolent))
                }
                return entries.makeIterator()
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
            /// Content that includes instructions or advice that facilitate the planning or execution of wrongdoing, or that gives advice or instruction on how to commit illicit acts. Only returned by newer moderation models.
            public let illicit: Double?
            /// Illicit content that also includes references to violence or procuring a weapon. Only returned by newer moderation models.
            public let illicitViolent: Double?

            public init(harassment: Double, harassmentThreatening: Double, hate: Double, hateThreatening: Double, selfHarm: Double, selfHarmIntent: Double, selfHarmInstructions: Double, sexual: Double, sexualMinors: Double, violence: Double, violenceGraphic: Double, illicit: Double? = nil, illicitViolent: Double? = nil) {
                self.harassment = harassment
                self.harassmentThreatening = harassmentThreatening
                self.hate = hate
                self.hateThreatening = hateThreatening
                self.selfHarm = selfHarm
                self.selfHarmIntent = selfHarmIntent
                self.selfHarmInstructions = selfHarmInstructions
                self.sexual = sexual
                self.sexualMinors = sexualMinors
                self.violence = violence
                self.violenceGraphic = violenceGraphic
                self.illicit = illicit
                self.illicitViolent = illicitViolent
            }

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
                case illicit
                case illicitViolent = "illicit/violent"
            }

            public func makeIterator() -> IndexingIterator<[(String, Double)]> {
                var entries: [(String, Double)] = [
                    (CodingKeys.harassment.stringValue, harassment),
                    (CodingKeys.harassmentThreatening.stringValue, harassmentThreatening),
                    (CodingKeys.hate.stringValue, hate),
                    (CodingKeys.hateThreatening.stringValue, hateThreatening),
                    (CodingKeys.selfHarm.stringValue, selfHarm),
                    (CodingKeys.selfHarmIntent.stringValue, selfHarmIntent),
                    (CodingKeys.selfHarmInstructions.stringValue, selfHarmInstructions),
                    (CodingKeys.sexual.stringValue, sexual),
                    (CodingKeys.sexualMinors.stringValue, sexualMinors),
                    (CodingKeys.violence.stringValue, violence),
                    (CodingKeys.violenceGraphic.stringValue, violenceGraphic)
                ]
                if let illicit {
                    entries.append((CodingKeys.illicit.stringValue, illicit))
                }
                if let illicitViolent {
                    entries.append((CodingKeys.illicitViolent.stringValue, illicitViolent))
                }
                return entries.makeIterator()
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
