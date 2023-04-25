# OpenAI

![logo](https://user-images.githubusercontent.com/1411778/218319355-f56b6bd4-961a-4d8f-82cd-6dbd43111d7f.png)

___

![Swift Workflow](https://github.com/MacPaw/OpenAI/actions/workflows/swift.yml/badge.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![Twitter](https://img.shields.io/static/v1?label=Twitter&message=@MacPaw&color=CA1F67)](https://twitter.com/MacPaw)

This repository contains Swift community-maintained implementation over [OpenAI](https://platform.openai.com/docs/api-reference/) public API. 

- [What is OpenAI](#what-is-openai)
- [Installation](#installation)
- [Usage](#usage)
    - [Initialization](#initialization)
    - [Completions](#completions)
    - [Chats](#chats)
    - [Images](#images)
        - [Create Image](#create-image)
        - [Create Image Edit](#create-image-edit)
        - [Create Image Variation](#create-image-variation)
    - [Audio](#audio)
        - [Audio Transcriptions](#audio-transcriptions)
        - [Audio Translations](#audio-translations)
    - [Edits](#edits)
    - [Embeddings](#embeddings)
    - [Models](#models)
        - [List Models](#list-models)
        - [Retrieve Model](#retrieve-model)
    - [Moderations](#moderations)
    - [Utilities](#utilities)
    - [Combine Extensions](#combine-extensions)
- [Example Project](#example-project)
- [Links](#links)
- [License](#license)

## What is OpenAI

OpenAI is a non-profit artificial intelligence research organization founded in San Francisco, California in 2015. It was created with the purpose of advancing digital intelligence in ways that benefit humanity as a whole and promote societal progress. The organization strives to develop AI (Artificial Intelligence) programs and systems that can think, act and adapt quickly on their own – autonomously. OpenAI's mission is to ensure safe and responsible use of AI for civic good, economic growth and other public benefits; this includes cutting-edge research into important topics such as general AI safety, natural language processing, applied reinforcement learning methods, machine vision algorithms etc.

>The OpenAI API can be applied to virtually any task that involves understanding or generating natural language or code. We offer a spectrum of models with different levels of power suitable for different tasks, as well as the ability to fine-tune your own custom models. These models can be used for everything from content generation to semantic search and classification.

## Installation

OpenAI is available with Swift Package Manager.
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.
Once you have your Swift package set up, adding OpenAI as a dependency is as easy as adding it to the dependencies value of your Package.swift.

```swift
dependencies: [
    .package(url: "https://github.com/MacPaw/OpenAI.git", branch: "main")
]
```

## Usage

### Initialization

To initialize API instance you need to [obtain](https://platform.openai.com/account/api-keys) API token from your Open AI organization.

**Remember that your API key is a secret!** Do not share it with others or expose it in any client-side code (browsers, apps). Production requests must be routed through your own backend server where your API key can be securely loaded from an environment variable or key management service.

<img width="1081" alt="company" src="https://user-images.githubusercontent.com/1411778/213204726-0772373e-14db-4d5d-9a58-bc249bac4c57.png">

Once you have a token, you can initialize `OpenAI` class, which is an entry point to the API.

```swift
let openAI = OpenAI(apiToken: "YOUR_TOKEN_HERE")
```

Optionally you can initialize `OpenAI` with token, organization identifier and timeoutInterval.

```swift
let configuration = OpenAI.Configuration(token: "YOUR_TOKEN_HERE", organizationIdentifier: "YOUR_ORGANIZATION_ID_HERE", timeoutInterval: 60.0)
let openAI = OpenAI(configuration: configuration)
```

Once token you posses the token, and the instance is initialized you are ready to make requests.

### Completions

Given a prompt, the model will return one or more predicted completions, and can also return the probabilities of alternative tokens at each position.

**Request**

```swift
struct CompletionsQuery: Codable {
    /// ID of the model to use.
    public let model: Model
    /// The prompt(s) to generate completions for, encoded as a string, array of strings, array of tokens, or array of token arrays.
    public let prompt: String
    /// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.
    public let temperature: Double?
    /// The maximum number of tokens to generate in the completion.
    public let maxTokens: Int?
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let topP: Double?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    public let frequencyPenalty: Double?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    public let presencePenalty: Double?
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    public let stop: [String]?
    /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
    public let user: String?
}
```

**Response**

```swift
struct CompletionsResult: Codable, Equatable {
    public struct Choice: Codable, Equatable {
        public let text: String
        public let index: Int
    }

    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage
}
```
**Example**

```swift
let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, max_tokens: 100, top_p: 1, frequency_penalty: 0, presence_penalty: 0, stop: ["\\n"])
openAI.completions(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.completions(query: query)
```

```
(lldb) po result
▿ CompletionsResult
  - id : "cmpl-6P9be2p2fQlwB7zTOl0NxCOetGmX3"
  - object : "text_completion"
  - created : 1671453146.0
  - model : OpenAI.Model.textDavinci_003
  ▿ choices : 1 element
    ▿ 0 : Choice
      - text : "\n\n42 is the answer to the ultimate question of life, the universe, and everything, according to the book The Hitchhiker\'s Guide to the Galaxy."
      - index : 0
```

Review [Completions Documentation](https://platform.openai.com/docs/api-reference/completions) for more info.

### Chats

Using the OpenAI Chat API, you can build your own applications with `gpt-3.5-turbo` to do things like:

* Draft an email or other piece of writing
* Write Python code
* Answer questions about a set of documents
* Create conversational agents
* Give your software a natural language interface
* Tutor in a range of subjects
* Translate languages
* Simulate characters for video games and much more

**Request**

```swift
 struct ChatQuery: Codable {
     /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
     public let model: Model
     /// The messages to generate chat completions for
     public let messages: [Chat]
     /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and  We generally recommend altering this or top_p but not both.
     public let temperature: Double?
     /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
     public let topP: Double?
     /// How many chat completion choices to generate for each input message.
     public let n: Int?
     /// If set, partial message deltas will be sent, like in ChatGPT. Tokens will be sent as data-only `server-sent events` as they become available, with the stream terminated by a data: [DONE] message.
     public let stream: Bool?
     /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
     public let stop: [String]?
     /// The maximum number of tokens to generate in the completion.
     public let maxTokens: Int?
     /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
     public let presencePenalty: Double?
     /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
     public let frequencyPenalty: Double?
     ///Modify the likelihood of specified tokens appearing in the completion.
     public let logitBias: [String:Int]?
     /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
     public let user: String?
}
```

**Response**

```swift
struct ChatResult: Codable, Equatable {
    public struct Choice: Codable, Equatable {
        public let index: Int
        public let message: Chat
        public let finishReason: String
    }
    
    public struct Usage: Codable, Equatable {
        public let promptTokens: Int
        public let completionTokens: Int
        public let totalTokens: Int
    }
    
    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
    public let usage: Usage
}
```

**Example**

```swift
let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: .user, content: "who are you")])
let result = try await openAI.chats(query: query)
```

```
(lldb) po result
▿ ChatResult
  - id : "chatcmpl-6pwjgxGV2iPP4QGdyOLXnTY0LE3F8"
  - object : "chat.completion"
  - created : 1677838528.0
  - model : "gpt-3.5-turbo-0301"
  ▿ choices : 1 element
    ▿ 0 : Choice
      - index : 0
      ▿ message : Chat
        - role : "assistant"
        - content : "\n\nI\'m an AI language model developed by OpenAI, created to provide assistance and support for various tasks such as answering questions, generating text, and providing recommendations. Nice to meet you!"
      - finish_reason : "stop"
  ▿ usage : Usage
    - prompt_tokens : 10
    - completion_tokens : 39
    - total_tokens : 49
```

Review [Chat Documentation](https://platform.openai.com/docs/guides/chat) for more info.

### Images

Given a prompt and/or an input image, the model will generate a new image.

As Artificial Intelligence continues to develop, so too does the intriguing concept of Dall-E. Developed by OpenAI, a research lab for artificial intelligence purposes, Dall-E has been classified as an AI system that can generate images based on descriptions provided by humans. With its potential applications spanning from animation and illustration to design and engineering - not to mention the endless possibilities in between - it's easy to see why there is such excitement over this new technology.

### Create Image

**Request**

```swift
struct ImagesQuery: Codable {
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?
}
```

**Response**

```swift
struct ImagesResult: Codable, Equatable {
    public struct URLResult: Codable, Equatable {
        public let url: String
    }
    public let created: TimeInterval
    public let data: [URLResult]
}
```

**Example**

```swift
let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")
openAI.images(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.images(query: query)
```

```
(lldb) po result
▿ ImagesResult
  - created : 1671453505.0
  ▿ data : 1 element
    ▿ 0 : URLResult
      - url : "https://oaidalleapiprodscus.blob.core.windows.net/private/org-CWjU5cDIzgCcVjq10pp5yX5Q/user-GoBXgChvLBqLHdBiMJBUbPqF/img-WZVUK2dOD4HKbKwW1NeMJHBd.png?st=2022-12-19T11%3A38%3A25Z&se=2022-12-19T13%3A38%3A25Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2022-12-19T09%3A35%3A16Z&ske=2022-12-20T09%3A35%3A16Z&sks=b&skv=2021-08-06&sig=mh52rmtbQ8CXArv5bMaU6lhgZHFBZz/ePr4y%2BJwLKOc%3D"
 ```

**Generated image**

![Generated Image](https://user-images.githubusercontent.com/1411778/213134082-ba988a72-fca0-4213-8805-63e5f8324cab.png)

### Create Image Edit

Creates an edited or extended image given an original image and a prompt.

**Request**

```swift
public struct ImageEditsQuery: Codable {
    /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    public let fileName: String
    /// An additional image whose fully transparent areas (e.g. where alpha is zero) indicate where image should be edited. Must be a valid PNG file, less than 4MB, and have the same dimensions as image.
    public let mask: Data?
    public let maskFileName: String?
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    public let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?
}
```

**Response**

Uses the ImagesResult response similarly to ImagesQuery.

**Example**

```swift
let data = image.pngData()
let query = ImagesEditQuery(image: data, fileName: "whitecat.png", prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", n: 1, size: "1024x1024")
openAI.imageEdits(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.imageEdits(query: query)
```

### Create Image Variation

Creates a variation of a given image.

**Request**

```swift
public struct ImageVariationsQuery: Codable {
    /// The image to edit. Must be a valid PNG file, less than 4MB, and square. If mask is not provided, image must have transparency, which will be used as the mask.
    public let image: Data
    public let fileName: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    public let size: String?
}
```

**Response**

Uses the ImagesResult response similarly to ImagesQuery.

**Example**

```swift
let data = image.pngData()
let query = ImagesVariationQuery(image: data, fileName: "whitecat.png", n: 1, size: "1024x1024")
openAI.imageVariations(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.imageVariations(query: query)
```

Review [Images Documentation](https://platform.openai.com/docs/api-reference/images) for more info.

### Audio

The speech to text API provides two endpoints, transcriptions and translations, based on our state-of-the-art open source large-v2 [Whisper model](https://openai.com/research/whisper). They can be used to:

Transcribe audio into whatever language the audio is in.
Translate and transcribe the audio into english.
File uploads are currently limited to 25 MB and the following input file types are supported: mp3, mp4, mpeg, mpga, m4a, wav, and webm.

#### Audio Transcriptions

Transcribes audio into the input language.

**Request**

```swift
public struct AudioTranscriptionQuery: Codable, Equatable {
    
    public let file: Data
    public let fileName: String
    public let model: Model
    
    public let prompt: String?
    public let temperature: Double?
    public let language: String?
}
```

**Response**

```swift
public struct AudioTranscriptionResult: Codable, Equatable {
    
    public let text: String
}
```

**Example**

```swift
let data = Data(contentsOfURL:...)
let query = AudioTranscriptionQuery(file: data, fileName: "audio.m4a", model: .whisper_1)        

openAI.audioTranscriptions(query: query) { result in
    //Handle result here
}
//or
let result = try await openAI.audioTranscriptions(query: query)
```

#### Audio Translations

Translates audio into into English.

**Request**

```swift
public struct AudioTranslationQuery: Codable, Equatable {
    
    public let file: Data
    public let fileName: String
    public let model: Model
    
    public let prompt: String?
    public let temperature: Double?
}    
```

**Response**

```swift
public struct AudioTranslationResult: Codable, Equatable {
    
    public let text: String
}
```

**Example**

```swift
let data = Data(contentsOfURL:...)
let query = AudioTranslationQuery(file: data, fileName: "audio.m4a", model: .whisper_1)  

openAI.audioTranslations(query: query) { result in
    //Handle result here
}
//or
let result = try await openAI.audioTranslations(query: query)
```

Review [Audio Documentation](https://platform.openai.com/docs/api-reference/audio) for more info.

### Edits

Creates a new edit for the provided input, instruction, and parameters.

**Request**

```swift
struct EditsQuery: Codable {
    /// ID of the model to use.
    public let model: Model
    /// Input text to get embeddings for.
    public let input: String?
    /// The instruction that tells the model how to edit the prompt.
    public let instruction: String
    /// The number of images to generate. Must be between 1 and 10.
    public let n: Int?
    /// What sampling temperature to use. Higher values means the model will take more risks. Try 0.9 for more creative applications, and 0 (argmax sampling) for ones with a well-defined answer.
    public let temperature: Double?
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let topP: Double?
}
```

**Response**

```swift
struct EditsResult: Codable, Equatable {
    
    public struct Choice: Codable, Equatable {
        public let text: String
        public let index: Int
    }

    public struct Usage: Codable, Equatable {
        public let promptTokens: Int
        public let completionTokens: Int
        public let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
    
    public let object: String
    public let created: TimeInterval
    public let choices: [Choice]
    public let usage: Usage
}
```

**Example**

```swift
let query = EditsQuery(model: .gpt4, input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
openAI.edits(query: query) { result in
  //Handle response here
}
//or
let result = try await openAI.edits(query: query)
```

Review [Edits Documentation](https://platform.openai.com/docs/api-reference/edits) for more info.

### Embeddings

Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.

**Request**

```swift
struct EmbeddingsQuery: Codable {
    /// ID of the model to use.
    public let model: Model
    /// Input text to get embeddings for
    public let input: String
}
```

**Response**

```swift
struct EmbeddingsResult: Codable, Equatable {

    public struct Embedding: Codable, Equatable {

        public let object: String
        public let embedding: [Double]
        public let index: Int
    }
    public let data: [Embedding]
    public let usage: Usage
}
```

**Example**

```swift
let query = EmbeddingsQuery(model: .textSearchBabbageDoc, input: "The food was delicious and the waiter...")
openAI.embeddings(query: query) { result in
  //Handle response here
}
//or
let result = try await openAI.embeddings(query: query)
```

```
(lldb) po result
▿ EmbeddingsResult
  ▿ data : 1 element
    ▿ 0 : Embedding
      - object : "embedding"
      ▿ embedding : 2048 elements
        - 0 : 0.0010535449
        - 1 : 0.024234328
        - 2 : -0.0084999
        - 3 : 0.008647452
    .......
        - 2044 : 0.017536353
        - 2045 : -0.005897616
        - 2046 : -0.026559394
        - 2047 : -0.016633155
      - index : 0

(lldb)
```

Review [Embeddings Documentation](https://platform.openai.com/docs/api-reference/embeddings) for more info.

### Models 

Models are represented as a typealias `typealias Model = String`.

```swift
public extension Model {
    static let gpt4 = "gpt-4"
    static let gpt4_0314 = "gpt-4-0314"
    static let gpt4_32k = "gpt-4-32k"
    static let gpt4_32k_0314 = "gpt-4-32k-0314"
    static let gpt3_5Turbo = "gpt-3.5-turbo"
    static let gpt3_5Turbo0301 = "gpt-3.5-turbo-0301"
    
    static let textDavinci_003 = "text-davinci-003"
    static let textDavinci_002 = "text-davinci-002"
    static let textCurie = "text-curie-001"
    static let textBabbage = "text-babbage-001"
    static let textAda = "text-ada-001"
    
    static let textDavinci_001 = "text-davinci-001"
    static let codeDavinciEdit_001 = "code-davinci-edit-001"
    
    static let whisper_1 = "whisper-1"
    
    static let davinci = "davinci"
    static let curie = "curie"
    static let babbage = "babbage"
    static let ada = "ada"
    
    static let textEmbeddingAda = "text-embedding-ada-002"
    static let textSearchAda = "text-search-ada-doc-001"
    static let textSearchBabbageDoc = "text-search-babbage-doc-001"
    static let textSearchBabbageQuery001 = "text-search-babbage-query-001"
    
    static let textModerationStable = "text-moderation-stable"
    static let textModerationLatest = "text-moderation-latest"
    static let moderation = "text-moderation-001"
}
```

GPT-4 models are supported. 

For example to use basic GPT-4 8K model pass `.gpt4` as a parameter.

```swift
let query = ChatQuery(model: .gpt4, messages: [
    .init(role: .system, content: "You are Librarian-GPT. You know everything about the books."),
    .init(role: .user, content: "Who wrote Harry Potter?")
])
let result = try await openAI.chats(query: query)
XCTAssertFalse(result.choices.isEmpty)
```

You can also pass a custom string if you need to use some model, that is not represented above.

#### List Models

Lists the currently available models.

**Response**

```swift
public struct ModelsResult: Codable, Equatable {
    
    public let data: [ModelResult]
    public let object: String
}

```
**Example**

```swift
openAI.models() { result in
  //Handle result here
}
//or
let result = try await openAI.models()
```

#### Retrieve Model

Retrieves a model instance, providing ownership information.

**Request**

```swift
public struct ModelQuery: Codable, Equatable {
    
    public let model: Model
}    
```

**Response**

```swift
public struct ModelResult: Codable, Equatable {

    public let id: Model
    public let object: String
    public let ownedBy: String
}
```

**Example**

```swift
let query = ModelQuery(model: .gpt4)
openAI.model(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.model(query: query)
```

Review [Models Documentation](https://platform.openai.com/docs/api-reference/models) for more info.

### Moderations 

Given a input text, outputs if the model classifies it as violating OpenAI's content policy.

**Request**

```swift
public struct ModerationsQuery: Codable {
    
    public let input: String
    public let model: Model?
}    
```

**Response**

```swift
public struct ModerationsResult: Codable, Equatable {

    public let id: String
    public let model: Model
    public let results: [CategoryResult]
}
```

**Example**

```swift
let query = ModerationsQuery(input: "I want to kill them.")
openAI.moderations(query: query) { result in
  //Handle result here
}
//or
let result = try await openAI.moderations(query: query)
```

Review [Moderations Documentation](https://platform.openai.com/docs/api-reference/moderations) for more info.

### Utilities

The component comes with several handy utility functions to work with the vectors.

```swift
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
```

**Example**

```swift
let vector1 = [0.213123, 0.3214124, 0.421412, 0.3214521251, 0.412412, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.4214214, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251]
let vector2 = [0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.511515, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3214521251, 0.213123, 0.3214124, 0.1414124, 0.3213213]
let similarity = Vector.cosineSimilarity(a: vector1, b: vector2)
print(similarity) //0.9510201910206734
```
>In data analysis, cosine similarity is a measure of similarity between two sequences of numbers.

<img width="574" alt="Screenshot 2022-12-19 at 6 00 33 PM" src="https://user-images.githubusercontent.com/1411778/208467903-000b52d8-6589-40dd-b020-eeed69e8d284.png">

Read more about Cosine Similarity [here](https://en.wikipedia.org/wiki/Cosine_similarity).

### Combine Extensions

The library contains built-in [Combine](https://developer.apple.com/documentation/combine) extensions.

```swift
func completions(query: CompletionsQuery) -> AnyPublisher<CompletionsResult, Error>
func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, Error>
func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error>
func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error>
func edits(query: EditsQuery) -> AnyPublisher<EditsResult, Error>
func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error>
func models() -> AnyPublisher<ModelsResult, Error>
func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error>
func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error>
func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error>
```

## Example Project

You can find example iOS application in [Demo](/Demo) folder. 

![mockuuups-iphone-13-pro-mockup-perspective-right](https://user-images.githubusercontent.com/1411778/231449395-2ad6bab6-c21f-43dc-8977-f45f505b609d.png)

## Links

- [OpenAI Documentation](https://platform.openai.com/docs/introduction)
- [OpenAI Playground](https://platform.openai.com/playground)
- [OpenAI Examples](https://platform.openai.com/examples)
- [Dall-E](https://labs.openai.com/)
- [Cosine Similarity](https://en.wikipedia.org/wiki/Cosine_similarity)

## License

```
MIT License

Copyright (c) 2023 MacPaw Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
