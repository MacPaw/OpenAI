//
//  Models.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

import Foundation

public typealias Model = String
public extension Model {
    
    // Chat Completions
    
    /// More capable than any GPT-3.5 model, able to do more complex tasks, and optimized for chat. Will be updated with our latest model iteration 2 weeks after it is released.
    static let gpt4 = "gpt-4"

    /// GPT-4 Turbo, teh latest gpt-4 model with improved instruction following, JSON mode, reproducible outputs, parallel function calling and more.
    /// Maximum of 4096 output tokens
    static let gpt4_1106_preview = "gpt-4-1106-preview"

    /// Ability to understand images, in addition to all other GPT-4 Turbo capabilities.
    static let gpt4_vision_preview = "gpt-4-vision-preview"

    /// Snapshot of gpt-4 from March 14th 2023. Unlike gpt-4, this model will not receive updates, and will only be supported for a three month period ending on June 14th 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt4_0314 = "gpt-4-0314"
    /// Snapshot of gpt-4 from June 13th 2023 with function calling data. Unlike gpt-4, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt4_0613 = "gpt-4-0613"
    /// Same capabilities as the base gpt-4 mode but with 4x the context length. Will be updated with our latest model iteration.
    static let gpt4_32k = "gpt-4-32k"
    /// Snapshot of gpt-4-32 from March 14th 2023. Unlike gpt-4-32k, this model will not receive updates, and will only be supported for a three month period ending on June 14th 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt4_32k_0314 = "gpt-4-32k-0314"
    /// Snapshot of gpt-4-32 from June 13th 2023. Unlike gpt-4-32k, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt4_32k_0613 = "gpt-4-32k-0613"

    /// The latest GPT-3.5 Turbo model with improved instruction following, JSON mode, reproducible outputs, parallel function calling and more.
    static let gpt3_5Turbo_1106 = "gpt-3.5-turbo-1106"

    /// Most capable GPT-3.5 model and optimized for chat at 1/10th the cost of text-davinci-003. Will be updated with our latest model iteration.
    static let gpt3_5Turbo = "gpt-3.5-turbo"
    /// Snapshot of gpt-3.5-turbo from March 1st 2023. Unlike gpt-3.5-turbo, this model will not receive updates, and will only be supported for a three month period ending on June 1st 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt3_5Turbo0301 = "gpt-3.5-turbo-0301"
    /// Snapshot of gpt-3.5-turbo from June 13th 2023 with function calling data. Unlike gpt-3.5-turbo, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt3_5Turbo0613 = "gpt-3.5-turbo-0613"
    /// Same capabilities as the standard gpt-3.5-turbo model but with 4 times the context.
    static let gpt3_5Turbo_16k = "gpt-3.5-turbo-16k"
    /// Snapshot of gpt-3.5-turbo-16k from June 13th 2023. Unlike gpt-3.5-turbo-16k, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt3_5Turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"

    // Completions
    
    /// Can do any language task with better quality, longer output, and consistent instruction-following than the curie, babbage, or ada models. Also supports inserting completions within text.
    static let textDavinci_003 = "text-davinci-003"
    /// Similar capabilities to text-davinci-003 but trained with supervised fine-tuning instead of reinforcement learning.
    static let textDavinci_002 = "text-davinci-002"
    /// Very capable, faster and lower cost than Davinci.
    static let textCurie = "text-curie-001"
    /// Capable of straightforward tasks, very fast, and lower cost.
    static let textBabbage = "text-babbage-001"
    /// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.
    static let textAda = "text-ada-001"
    
    // Edits
    
    static let textDavinci_001 = "text-davinci-001"
    static let codeDavinciEdit_001 = "code-davinci-edit-001"
    
    // Speech
    
    /// The latest text to speech model, optimized for speed.
    static let tts_1 = "tts-1"
    /// The latest text to speech model, optimized for quality.
    static let tts_1_hd = "tts-1-hd"
    
    // Transcriptions / Translations
    
    static let whisper_1 = "whisper-1"

    // Image Generation
    static let dall_e_2 = "dall-e-2"
    static let dall_e_3 = "dall-e-3"
    
    // Fine Tunes
    
    /// Most capable GPT-3 model. Can do any task the other models can do, often with higher quality.
    static let davinci = "davinci"
    /// Very capable, but faster and lower cost than Davinci.
    static let curie = "curie"
    /// Capable of straightforward tasks, very fast, and lower cost.
    static let babbage = "babbage"
    /// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.
    static let ada = "ada"
    
    // Embeddings
    
    static let textEmbeddingAda = "text-embedding-ada-002"
    static let textSearchAda = "text-search-ada-doc-001"
    static let textSearchBabbageDoc = "text-search-babbage-doc-001"
    static let textSearchBabbageQuery001 = "text-search-babbage-query-001"
    
    // Moderations
    
    /// Almost as capable as the latest model, but slightly older.
    static let textModerationStable = "text-moderation-stable"
    /// Most capable moderation model. Accuracy will be slightly higher than the stable model.
    static let textModerationLatest = "text-moderation-latest"
    static let moderation = "text-moderation-001"
}
