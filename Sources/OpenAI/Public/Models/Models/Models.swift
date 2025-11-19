//
//  Models.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 12/19/22.
//

/// Defines all available OpenAI models supported by the library.
public typealias Model = String

public extension Model {
    
    // MARK: - Reasoning Models
    // o-series models that excel at complex, multi-step tasks.
    
    // MARK: o4 series
    /// Faster, more affordable reasoning model
    ///
    /// o4-mini is our latest small o-series model. It's optimized for fast, effective reasoning with exceptionally efficient performance in coding and visual tasks.
    ///
    /// Learn more about how to use our reasoning models in our [reasoning](https://platform.openai.com/docs/guides/reasoning) guide.
    static let o4_mini = "o4-mini"
    
    // MARK: o3 series
    /// OpenAI's most powerful reasoning model
    ///
    /// o3 is a well-rounded and powerful model across domains. It sets a new standard for math, science, coding, and visual reasoning tasks. It also excels at technical writing and instruction-following. Use it to think through multi-step problems that involve analysis across text, code, and images.
    ///
    /// Learn more about how to use our reasoning models in the [reasoning](https://platform.openai.com/docs/guides/reasoning) guide.
    static let o3 = "o3"
    
    /// `o3-mini`: small reasoning model providing high intelligence at the same cost and latency targets of o1-mini.
    static let o3_mini = "o3-mini"
    
    // MARK: o1 series
    // The o1 series of models are trained with reinforcement learning to perform complex reasoning. o1 models think before they answer, producing a long internal chain of thought before responding to the user.
    
    /// `o1`: reasoning model designed to solve hard problems across domains
    static let o1 = "o1"
    
    /// `o1-mini`: fast and affordable reasoning model for specialized tasks
    @available(*, deprecated, message: "On April 28th, 2025, developers using o1-preview and o1-mini were notified of these models deprecations and removal from the API in three months and six months respectively. Recommended replacement for o1-mini: o4-mini")
    static let o1_mini = "o1-mini"
    
    /// `o1-pro`: A version of o1 with more compute for better responses
    static let o1_pro = "o1-pro"
    
    // MARK: - Flagship chat models
    // OpenAI's versatile, high-intelligence flagship models.
    
    /// `gpt-4.5-preview`: Largest and most capable GPT model
    /// https://platform.openai.com/docs/models/gpt-4.5-preview
    @available(*, deprecated, message: "On April 14th, 2025, developers were notified that the gpt-4.5-preview model is deprecated and will be removed from the API in the coming months. Recommended replacement: gpt-4.1")
    static let gpt4_5_preview = "gpt-4.5-preview"

    // GPT-5.1

    /// `gpt-5.1` Enhanced version of GPT-5 with improved reasoning and performance
    static let gpt5_1 = "gpt-5.1"

    /// `gpt-5.1-chat-latest` Latest GPT-5.1 model optimized for chat interactions
    static let gpt5_1_chat_latest = "gpt-5.1-chat-latest"

    // GPT-5

    /// `gpt-5` OpenAI's best AI system with significant leap in intelligence, designed for logic and multi-step tasks with deep reasoning
    static let gpt5 = "gpt-5"

    /// `gpt-5-mini` Lightweight GPT-5 version for cost-sensitive applications
    static let gpt5_mini = "gpt-5-mini"

    /// `gpt-5-nano` Optimized for ultra-low latency and fast execution
    static let gpt5_nano = "gpt-5-nano"

    /// `gpt-5-chat` Built for advanced, natural, multimodal conversations
    static let gpt5_chat = "gpt-5-chat"

    // GPT-4.1

    /// `gpt-4.1` Smartest model for complex tasks
    static let gpt4_1 = "gpt-4.1"

    /// `gpt-4.1-mini` Affordable model balancing speed and intelligence
    static let gpt4_1_mini = "gpt-4.1-mini"

    /// `gpt-4.1-nano` Fastest, most cost-effective model for low-latency tasks
    static let gpt4_1_nano = "gpt-4.1-nano"

    // GPT-4

    /// `gpt-4o`, currently the most advanced, multimodal flagship model that's cheaper and faster than GPT-4 Turbo.
    static let gpt4_o = "gpt-4o"
    
    /// `gpt-4o-audio-preview`, this is a preview release of the GPT-4o Audio models. These models accept audio inputs and outputs, and can be used in the Chat Completions REST API.
    static let gpt_4o_audio_preview = "gpt-4o-audio-preview"
    
    /// `chatgpt-4o-latest`: GPT-4o model used in ChatGPT
    ///
    /// https://platform.openai.com/docs/models/chatgpt-4o-latest
    static let chatgpt_4o_latest = "chatgpt-4o-latest"
    
    // MARK: - Cost-optimized models
    // Smaller, faster models that cost less to run.
    
    /// `gpt-4o-mini`: Currently the most affordable and intelligent model for fast and lightweight requests.
    static let gpt4_o_mini = "gpt-4o-mini"

    /// `gpt-4o-mini-audio-preview`, this is a preview release of the smaller GPT-4o Audio mini model. It's designed to input audio or create audio outputs via the REST API.
    static let gpt_4o_mini_audio_preview = "gpt-4o-mini-audio-preview"

    // MARK: - Realtime models
    // Models capable of realtime text and audio inputs and outputs.
    
    /// GPT-4o Realtime: Model capable of realtime text and audio inputs and outputs
    ///
    ///`gpt-4o-realtime-preview`
    ///
    /// This is a preview release of the GPT-4o Realtime model, capable of responding to audio and text inputs in realtime over WebRTC or a WebSocket interface.
    static let gpt_4o_realtime_preview = "gpt-4o-realtime-preview"
    
    /// GPT-4o mini Realtime: Smaller realtime model for text and audio inputs and outputs
    ///
    /// `gpt-4o-mini-realtime-preview`
    ///
    /// This is a preview release of the GPT-4o-mini Realtime model, capable of responding to audio and text inputs in realtime over WebRTC or a WebSocket interface.
    static let gpt_4o_mini_realtime_preview = "gpt-4o-mini-realtime-preview"
    
    // MARK: - Older GPT models
    // Supported older versions of our general purpose and chat models.
    
    // MARK: GPT-4 Turbo
    
    /// `gpt-4-turbo`, The latest GPT-4 Turbo model with vision capabilities. Vision requests can now use JSON mode and function calling and more. Context window: 128,000 tokens
    static let gpt4_turbo = "gpt-4-turbo"
    
    /// Snapshot of `gpt-4-turbo-preview` from January 25th 2024. This model reduces cases of “laziness” where the model doesn’t complete a task. Also fixes the bug impacting non-English UTF-8 generations. Maximum of 4096 output tokens
    static let gpt4_0125_preview = "gpt-4-0125-preview"
    
    /// Snapshot of `gpt-4-turbo-preview` from November 6th 2023. Improved instruction following, JSON mode, reproducible outputs, parallel function calling and more. Maximum of 4096 output tokens
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt4_1106_preview = "gpt-4-1106-preview"
    
    // MARK: GPT-4
    
    /// Most capable `gpt-4` model, outperforms any GPT-3.5 model, able to do more complex tasks, and optimized for chat.
    static let gpt4 = "gpt-4"
    
    /// Snapshot of `gpt-4` from June 13th 2023 with function calling data. Unlike `gpt-4`, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt4_0613 = "gpt-4-0613"
    
    /// Snapshot of `gpt-4` from March 14th 2023. Unlike gpt-4, this model will not receive updates, and will only be supported for a three month period ending on June 14th 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt4_0314 = "gpt-4-0314"
    
    /// Same capabilities as the base `gpt-4` model but with 4x the context length. Will be updated with our latest model iteration.
    static let gpt4_32k = "gpt-4-32k"
    
    /// Snapshot of `gpt-4-32k` from June 13th 2023. Unlike `gpt-4-32k`, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt4_32k_0613 = "gpt-4-32k-0613"
    
    /// Snapshot of `gpt-4-32k` from March 14th 2023. Unlike `gpt-4-32k`, this model will not receive updates, and will only be supported for a three month period ending on June 14th 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt4_32k_0314 = "gpt-4-32k-0314"

    // MARK: GPT-3.5
    
    /// Most capable `gpt-3.5-turbo` model and optimized for chat. Will be updated with our latest model iteration.
    static let gpt3_5Turbo = "gpt-3.5-turbo"
    
    /// Snapshot of `gpt-3.5-turbo` from January 25th 2024. Decreased prices by 50%. Various improvements including higher accuracy at responding in requested formats and a fix for a bug which caused a text encoding issue for non-English language function calls.
    static let gpt3_5Turbo_0125 = "gpt-3.5-turbo-0125"
    
    /// Snapshot of `gpt-3.5-turbo` from November 6th 2023. The latest `gpt-3.5-turbo` model with improved instruction following, JSON mode, reproducible outputs, parallel function calling and more.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt3_5Turbo_1106 = "gpt-3.5-turbo-1106"
    
    /// Snapshot of `gpt-3.5-turbo` from June 13th 2023 with function calling data. Unlike `gpt-3.5-turbo`, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt3_5Turbo_0613 = "gpt-3.5-turbo-0613"
    
    /// Snapshot of `gpt-3.5-turbo` from March 1st 2023. Unlike `gpt-3.5-turbo`, this model will not receive updates, and will only be supported for a three month period ending on June 1st 2023.
    @available(*, deprecated, message: "Please upgrade to the newer model")
    static let gpt3_5Turbo_0301 = "gpt-3.5-turbo-0301"
    
    /// Same capabilities as the standard `gpt-3.5-turbo` model but with 4 times the context.
    static let gpt3_5Turbo_16k = "gpt-3.5-turbo-16k"
    
    /// Snapshot of `gpt-3.5-turbo-16k` from June 13th 2023. Unlike `gpt-3.5-turbo-16k`, this model will not receive updates, and will be deprecated 3 months after a new version is released.
    static let gpt3_5Turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"
    
    // MARK: - Speech
    
    /// A text-to-speech model built on GPT-4o mini, a fast and powerful language model.
    static let gpt_4o_mini_tts = "gpt-4o-mini-tts"
    /// tts-1 model is optimized for realtime text-to-speech use cases
    static let tts_1 = "tts-1"
    /// tts-1-hd model is optimized for high quality text-to-speech use cases.
    static let tts_1_hd = "tts-1-hd"
    
    // MARK: - Transcriptions / Translations

    /// Whisper is a general-purpose speech recognition model, trained on a large dataset of diverse audio. You can also use it as a multitask model to perform multilingual speech recognition as well as speech translation and language identification.
    static let whisper_1 = "whisper-1"
    /// GPT-4o Transcribe is a speech-to-text model that uses GPT-4o to transcribe audio. It offers improvements to word error rate and better language recognition and accuracy compared to original Whisper models. Use it for more accurate transcripts.
    static let gpt_4o_transcribe = "gpt-4o-transcribe"
    /// GPT-4o mini Transcribe is a speech-to-text model that uses GPT-4o mini to transcribe audio. It offers improvements to word error rate and better language recognition and accuracy compared to original Whisper models. Use it for more accurate transcripts.
    static let gpt_4o_mini_transcribe = "gpt-4o-mini-transcribe"

    // MARK: - Image Generation
    
    static let dall_e_2 = "dall-e-2"
    static let dall_e_3 = "dall-e-3"
    static let gpt_image_1 = "gpt-image-1"

    // MARK: - Fine Tunes
    
    /// Most capable GPT-3 model. Can do any task the other models can do, often with higher quality.
    static let davinci = "davinci"
    /// Very capable, but faster and lower cost than Davinci.
    static let curie = "curie"
    /// Capable of straightforward tasks, very fast, and lower cost.
    static let babbage = "babbage"
    /// Capable of very simple tasks, usually the fastest model in the GPT-3 series, and lowest cost.
    static let ada = "ada"
    
    // MARK: - Embeddings
    
    static let textEmbeddingAda = "text-embedding-ada-002"
    static let textSearchAda = "text-search-ada-doc-001"
    static let textSearchBabbageDoc = "text-search-babbage-doc-001"
    static let textSearchBabbageQuery001 = "text-search-babbage-query-001"
    static let textEmbedding3 = "text-embedding-3-small"
    static let textEmbedding3Large = "text-embedding-3-large"
    
    // MARK: - Moderations
    
    /// Almost as capable as the latest model, but slightly older.
    static let textModerationStable = "text-moderation-stable"
    /// Most capable moderation model. Accuracy will be slightly higher than the stable model.
    static let textModerationLatest = "text-moderation-latest"
    static let moderation = "text-moderation-007"
    
    // MARK: - Tool-specific models
    // Models to support specific built-in tools.
    
    /// GPT model for web search in Chat Completions
    ///
    /// GPT-4o Search Preview is a specialized model trained to understand and execute [web search](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat) queries with the Chat Completions API. In addition to token fees, web search queries have a fee per tool call. Learn more in the [pricing](https://platform.openai.com/docs/pricing) page.
    static let gpt_4o_search_preview = "gpt-4o-search-preview"
    
    /// Fast, affordable small model for web search
    ///
    /// GPT-4o mini Search Preview is a specialized model trained to understand and execute [web search](https://platform.openai.com/docs/guides/tools-web-search?api-mode=chat) queries with the Chat Completions API. In addition to token fees, web search queries have a fee per tool call. Learn more in the [pricing](https://platform.openai.com/docs/pricing) page.
    static let gpt_4o_mini_search_preview = "gpt-4o-mini-search-preview"
    
    /// computer-use-preview: Specialized model for computer use tool
    ///
    /// `computer-use-preview`
    ///
    /// The computer-use-preview model is a specialized model for the computer use tool. It is trained to understand and execute computer tasks. See the computer use guide for more information. This model is only usable in the Responses API.
    ///
    /// Computer use guide: https://platform.openai.com/docs/assistants/tools-computer-use
    ///
    /// Responses API: https://platform.openai.com/docs/api-reference/responses
    static let computer_use_preview = "computer-use-preview"
    
    static func allModels(satisfying filter: Filter) -> Set<Model> {
        let chatCompletionsEndpoint: Set<Model> = [
            // reasoning
            .o4_mini, o3, o3_mini, .o1,
            // flagship
            .gpt5, .gpt5_mini, .gpt5_nano, .gpt5_chat, .gpt5_1, .gpt5_1_chat_latest, .gpt4_1, .gpt4_o, .gpt_4o_audio_preview, chatgpt_4o_latest,
            // cost-optimized
            .gpt4_1_mini, .gpt4_1_nano, .gpt4_o_mini, .gpt_4o_mini_audio_preview,
            // tool-specific
            .gpt_4o_search_preview, .gpt_4o_mini_search_preview,
            // older
            .gpt4_turbo, .gpt4, .gpt3_5Turbo
        ]
        
        let responsesEndpoint: Set<Model> = [
            // reasoning
            .o4_mini, .o3, .o3_mini, .o1, .o1_pro,
            // flagship
            .gpt5, .gpt5_mini, .gpt5_nano, .gpt5_chat, .gpt5_1, .gpt5_1_chat_latest, .gpt4_1, .gpt4_o, .chatgpt_4o_latest,
            // cost-optimized
            .gpt4_1_mini, .gpt4_1_nano, .gpt4_o_mini,
            .gpt4_turbo, .gpt4, .gpt3_5Turbo,
            .computer_use_preview
        ]
        
        let allModels = chatCompletionsEndpoint.union(responsesEndpoint)
        
        var final: Set<Model> = allModels
        
        for endpoint in filter.supportedEndpoints {
            switch endpoint {
            case .chatCompletions:
                final.formIntersection(chatCompletionsEndpoint)
            case .responses:
                final.formIntersection(responsesEndpoint)
            }
        }
        
        return final
    }
    
    struct Filter {
        enum Modality {}
        
        public enum Endpoint {
            case chatCompletions
            case responses
        }
        
        enum Feature {}
        
        public let supportedEndpoints: [Endpoint]
        
        public init(supportedEndpoints: [Endpoint]) {
            self.supportedEndpoints = supportedEndpoints
        }
    }
}
