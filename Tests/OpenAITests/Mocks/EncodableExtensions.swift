//
//  EncodableExtensions.swift
//
//
//  Created by James J Kalafus on 2024-02-14.
//

import OpenAI

extension APIError: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.message, forKey: .message)
        try container.encode(self.type, forKey: .type)
        try container.encodeIfPresent(self.param, forKey: .param)
        try container.encodeIfPresent(self.code, forKey: .code)
    }
}

extension CompletionsResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.object, forKey: .object)
        try container.encode(self.created, forKey: .created)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.choices, forKey: .choices)
        try container.encodeIfPresent(self.usage, forKey: .usage)
    }
}

extension CompletionsResult.Choice: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.index, forKey: .index)
        try container.encodeIfPresent(self.finishReason, forKey: .finishReason)
    }
}

extension CompletionsResult.Usage: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.promptTokens, forKey: .promptTokens)
        try container.encode(self.completionTokens, forKey: .completionTokens)
        try container.encode(self.totalTokens, forKey: .totalTokens)
    }
}

extension ChatResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.object, forKey: .object)
        try container.encode(self.created, forKey: .created)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.choices, forKey: .choices)
        try container.encodeIfPresent(self.usage, forKey: .usage)
        try container.encodeIfPresent(self.systemFingerprint, forKey: .systemFingerprint)
    }
}

extension ChatResult.Choice: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.index, forKey: .index)
        try container.encodeIfPresent(self.logprobs, forKey: .logprobs)
        try container.encode(self.message, forKey: .message)
        try container.encodeIfPresent(self.finishReason, forKey: .finishReason)
    }
}

extension ChatResult.Choice.ChoiceLogprobs: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.content, forKey: .content)
    }
}

extension ChatResult.Choice.ChoiceLogprobs.ChatCompletionTokenLogprob: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.token, forKey: .token)
        try container.encodeIfPresent(self.bytes, forKey: .bytes)
        try container.encode(self.logprob, forKey: .logprob)
        try container.encode(self.topLogprobs, forKey: .topLogprobs)
    }
}

extension ChatResult.Choice.ChoiceLogprobs.ChatCompletionTokenLogprob.TopLogprob: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.token, forKey: .token)
        try container.encodeIfPresent(self.bytes, forKey: .bytes)
        try container.encode(self.logprob, forKey: .logprob)
    }
}

extension ChatResult.CompletionUsage: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.promptTokens, forKey: .promptTokens)
        try container.encode(self.completionTokens, forKey: .completionTokens)
        try container.encode(self.totalTokens, forKey: .totalTokens)
    }
}

extension EditsResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.object, forKey: .object)
        try container.encode(self.created, forKey: .created)
        try container.encode(self.choices, forKey: .choices)
        try container.encode(self.usage, forKey: .usage)
    }
}

extension EditsResult.Choice: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.text, forKey: .text)
        try container.encode(self.index, forKey: .index)
    }
}

extension EditsResult.Usage: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.promptTokens, forKey: .promptTokens)
        try container.encode(self.completionTokens, forKey: .completionTokens)
        try container.encode(self.totalTokens, forKey: .totalTokens)
    }
}

extension EmbeddingsResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.usage, forKey: .usage)
        try container.encode(self.object, forKey: .object)
    }
}

extension EmbeddingsResult.Embedding: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.object, forKey: .object)
        try container.encode(self.embedding, forKey: .embedding)
        try container.encode(self.index, forKey: .index)
    }
}

extension EmbeddingsResult.Usage: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.promptTokens, forKey: .promptTokens)
        try container.encode(self.totalTokens, forKey: .totalTokens)
    }
}

extension ImagesResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.created, forKey: .created)
        try container.encode(self.data, forKey: .data)
    }
}

extension ImagesResult.Image: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.url, forKey: .url)
        try container.encodeIfPresent(self.revisedPrompt, forKey: .revisedPrompt)
        try container.encodeIfPresent(self.b64Json, forKey: .b64Json)
    }
}

extension ModelResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.created, forKey: .created)
        try container.encode(self.object, forKey: .object)
        try container.encode(self.ownedBy, forKey: .ownedBy)
    }
}

extension ModelsResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.data, forKey: .data)
        try container.encode(self.object, forKey: .object)
    }
}

extension ModerationsResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.model, forKey: .model)
        try container.encode(self.results, forKey: .results)
    }
}

extension ModerationsResult.CategoryResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.categories, forKey: .categories)
        try container.encode(self.categoryScores, forKey: .categoryScores)
        try container.encode(self.flagged, forKey: .flagged)
    }
}

extension ModerationsResult.CategoryResult.Categories: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.hate, forKey: .hate)
        try container.encode(self.hateThreatening, forKey: .hateThreatening)
        try container.encode(self.selfHarm, forKey: .selfHarm)
        try container.encode(self.sexual, forKey: .sexual)
        try container.encode(self.sexualMinors, forKey: .sexualMinors)
        try container.encode(self.violence, forKey: .violence)
        try container.encode(self.violenceGraphic, forKey: .violenceGraphic)
    }
}

extension ModerationsResult.CategoryResult.CategoryScores: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.hate, forKey: .hate)
        try container.encode(self.hateThreatening, forKey: .hateThreatening)
        try container.encode(self.selfHarm, forKey: .selfHarm)
        try container.encode(self.sexual, forKey: .sexual)
        try container.encode(self.sexualMinors, forKey: .sexualMinors)
        try container.encode(self.violence, forKey: .violence)
        try container.encode(self.violenceGraphic, forKey: .violenceGraphic)
    }
}

extension AudioTranscriptionResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.text, forKey: .text)
    }
}

extension AudioTranslationResult: Encodable {

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.text, forKey: .text)
    }
}
