//
//  Models.swift
//
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

public enum ChatModel: String, Codable, CaseIterable {
    /// The latest GPT-3.5 Turbo model with improved instruction following, JSON mode, reproducible outputs, parallel function calling, and more. Returns a maximum of 4,096 output tokens.
    case gpt_3_5_turbo_1106 = "gpt-3.5-turbo-1106" // system
    /// Currently points to gpt-3.5-turbo-0613.
    case gpt_3_5_turbo = "gpt-3.5-turbo" // openai
    /// Currently points to gpt-3.5-turbo-0613.
    case gpt_3_5_turbo_16k = "gpt-3.5-turbo-16k" // openai-internal
    // Will be deprecated on June 13, 2024.
//    /// Snapshot of gpt-3.5-turbo from June 13th 2023. Will be deprecated on June 13, 2024.
//    case gpt_3_5_turbo_0613 = "gpt-3.5-turbo-0613" // openai
//    /// Snapshot of gpt-3.5-16k-turbo from June 13th 2023. Will be deprecated on June 13, 2024.
//    case gpt_3_5_turbo_16k_0613 = "gpt-3.5-turbo-16k-0613" // openai
//    /// Snapshot of gpt-3.5-turbo from March 1st 2023. Will be deprecated on June 13th 2024.
//    case gpt_3_5_turbo_0301 = "gpt-3.5-turbo-0301" // openai

//    /// The latest GPT-4 model with improved instruction following, JSON mode, reproducible outputs, parallel function calling, and more. Returns a maximum of 4,096 output tokens. This preview model is not yet suited for production traffic.
//    case gpt_4_1106_preview = "gpt-4-1106-preview" // -- "ChatGPT Plus" SUBSCRIPTION ONLY
//    /// Ability to understand images, in addition to all other GPT-4 Turbo capabilties. Returns a maximum of 4,096 output tokens. This is a preview model version and not suited yet for       production traffic.
//    case gpt_4_vision_preview = "gpt-4-vision-preview" // -- "ChatGPT Plus" SUBSCRIPTION ONLY
//    /// Currently points to gpt-4-0613.
//    case gpt_4 = "gpt-4"
//    /// Currently points to gpt-4-32k-0613.
//    case gpt_4_32k = "gpt-4-32k" // -- "ChatGPT Plus" SUBSCRIPTION ONLY
//    /// Snapshot of gpt-4 from June 13th 2023 with improved function calling support.
//    case gpt_4_0613 = "gpt-4-0613" // -- "ChatGPT Plus" SUBSCRIPTION ONLY
//    /// Snapshot of gpt-4-32k from June 13th 2023 with improved function calling support.
//    case gpt_4_32k_0613 = "gpt-4-32k-0613" // -- "ChatGPT Plus" SUBSCRIPTION ONLY
}

public enum ImageModel: String, Codable, CaseIterable {
    /// The previous DALL·E model released in Nov 2022. The 2nd iteration of DALL·E with more realistic, accurate, and 4x greater resolution images than the original model.
    case dall_e_2 = "dall-e-2" // system
//    /// The latest DALL·E model released in Nov 2023.
//    case dall_e_3 = "dall-e-3" // system -- "ChatGPT Plus" SUBSCRIPTION ONLY, ImageGenerateParams only
}

public enum SpeechModel: String, Codable, CaseIterable {
    /// The latest text to speech model, optimized for speed.
    case tts_1 = "tts-1" // openai-internal
    /// The latest text to speech model, optimized for quality.
    case tts_1_hd = "tts-1-hd" // system
}

public enum AudioTranslationModel: String, Codable, CaseIterable {
    case whisper_1 = "whisper-1" // openai-internal
}
public enum AudioTranscriptionModel: String, Codable, CaseIterable {
    case whisper_1 = "whisper-1" // openai-internal
}

public enum EmbeddingsModel: String, Codable, CaseIterable {
    case text_embedding_ada_002 = "text-embedding-ada-002" // openai-internal
//    case text_embedding_ada_002_v2 = "text-embedding-ada-002-v2" // UNLISTED AT MODEL ENDPOINT; GETS RETURNED WHEN ABOVE IS USED, BUT CANNOT BE SPECIFIED
}

public enum ModerationsModel: String, Codable, CaseIterable {
    case textModerationStable = "text-moderation-stable" // UNLISTED AT MODEL ENDPOINT -- text-moderation-005 RETURNED BY ENDPOINT
    case textModerationLatest = "text-moderation-latest" // UNLISTED AT MODEL ENDPOINT -- text-moderation-006 RETURNED BY ENDPOINT
}
