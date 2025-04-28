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
    - [Chats](#chats)
        - [Chats Streaming](#chats-streaming) 
        - [Structured Output](#structured-output) 
    - [Images](#images)
        - [Create Image](#create-image)
        - [Create Image Edit](#create-image-edit)
        - [Create Image Variation](#create-image-variation)
    - [Audio](#audio)
        - [Audio Create Speech](#audio-create-speech)
        - [Audio Transcriptions](#audio-transcriptions)
        - [Audio Translations](#audio-translations)
    - [Embeddings](#embeddings)
    - [Models](#models)
        - [List Models](#list-models)
        - [Retrieve Model](#retrieve-model)
    - [Moderations](#moderations)
    - [Utilities](#utilities)
    - [Combine Extensions](#combine-extensions)
    - [Assistants (Beta)](#assistants)
        - [Create Assistant](#create-assistant)
        - [Modify Assistant](#modify-assistant)
        - [List Assistants](#list-assistants) 
        - [Threads](#threads)
          - [Create Thread](#create-thread)
          - [Create and Run Thread](#create-and-run-thread)
          - [Get Threads Messages](#get-threads-messages)
          - [Add Message to Thread](#add-message-to-thread)
        - [Runs](#runs)
          - [Create Run](#create-run)
          - [Retrieve Run](#retrieve-run)
          - [Retrieve Run Steps](#retrieve-run-steps)
          - [Submit Tool Outputs for Run](#submit-tool-outputs-for-run)
        - [Files](#files)
          - [Upload File](#upload-file)
  - [Cancelling requests](#cancelling-requests)
- [Support for other providers: Gemini, DeepSeek, Perplexity, OpenRouter, etc.](#support-for-other-providers)
- [Example Project](#example-project)
- [Contribution Guidelines](#contribution-guidelines)
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

> ⚠️ OpenAI strongly recommends developers of client-side applications proxy requests through a separate backend service to keep their API key safe. API keys can access and manipulate customer billing, usage, and organizational data, so it's a significant risk to [expose](https://nshipster.com/secrets/) them.

```swift
let openAI = OpenAI(apiToken: "YOUR_TOKEN_HERE")
```

Optionally you can initialize `OpenAI` with token, organization identifier and timeoutInterval.

```swift
let configuration = OpenAI.Configuration(token: "YOUR_TOKEN_HERE", organizationIdentifier: "YOUR_ORGANIZATION_ID_HERE", timeoutInterval: 60.0)
let openAI = OpenAI(configuration: configuration)
```

See `OpenAI.Configuration` for more values that can be passed on init for customization, like: `host`, `basePath`, `port`, `scheme` and `customHeaders`.

Once you posses the token, and the instance is initialized you are ready to make requests.

#### Using the SDK for other providers except OpenAI

This SDK is more focused on working with OpenAI Platform, but also works with other providers that support OpenAI-compatible API.

Use `.relaxed` parsing option on Configuration, or see more details on the topic [here](#support-for-other-providers)

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
    /// ID of the model to use.
    public let model: Model
    /// An object specifying the format that the model must output.
    public let responseFormat: ResponseFormat?
    /// The messages to generate chat completions for
    public let messages: [Message]
    /// A list of tools the model may call. Currently, only functions are supported as a tool. Use this to provide a list of functions the model may generate JSON inputs for.
    public let tools: [Tool]?
    /// Controls how the model responds to tool calls. "none" means the model does not call a function, and responds to the end-user. "auto" means the model can pick between and end-user or calling a function. Specifying a particular function via `{"name": "my_function"}` forces the model to call that function. "none" is the default when no functions are present. "auto" is the default if functions are present.
    public let toolChoice: ToolChoice?
    /// What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and  We generally recommend altering this or top_p but not both.
    public let temperature: Double?
    /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
    public let topP: Double?
    /// How many chat completion choices to generate for each input message.
    public let n: Int?
    /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
    public let stop: [String]?
    /// The maximum number of tokens to generate in the completion.
    public let maxTokens: Int?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
    public let presencePenalty: Double?
    /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
    public let frequencyPenalty: Double?
    /// Modify the likelihood of specified tokens appearing in the completion.
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

#### Chats Streaming

Chats streaming is available by using `chatStream` function. Tokens will be sent one-by-one.

**Closures**
```swift
openAI.chatsStream(query: query) { partialResult in
    switch partialResult {
    case .success(let result):
        print(result.choices)
    case .failure(let error):
        //Handle chunk error here
    }
} completion: { error in
    //Handle streaming error here
}
```

**Combine**

```swift
openAI
    .chatsStream(query: query)
    .sink { completion in
        //Handle completion result here
    } receiveValue: { result in
        //Handle chunk here
    }.store(in: &cancellables)
```

**Structured concurrency**
```swift
for try await result in openAI.chatsStream(query: query) {
   //Handle result here
}
```

**Function calls**
```swift
let openAI = OpenAI(apiToken: "...")
// Declare functions which model might decide to call.
let functions = [
  FunctionDeclaration(
      name: "get_current_weather",
      description: "Get the current weather in a given location",
      parameters: .init(fields: [
        .type(.object),
        .properties([
          "location": .init(fields: [
            .type(.string),
            .description("The city and state, e.g. San Francisco, CA")
          ]),
          "unit": .init(fields: [
            .type(.string),
            .enumValues(["celsius", "fahrenheit"])
          ])
        ]),
        .required(["location"])
      ])
  )
]
let query = ChatQuery(
  model: "gpt-3.5-turbo-0613",  // 0613 is the earliest version with function calls support.
  messages: [
      Chat(role: .user, content: "What's the weather like in Boston?")
  ],
  tools: functions.map { Tool.function($0) }
)
let result = try await openAI.chats(query: query)
```

Result will be (serialized as JSON here for readability):
```json
{
  "id": "chatcmpl-1234",
  "object": "chat.completion",
  "created": 1686000000,
  "model": "gpt-3.5-turbo-0613",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "tool_calls": [
          {
            "id": "call-0",
            "type": "function",
            "function": {
              "name": "get_current_weather",
              "arguments": "{\n  \"location\": \"Boston, MA\"\n}"
            }
          }
        ]
      },
      "finish_reason": "function_call"
    }
  ],
  "usage": { "total_tokens": 100, "completion_tokens": 18, "prompt_tokens": 82 }
}

```

Review [Chat Documentation](https://platform.openai.com/docs/guides/chat) for more info.

#### Structured Output

JSON is one of the most widely used formats in the world for applications to exchange data.

Structured Outputs is a feature that ensures the model will always generate responses that adhere to your supplied JSON Schema, so you don't need to worry about the model omitting a required key, or hallucinating an invalid enum value.

**Example**

```swift
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

enum MovieGenre: String, Codable, JSONSchemaEnumConvertible {
    case action, drama, comedy, scifi
    
    var caseNames: [String] { Self.allCases.map { $0.rawValue } }
}

let query = ChatQuery(
    messages: [.system(.init(content: "Best Picture winner at the 2011 Oscars"))],
    model: .gpt4_o,
    responseFormat: .derivedJsonSchema(name: "movie-info", type: MovieInfo.self)
)
let result = try await openAI.chats(query: query)
```

- Use the `derivedJsonSchema(name:type:)` response format when creating a `ChatQuery`
- Provide a schema name and a type that conforms to `JSONSchemaConvertible` and generates an instance as an example
- Make sure all enum types within the provided type conform to `ChatQuery.JSONSchemaEnumConvertible` and generate an array of names for all cases


Review [Structured Output Documentation](https://platform.openai.com/docs/guides/structured-outputs) for more info.

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
let query = ImageEditQuery(image: data, fileName: "whitecat.png", prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", n: 1, size: "1024x1024")
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
let query = ImageVariationQuery(image: data, fileName: "whitecat.png", n: 1, size: "1024x1024")
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

#### Audio Create Speech

This function sends an `AudioSpeechQuery` to the OpenAI API to create audio speech from text using a specific voice and format. 

[Learn more about voices.](https://platform.openai.com/docs/guides/text-to-speech/voice-options)  
[Learn more about models.](https://platform.openai.com/docs/models/tts)

**Request:**  

```swift
public struct AudioSpeechQuery: Codable, Equatable {
    //...
    public let model: Model // tts-1 or tts-1-hd  
    public let input: String
    public let voice: AudioSpeechVoice
    public let responseFormat: AudioSpeechResponseFormat
    public let speed: String? // Initializes with Double?
    //...
}
```

**Response:**

```swift
/// Audio data for one of the following formats :`mp3`, `opus`, `aac`, `flac`, `pcm`
public let audioData: Data?
```

**Example:**   

```swift
let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 1.0)

openAI.audioCreateSpeech(query: query) { result in
    // Handle response here
}
//or
let result = try await openAI.audioCreateSpeech(query: query)
```
[OpenAI Create Speech – Documentation](https://platform.openai.com/docs/api-reference/audio/createSpeech)

#### Audio Create Speech Streaming

Audio Create Speech is available by using `audioCreateSpeechStream` function. Tokens will be sent one-by-one.

**Closures**
```swift
openAI.audioCreateSpeechStream(query: query) { partialResult in
    switch partialResult {
    case .success(let result):
        print(result.audio)
    case .failure(let error):
        //Handle chunk error here
    }
} completion: { error in
    //Handle streaming error here
}
```

**Combine**

```swift
openAI
    .audioCreateSpeechStream(query: query)
    .sink { completion in
        //Handle completion result here
    } receiveValue: { result in
        //Handle chunk here
    }.store(in: &cancellables)
```

**Structured concurrency**
```swift
for try await result in openAI.audioCreateSpeechStream(query: query) {
   //Handle result here
}
```

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
    static let gpt4_1 = "gpt-4.1"
    static let gpt4_1_mini = "gpt-4.1-mini"
    static let gpt4_1_nano = "gpt-4.1-nano"

    static let gpt4_turbo_preview = "gpt-4-turbo-preview"
    static let gpt4_vision_preview = "gpt-4-vision-preview"
    static let gpt4_0125_preview = "gpt-4-0125-preview"
    static let gpt4_1106_preview = "gpt-4-1106-preview"
    static let gpt4 = "gpt-4"
    static let gpt4_0613 = "gpt-4-0613"
    static let gpt4_0314 = "gpt-4-0314"
    static let gpt4_32k = "gpt-4-32k"
    static let gpt4_32k_0613 = "gpt-4-32k-0613"
    static let gpt4_32k_0314 = "gpt-4-32k-0314"
    
    static let gpt3_5Turbo = "gpt-3.5-turbo"
    static let gpt3_5Turbo_0125 = "gpt-3.5-turbo-0125"
    static let gpt3_5Turbo_1106 = "gpt-3.5-turbo-1106"
    static let gpt3_5Turbo_0613 = "gpt-3.5-turbo-0613"
    static let gpt3_5Turbo_0301 = "gpt-3.5-turbo-0301"
    static let gpt3_5Turbo_16k = "gpt-3.5-turbo-16k"
    static let gpt3_5Turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"
    
    static let textDavinci_003 = "text-davinci-003"
    static let textDavinci_002 = "text-davinci-002"
    static let textCurie = "text-curie-001"
    static let textBabbage = "text-babbage-001"
    static let textAda = "text-ada-001"
    
    static let textDavinci_001 = "text-davinci-001"
    static let codeDavinciEdit_001 = "code-davinci-edit-001"
    
    static let tts_1 = "tts-1"
    static let tts_1_hd = "tts-1-hd"
    
    static let whisper_1 = "whisper-1"

    static let dall_e_2 = "dall-e-2"
    static let dall_e_3 = "dall-e-3"
    
    static let davinci = "davinci"
    static let curie = "curie"
    static let babbage = "babbage"
    static let ada = "ada"
    
    static let textEmbeddingAda = "text-embedding-ada-002"
    static let textSearchAda = "text-search-ada-doc-001"
    static let textSearchBabbageDoc = "text-search-babbage-doc-001"
    static let textSearchBabbageQuery001 = "text-search-babbage-query-001"
    static let textEmbedding3 = "text-embedding-3-small"
    static let textEmbedding3Large = "text-embedding-3-large"
    
    static let textModerationStable = "text-moderation-stable"
    static let textModerationLatest = "text-moderation-latest"
    static let moderation = "text-moderation-007"
}
```

GPT-4 models are supported. 

As an example: To use the `gpt-4-turbo-preview` model, pass `.gpt4_turbo_preview` as the parameter to the `ChatQuery` init.

```swift
let query = ChatQuery(model: .gpt4_turbo_preview, messages: [
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
func images(query: ImagesQuery) -> AnyPublisher<ImagesResult, Error>
func embeddings(query: EmbeddingsQuery) -> AnyPublisher<EmbeddingsResult, Error>
func chats(query: ChatQuery) -> AnyPublisher<ChatResult, Error>
func model(query: ModelQuery) -> AnyPublisher<ModelResult, Error>
func models() -> AnyPublisher<ModelsResult, Error>
func moderations(query: ModerationsQuery) -> AnyPublisher<ModerationsResult, Error>
func audioTranscriptions(query: AudioTranscriptionQuery) -> AnyPublisher<AudioTranscriptionResult, Error>
func audioTranslations(query: AudioTranslationQuery) -> AnyPublisher<AudioTranslationResult, Error>
```

### Assistants

Review [Assistants Documentation](https://platform.openai.com/docs/api-reference/assistants) for more info.

#### Create Assistant

Example: Create Assistant
```swift
let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools: tools, toolResources: toolResources)
openAI.assistantCreate(query: query) { result in
   //Handle response here
}
```

#### Modify Assistant

Example: Modify Assistant
```swift
let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools: tools, toolResources: toolResources)
openAI.assistantModify(query: query, assistantId: "asst_1234") { result in
    //Handle response here
}
```

#### List Assistants

Example: List Assistants
```swift
openAI.assistants() { result in
   //Handle response here
}
```

#### Threads

Review [Threads Documentation](https://platform.openai.com/docs/api-reference/threads) for more info.

##### Create Thread

Example: Create Thread
```swift
let threadsQuery = ThreadsQuery(messages: [Chat(role: message.role, content: message.content)])
openAI.threads(query: threadsQuery) { result in
  //Handle response here
}
```

##### Create and Run Thread

Example: Create and Run Thread
```swift
let threadsQuery = ThreadQuery(messages: [Chat(role: message.role, content: message.content)])
let threadRunQuery = ThreadRunQuery(assistantId: "asst_1234"  thread: threadsQuery)
openAI.threadRun(query: threadRunQuery) { result in
  //Handle response here
}
```

##### Get Threads Messages

Review [Messages Documentation](https://platform.openai.com/docs/api-reference/messages) for more info.

Example: Get Threads Messages
```swift
openAI.threadsMessages(threadId: currentThreadId) { result in
  //Handle response here
}
```

##### Add Message to Thread

Example: Add Message to Thread
```swift
let query = MessageQuery(role: message.role.rawValue, content: message.content)
openAI.threadsAddMessage(threadId: currentThreadId, query: query) { result in
  //Handle response here
}
```

#### Runs

Review [Runs Documentation](https://platform.openai.com/docs/api-reference/runs) for more info.

##### Create Run

Example: Create Run
```swift
let runsQuery = RunsQuery(assistantId:  currentAssistantId)
openAI.runs(threadId: threadsResult.id, query: runsQuery) { result in
  //Handle response here
}
```

##### Retrieve Run

Example: Retrieve Run
```swift
openAI.runRetrieve(threadId: currentThreadId, runId: currentRunId) { result in
  //Handle response here
}
```

##### Retrieve Run Steps

Example: Retrieve Run Steps
```swift
openAI.runRetrieveSteps(threadId: currentThreadId, runId: currentRunId) { result in
  //Handle response here
}
```

##### Submit Tool Outputs for Run

Example: Submit Tool Outputs for Run
```swift
let output = RunToolOutputsQuery.ToolOutput(toolCallId: "call123", output: "Success")
let query = RunToolOutputsQuery(toolOutputs: [output])
openAI.runSubmitToolOutputs(threadId: currentThreadId, runId: currentRunId, query: query) { result in
  //Handle response here
}
```

#### Files

Review [Files Documentation](https://platform.openai.com/docs/api-reference/files) for more info.

##### Upload file

Example: Upload file
```swift
let query = FilesQuery(purpose: "assistants", file: fileData, fileName: url.lastPathComponent, contentType: "application/pdf")
openAI.files(query: query) { result in
  //Handle response here
}
```

### Cancelling requests
#### Closure based API
When you call any of the closure-based API methods, it returns discardable `CancellableRequest`. Hold a reference to it to be able to cancel the request later.
```swift
let cancellableRequest = object.chats(query: query, completion: { _ in })
cancellableReques
```

#### Swift Concurrency
For Swift Concurrency calls, you can simply cancel the calling task, and corresponding `URLSessionDataTask` would get cancelled automatically.
```swift
let task = Task {
    do {
        let chatResult = try await openAIClient.chats(query: .init(messages: [], model: "asd"))
    } catch {
        // Handle cancellation or error
    }
}
            
task.cancel()
```

#### Combine
In Combine, use a default cancellation mechanism. Just discard the reference to a subscription, or call `cancel()` on it.

```swift
let subscription = openAIClient
    .images(query: query)
    .sink(receiveCompletion: { completion in }, receiveValue: { imagesResult in })
    
subscription.cancel()
```

## Support for other providers

> TL;DR Use `.relaxed` parsing option on Configuration

This SDK has a limited support for other providers like Gemini, Perplexity etc.

The top priority of this SDK is OpenAI, and the main rule is for all the main types to be fully compatible with [OpenAI's API Reference](https://platform.openai.com/docs/api-reference/introduction). If it says a field should be optional, it must be optional in main subset of Query/Result types of this SDK. The same goes for other info declared in the reference, like default values.

That said we still want to give a support for other providers.

### Option 1: Use `.relaxed` parsing option
`.relaxed` parsing option handles both missing and additional key/values in responses. It should be sufficient for most use-cases. Let us know if it doesn't cover any case you need.

### Option 2: Specify parsing options separately
#### Handle missing keys in responses
Some providers return responses that don't completely satisfy OpenAI's scheme. Like, Gemini chat completion response ommits `id` field which is a required field in OpenAI's API Reference.

In such case use `fillRequiredFieldIfKeyNotFound` Parsing Option, like this:
```swift
let configuration = OpenAI.Configuration(token: "", parsingOptions: .fillRequiredFieldIfKeyNotFound)
```

#### Handle missing values in responses
Some fields are required to be present (non-optional) by OpenAI, but other providers may return `null` for them.

Use `.fillRequiredFieldIfValueNotFound` to handle missing values

#### What if a provider returns additional fields?
Currently we handle such cases by simply adding additional fields to main model set. This is possible because optional fields wouldn't break or conflict with OpenAI's scheme. At the moment, such additional fields are added:

`ChatResult`

* `citations` [Perplexity](https://docs.perplexity.ai/api-reference/chat-completions#response-citations)

`ChatResult.Choice.Message`

* `reasoningContent` [Grok](https://docs.x.ai/docs/api-reference#chat-completions), [DeepSeek](https://api-docs.deepseek.com/api/create-chat-completion#responses)
* `reasoning` [OpenRouter](https://openrouter.ai/docs/use-cases/reasoning-tokens#basic-usage-with-reasoning-tokens)

## Example Project

You can find example iOS application in [Demo](/Demo) folder. 

![mockuuups-iphone-13-pro-mockup-perspective-right](https://user-images.githubusercontent.com/1411778/231449395-2ad6bab6-c21f-43dc-8977-f45f505b609d.png)

## Contribution Guidelines
Make your Pull Requests clear and obvious to anyone viewing them.  
Set `main` as your target branch.

#### Use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) principles in naming PRs and branches:

- `Feat: ...` for new features and new functionality implementations.
- `Bug: ...` for bug fixes.
- `Fix: ...` for minor issues fixing, like typos or inaccuracies in code.
- `Chore: ...` for boring stuff like code polishing, refactoring, deprecation fixing etc.

PR naming example: `Feat: Add Threads API handling` or `Bug: Fix message result duplication`

Branch naming example: `feat/add-threads-API-handling` or `bug/fix-message-result-duplication`

#### Write description to pull requests in following format:
- What

  ...
- Why
  
  ...
- Affected Areas

  ...
- More Info

  ...

We'll appreciate you including tests to your code if it is needed and possible. ❤️

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
