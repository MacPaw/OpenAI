# OpenAI

![logo](https://user-images.githubusercontent.com/1411778/218319355-f56b6bd4-961a-4d8f-82cd-6dbd43111d7f.png)

___

![Swift Workflow](https://github.com/MacPaw/OpenAI/actions/workflows/swift.yml/badge.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![Twitter](https://img.shields.io/static/v1?label=Twitter&message=@MacPaw&color=CA1F67)](https://twitter.com/MacPaw)

This repository contains Swift community-maintained implementation over [OpenAI](https://platform.openai.com/docs/api-reference/) public API. 

- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
- [Usage](#usage)
    - [Initialization](#initialization)
    - [Using the SDK for other providers except OpenAI](#using-the-sdk-for-other-providers-except-openai)
    - [Cancelling requests](#cancelling-requests)
- [Text and prompting](#text-and-prompting)
    - [Responses](#responses)
    - [Chat Completions](#chat-completions)
- [Function calling](#function-calling)
- [Tools](#tools)
    - [MCP (Model Context Protocol)](#mcp-model-context-protocol)
        - [MCP Tool Integration](#mcp-tool-integration)
- [Images](#images)
    - [Create Image](#create-image)
    - [Create Image Edit](#create-image-edit)
    - [Create Image Variation](#create-image-variation)
- [Audio](#audio)
    - [Audio Create Speech](#audio-create-speech)
    - [Audio Transcriptions](#audio-transcriptions)
    - [Audio Translations](#audio-translations)
- [Structured Outputs](#structured-outputs)
- [Specialized models](#specialized-models)
    - [Embeddings](#embeddings)
    - [Moderations](#moderations)
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
- [Other APIs](#other-apis)
    - [Models](#models)
        - [List Models](#list-models)
        - [Retrieve Model](#retrieve-model)
    - [Utilities](#utilities)
- [Support for other providers: Gemini, DeepSeek, Perplexity, OpenRouter, etc.](#support-for-other-providers)
- [Example Project](#example-project)
- [Contribution Guidelines](#contribution-guidelines)
- [Links](#links)
- [License](#license)
## Documentation

This library implements it's types and methods in close accordance to the REST API documentation, which can be found on [platform.openai.com](https://platform.openai.com/docs/api-reference).

## Installation

### Swift Package Manager

To integrate OpenAI into your Xcode project using Swift Package Manager:

1.  In Xcode, go to **File > Add Package Dependencies...**
2.  Enter the repository URL: `https://github.com/MacPaw/OpenAI.git`
3.  Choose your desired dependency rule (e.g., "Up to Next Major Version").

Alternatively, you can add it directly to your `Package.swift` file:

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

### Using the SDK for other providers except OpenAI

This SDK is more focused on working with OpenAI Platform, but also works with other providers that support OpenAI-compatible API.

Use `.relaxed` parsing option on Configuration, or see more details on the topic [here](#support-for-other-providers)

### Cancelling requests

For Swift Concurrency calls, you can simply cancel the calling task, and corresponding underlying `URLSessionDataTask` would get cancelled automatically.

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

<details>
<summary>Cancelling closure-based API calls</summary>

When you call any of the closure-based API methods, it returns discardable `CancellableRequest`. Hold a reference to it to be able to cancel the request later.
```swift
let cancellableRequest = object.chats(query: query, completion: { _ in })
cancellableReques
```

</details>

<details>
<summary>Cancelling Combine subscriptions</summary>
In Combine, use a default cancellation mechanism. Just discard the reference to a subscription, or call `cancel()` on it.

```swift
let subscription = openAIClient
    .images(query: query)
    .sink(receiveCompletion: { completion in }, receiveValue: { imagesResult in })
    
subscription.cancel()
```
</details>

## Text and prompting

### Responses

Use `responses` variable on `OpenAIProtocol` to call Responses API methods.

```swift
public protocol OpenAIProtocol {
    // ...
    var responses: ResponsesEndpointProtocol { get }
    // ...
}
```

Specify params by passing `CreateModelResponseQuery` to a method. Get `ResponseObject` or a stream of `ResponseStreamEvent` events in response.

**Example: Generate text from a simple prompt**
```swift
let client: OpenAIProtocol = /* client initialization code */

let query = CreateModelResponseQuery(
    input: .textInput("Write a one-sentence bedtime story about a unicorn."),
    model: .gpt4_1
)

let response: ResponseObject = try await client.responses.createResponse(query: query)
// ...
```
<details>
<summary>print(response)</summary>

```
ResponseObject(
  createdAt: 1752146109,
  error: nil,
  id: "resp_686fa0bd8f588198affbbf5a8089e2d208a5f6e2111e31f5",
  incompleteDetails: nil,
  instructions: nil,
  maxOutputTokens: nil,
  metadata: [:],
  model: "gpt-4.1-2025-04-14",
  object: "response",
  output: [
    OpenAI.OutputItem.outputMessage(
      OpenAI.Components.Schemas.OutputMessage(
        id: "msg_686fa0bee24881988a4d1588d7f65c0408a5f6e2111e31f5",
        _type: OpenAI.Components.Schemas.OutputMessage._TypePayload.message,
        role: OpenAI.Components.Schemas.OutputMessage.RolePayload.assistant,
        content: [
          OpenAI.Components.Schemas.OutputContent.OutputTextContent(
            OpenAI.Components.Schemas.OutputTextContent(
              _type: OpenAI.Components.Schemas.OutputTextContent._TypePayload.outputText,
              text: "Under a sky full of twinkling stars, a gentle unicorn named Luna danced through fields of stardust, spreading sweet dreams to every sleeping child.",
              annotations: [],
              logprobs: Optional([])
            )
          )
        ],
        status: OpenAI.Components.Schemas.OutputMessage.StatusPayload.completed
      )
    )
  ],
  parallelToolCalls: true,
  previousResponseId: nil,
  reasoning: Optional(
    OpenAI.Components.Schemas.Reasoning(
      effort: nil,
      summary: nil,
      generateSummary: nil
    )
  ),
  status: "completed",
  temperature: Optional(1.0),
  text: OpenAI.Components.Schemas.ResponseProperties.TextPayload(
    format: Optional(
      OpenAI.Components.Schemas.TextResponseFormatConfiguration.ResponseFormatText(
        OpenAI.Components.Schemas.ResponseFormatText(
          _type: OpenAI.Components.Schemas.ResponseFormatText._TypePayload.text
        )
      )
    ),
    toolChoice: OpenAI.Components.Schemas.ResponseProperties.ToolChoicePayload.ToolChoiceOptions(
      OpenAI.Components.Schemas.ToolChoiceOptions.auto
    ),
    tools: [],
    topP: Optional(1.0),
    truncation: Optional("disabled"),
    usage: Optional(
      OpenAI.Components.Schemas.ResponseUsage(
        inputTokens: 18,
        inputTokensDetails: OpenAI.Components.Schemas.ResponseUsage.InputTokensDetailsPayload(
          cachedTokens: 0
        ),
        outputTokens: 32,
        outputTokensDetails: OpenAI.Components.Schemas.ResponseUsage.OutputTokensDetailsPayload(
          reasoningTokens: 0
        ),
        totalTokens: 50
      )
    ),
    user: nil
  )
)
````

</details>

An array of content generated by the model is in the `output` property of the response.

> [!NOTE] **The `output` array often has more than one item in it!** It can contain tool calls, data about reasoning tokens generated by reasoning models, and other items. It is not safe to assume that the model's text output is present at `output[0].content[0].text`.

Because of the note above, to safely and fully read the response, we'd need to switch both over messages and their contents, like this:

```swift
// ...
for output in response.output {
    switch output {
    case .outputMessage(let outputMessage):
        for content in outputMessage.content {
            switch content {
            case .OutputTextContent(let textContent):
                print(textContent.text)
            case .RefusalContent(let refusalContent):
                print(refusalContent.refusal)
            }
        }
    default:
        // Unhandled output items. Handle or throw an error.
    }
}
```

### Chat Completions

Use `ChatQuery` with `func chats(query:)` and `func chatsStream(query:)` methods on `OpenAIProtocol` to generate text using Chat Completions API. Get `ChatResult` or `ChatStreamResult` in response.

**Example: Generate text from a simple prompt**

```swift
let query = ChatQuery(
    messages: [
        .user(.init(content: .string("Who are you?")))
    ],
    model: .gpt4_o
)

let result = try await openAI.chats(query: query)

print(result.choices.first?.message.content ?? "")
// printed to console:
// I'm an AI language model created by OpenAI, designed to assist with a wide range of questions and tasks. How can I help you today?
```

<details>
<summary>po result</summary>

```
(lldb) po result
▿ ChatResult
  - id : "chatcmpl-BgWJTzbVczdJDusTqVpnR6AQ2w6Fd"
  - created : 1749473687
  - model : "gpt-4o-2024-08-06"
  - object : "chat.completion"
  ▿ serviceTier : Optional<ServiceTier>
    - some : OpenAI.ServiceTier.defaultTier
  ▿ systemFingerprint : Optional<String>
    - some : "fp_07871e2ad8"
  ▿ choices : 1 element
    ▿ 0 : Choice
      - index : 0
      - logprobs : nil
      ▿ message : Message
        ▿ content : Optional<String>
          - some : "I am an AI language model created by OpenAI, known as ChatGPT. I\'m here to assist with answering questions, providing explanations, and engaging in conversation on a wide range of topics. If you have any questions or need assistance, feel free to ask!"
        - refusal : nil
        - role : "assistant"
        ▿ annotations : Optional<Array<Annotation>>
          - some : 0 elements
        - audio : nil
        - toolCalls : nil
        - _reasoning : nil
        - _reasoningContent : nil
      - finishReason : "stop"
  ▿ usage : Optional<CompletionUsage>
    ▿ some : CompletionUsage
      - completionTokens : 52
      - promptTokens : 11
      - totalTokens : 63
      ▿ promptTokensDetails : Optional<PromptTokensDetails>
        ▿ some : PromptTokensDetails
          - audioTokens : 0
          - cachedTokens : 0
  - citations : nil
```

</details>

<!-- ## Images and vision

## Audio and speech

## Structured Outputs -->

## Function calling

See [OpenAI Platform Guide: Function calling](https://platform.openai.com/docs/guides/function-calling?api-mode=responses) for more details.

<details>

<summary>Chat Completions API Examples</summary>

### Function calling with get_weather function

```swift
let openAI = OpenAI(apiToken: "...")
// Declare functions which model might decide to call.
let functions = [
    ChatQuery.ChatCompletionToolParam.FunctionDefinition(
        name: "get_weather",
        description: "Get current temperature for a given location.",
        parameters: .init(fields: [
            .type(.object),
            .properties([
                "location": .init(fields: [
                    .type(.string),
                    .description("City and country e.g. Bogotá, Colombia")
                ])
            ]),
            .required(["location"]),
            .additionalProperties(.boolean(false))
        ])
    )
]
let query = ChatQuery(
    messages: [
        .user(.init(content: .string("What is the weather like in Paris today?"
    ],
    model: .gpt4_1,
    tools: functions.map { .init(function: $0) }
)
let result = try await openAI.chats(query: query)
print(result.choices[0].message.toolCalls)
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

</details>

## Images

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

## Audio

The speech to text API provides two endpoints, transcriptions and translations, based on our state-of-the-art open source large-v2 [Whisper model](https://openai.com/research/whisper). They can be used to:

Transcribe audio into whatever language the audio is in.
Translate and transcribe the audio into english.
File uploads are currently limited to 25 MB and the following input file types are supported: mp3, mp4, mpeg, mpga, m4a, wav, and webm.

### Audio Create Speech

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

### Audio Create Speech Streaming

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

### Audio Transcriptions

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

### Audio Translations

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

## Structured Outputs

> [!NOTE] This section focuses on non-function calling use cases in the Responses and Chat Completions APIs. To learn more about how to use Structured Outputs with function calling, check out the [Function Calling](#function-calling).

To configure structured outputs you would define a JSON Schema and pass it to a query.

This SDK supports multiple ways to define a schema; choose the one you prefer.

<details>

<summary>JSONSchemaDefinition.jsonSchema</summary>

### Build a schema by specifying fields

This definition accepts `JSONSchema` which is either `boolean` or `object` JSON Document.

Instead of providing schema yourself you can build one in a type-safe manner using initializers that accept `[JSONSchemaField]`, as shown in the example below.

While this method of defining a schema is direct, it can be verbose. For alternative ways to define a schema, see the options below.

### Example

```swift
let query = CreateModelResponseQuery(
    input: .textInput("Return structured output"),
    model: .gpt4_o,
    text: .jsonSchema(.init(
        name: "research_paper_extraction",
        schema: .jsonSchema(.init(
            .type(.object),
            .properties([
                "title": Schema.buildBlock(
                    .type(.string)
                ),
                "authors": .init(
                    .type(.array),
                    .items(.init(
                        .type(.string)
                    ))
                ),
                "abstract": .init(
                    .type(.string)
                ),
                "keywords": .init(
                    .type(.array),
                    .items(.init(
                        .type(.string))
                    )
                )
            ]),
            .required(["title, authors, abstract, keywords"]),
            .additionalProperties(.boolean(false))
        )),
        description: "desc",
        strict: false
    ))
)

let response = try await openAIClient.responses.createResponse(query: query)
for output in response.output {
    switch output {
    case .outputMessage(let message):
        for content in message.content {
            switch content {
            case .OutputTextContent(let textContent):
                print("json output structured by the schema: ", textContent.text)
            case .RefusalContent(let refusal):
                // Handle refusal
                break
            }
        }
    default:
        // Handle other OutputItems
        break
    }
}
```

</details>

<details>

<summary>JSONSchemaDefinition.derivedJsonSchema</summary>

### Implement a type that describes a schema

Use [Pydantic](https://docs.pydantic.dev/latest/) or [Zod](https://zod.dev) fashion to define schemas.

- Use the `derivedJsonSchema(_ type:)` response format when creating a `ChatQuery` or `CreateModelResponseQuery`
- Provide a type that conforms to `JSONSchemaConvertible` and generates an instance as an example
- Make sure all enum types within the provided type conform to `JSONSchemaEnumConvertible` and generate an array of names for all cases

### Example

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
    messages: [
        .system(
            .init(content: .textContent("Best Picture winner at the 2011 Oscars"))
        )
    ],
    model: .gpt4_o,
    responseFormat: .jsonSchema(
        .init(
            name: "movie-info",
            description: nil,
            schema: .derivedJsonSchema(MovieInfo.self),
            strict: true
        )
    )
)
let result = try await openAI.chats(query: query)
```

</details>

<details>

<summary>JSONSchemaDefinition.dynamicJsonSchema</summary>

### Define a schema with an instance of any type that conforms to Encodable

Define your JSON schema using simple Dictionaries, or specify JSON schema with a library like https://github.com/kevinhermawan/swift-json-schema.

### Example

```swift
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
let schema = [
    "type": AnyEncodable("object"),
    "properties": AnyEncodable([
        "title": AnyEncodable([
            "type": "string"
        ]),
        "director": AnyEncodable([
            "type": "string"
        ]),
        "release": AnyEncodable([
            "type": "string"
        ]),
        "genres": AnyEncodable([
            "type": AnyEncodable("array"),
            "items": AnyEncodable([
                "type": AnyEncodable("string"),
                "enum": AnyEncodable(["action", "drama", "comedy", "scifi"])
            ])
        ]),
        "cast": AnyEncodable([
            "type": AnyEncodable("array"),
            "items": AnyEncodable([
                "type": "string"
            ])
        ])
    ]),
    "additionalProperties": AnyEncodable(false)
]
let query = ChatQuery(
    messages: [.system(.init(content: .textContent("Return a structured response.")))],
    model: .gpt4_o,
    responseFormat: .jsonSchema(.init(name: "movie-info", schema: .dynamicJsonSchema(schema)))
)
let result = try await openAI.chats(query: query)
```

</details>

Review [Structured Output Documentation](https://platform.openai.com/docs/guides/structured-outputs) for more info.

## Tools
### Remote MCP (Model Context Protocol)

The Model Context Protocol (MCP) enables AI models to securely connect to external data sources and tools through standardized server connections. This OpenAI Swift library supports MCP integration, allowing you to extend model capabilities with remote tools and services.

You can use the [MCP Swift library](https://github.com/modelcontextprotocol/swift-sdk) to connect to MCP servers and discover available tools, then integrate those tools with OpenAI's chat completions.

#### MCP Tool Integration

**Request**

```swift
// Create an MCP tool for connecting to a remote server
let mcpTool = Tool.mcpTool(
    .init(
        _type: .mcp,
        serverLabel: "GitHub_MCP_Server",
        serverUrl: "https://api.githubcopilot.com/mcp/",
        headers: .init(additionalProperties: [
            "Authorization": "Bearer YOUR_TOKEN_HERE"
        ]),
        allowedTools: .case1(["search_repositories", "get_file_contents"]),
        requireApproval: .case2(.always)
    )
)

let query = ChatQuery(
    messages: [
        .user(.init(content: .string("Search for Swift repositories on GitHub")))
    ],
    model: .gpt4_o,
    tools: [mcpTool]
)
```

**MCP Tool Properties**

- `serverLabel`: A unique identifier for the MCP server
- `serverUrl`: The URL endpoint of the MCP server
- `headers`: Authentication headers and other HTTP headers required by the server
- `allowedTools`: Specific tools to enable from the server (optional - if not specified, all tools are available)
- `requireApproval`: Whether tool calls require user approval (`.always`, `.never`, or conditional)

**Example with MCP Swift Library**

```swift
import MCP
import OpenAI

// Connect to MCP server using the MCP Swift library
let mcpClient = MCP.Client(name: "MyApp", version: "1.0.0")

let transport = HTTPClientTransport(
    endpoint: URL(string: "https://api.githubcopilot.com/mcp/")!,
    configuration: URLSessionConfiguration.default
)

let result = try await mcpClient.connect(transport: transport)
let toolsResponse = try await mcpClient.listTools()

// Create OpenAI MCP tool with discovered tools
let enabledToolNames = toolsResponse.tools.map { $0.name }
let mcpTool = Tool.mcpTool(
    .init(
        _type: .mcp,
        serverLabel: "GitHub_MCP_Server",
        serverUrl: "https://api.githubcopilot.com/mcp/",
        headers: .init(additionalProperties: authHeaders),
        allowedTools: .case1(enabledToolNames),
        requireApproval: .case2(.always)
    )
)

// Use in chat completion
let query = ChatQuery(
    messages: [.user(.init(content: .string("Help me search GitHub repositories")))],
    model: .gpt4_o,
    tools: [mcpTool]
)

let chatResult = try await openAI.chats(query: query)
```

**MCP Tool Call Handling**

When using MCP tools, the model may generate tool calls that are executed on the remote MCP server. Handle MCP-specific output items in your response processing:

```swift
// Handle MCP tool calls in streaming responses
for try await result in openAI.chatsStream(query: query) {
    for choice in result.choices {
        if let outputItem = choice.delta.content {
            switch outputItem {
            case .mcpToolCall(let mcpCall):
                print("MCP tool call: \(mcpCall.name)")
                if let output = mcpCall.output {
                    print("Result: \(output)")
                }
            case .mcpApprovalRequest(let approvalRequest):
                // Handle approval request if requireApproval is enabled
                print("MCP tool requires approval: \(approvalRequest)")
            default:
                // Handle other output types
                break
            }
        }
    }
}
```

## Specialized models

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

## Other APIs

### Models 

Models are represented as a typealias `typealias Model = String`.

```swift
public extension Model {
    static let gpt5_1 = "gpt-5.1"
    static let gpt5_1_chat_latest = "gpt-5.1-chat-latest"

    static let gpt5 = "gpt-5"
    static let gpt5_mini = "gpt-5-mini"
    static let gpt5_nano = "gpt-5-nano"
    static let gpt5_chat = "gpt-5-chat"

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

## Assistants

Review [Assistants Documentation](https://platform.openai.com/docs/api-reference/assistants) for more info.

### Create Assistant

Example: Create Assistant
```swift
let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools: tools, toolResources: toolResources)
openAI.assistantCreate(query: query) { result in
   //Handle response here
}
```

### Modify Assistant

Example: Modify Assistant
```swift
let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools: tools, toolResources: toolResources)
openAI.assistantModify(query: query, assistantId: "asst_1234") { result in
    //Handle response here
}
```

### List Assistants

Example: List Assistants
```swift
openAI.assistants() { result in
   //Handle response here
}
```

### Threads

Review [Threads Documentation](https://platform.openai.com/docs/api-reference/threads) for more info.

#### Create Thread

Example: Create Thread
```swift
let threadsQuery = ThreadsQuery(messages: [Chat(role: message.role, content: message.content)])
openAI.threads(query: threadsQuery) { result in
  //Handle response here
}
```

#### Create and Run Thread

Example: Create and Run Thread
```swift
let threadsQuery = ThreadQuery(messages: [Chat(role: message.role, content: message.content)])
let threadRunQuery = ThreadRunQuery(assistantId: "asst_1234"  thread: threadsQuery)
openAI.threadRun(query: threadRunQuery) { result in
  //Handle response here
}
```

#### Get Threads Messages

Review [Messages Documentation](https://platform.openai.com/docs/api-reference/messages) for more info.

Example: Get Threads Messages
```swift
openAI.threadsMessages(threadId: currentThreadId) { result in
  //Handle response here
}
```

#### Add Message to Thread

Example: Add Message to Thread
```swift
let query = MessageQuery(role: message.role.rawValue, content: message.content)
openAI.threadsAddMessage(threadId: currentThreadId, query: query) { result in
  //Handle response here
}
```

### Runs

Review [Runs Documentation](https://platform.openai.com/docs/api-reference/runs) for more info.

#### Create Run

Example: Create Run
```swift
let runsQuery = RunsQuery(assistantId:  currentAssistantId)
openAI.runs(threadId: threadsResult.id, query: runsQuery) { result in
  //Handle response here
}
```

#### Retrieve Run

Example: Retrieve Run
```swift
openAI.runRetrieve(threadId: currentThreadId, runId: currentRunId) { result in
  //Handle response here
}
```

#### Retrieve Run Steps

Example: Retrieve Run Steps
```swift
openAI.runRetrieveSteps(threadId: currentThreadId, runId: currentRunId) { result in
  //Handle response here
}
```

#### Submit Tool Outputs for Run

Example: Submit Tool Outputs for Run
```swift
let output = RunToolOutputsQuery.ToolOutput(toolCallId: "call123", output: "Success")
let query = RunToolOutputsQuery(toolOutputs: [output])
openAI.runSubmitToolOutputs(threadId: currentThreadId, runId: currentRunId, query: query) { result in
  //Handle response here
}
```

### Files

Review [Files Documentation](https://platform.openai.com/docs/api-reference/files) for more info.

#### Upload file

Example: Upload file
```swift
let query = FilesQuery(purpose: "assistants", file: fileData, fileName: url.lastPathComponent, contentType: "application/pdf")
openAI.files(query: query) { result in
  //Handle response here
}
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
