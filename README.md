# OpenAI

![logoo2](https://user-images.githubusercontent.com/1411778/208467048-8b9c53f9-42aa-421e-bf6f-2b0f6e7b8a9d.png)

___

![Swift Workflow](https://github.com/MacPaw/OpenAI/actions/workflows/swift.yml/badge.svg)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FMacPaw%2FOpenAI%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/MacPaw/OpenAI)
[![Twitter](https://img.shields.io/static/v1?label=Twitter&message=@MacPaw&color=CA1F67)](https://twitter.com/MacPaw)

This repositorty contains Swift implementation over [OpenAI](https://beta.openai.com/docs/api-reference/) public API.

- [What is OpenAI](#what-is-openai)
- [Installation](#installation)
- [Usage](#usage)
    - [Initialization](#initialization)
    - [Completions](#completions)
    - [Images](#images)
    - [Embeddings](#embeddings)
    - [Utilities](#utilities)
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
    .package(url: "https://github.com/MacPaw/OpenAI.git", .branch("main"))
]
```

## Usage

### Initialization

To initialize API instance you need to [obtain](https://beta.openai.com/account/api-keys) API token from your Open AI organization.

<img width="1081" alt="company" src="https://user-images.githubusercontent.com/1411778/213204726-0772373e-14db-4d5d-9a58-bc249bac4c57.png">

Once you have a token, you can initialize `OpenAI` class, which is an entry point to the API.

```swift
let openAI = OpenAI(apiToken: "YOUR_TOKEN_HERE")
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
        public let max_tokens: Int?
        /// An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered.
        public let top_p: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim.
        public let frequency_penalty: Double?
        /// Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics.
        public let presence_penalty: Double?
        /// Up to 4 sequences where the API will stop generating further tokens. The returned text will not contain the stop sequence.
        public let stop: [String]?
        /// A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
        public let user: String?
    }
```

**Response**

```swift
struct CompletionsResult: Codable {
    public struct Choice: Codable {
        public let text: String
        public let index: Int
    }

    public let id: String
    public let object: String
    public let created: TimeInterval
    public let model: Model
    public let choices: [Choice]
}
```
**Example**

```swift
openAI.completions(query: .init(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, max_tokens: 100, top_p: 1, frequency_penalty: 0, presence_penalty: 0, stop: ["\\n"])) { result in
  //Handle response here
}
```
```swift
    let query = OpenAI.CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?", temperature: 0, max_tokens: 100, top_p: 1, frequency_penalty: 0, presence_penalty: 0, stop: ["\\n"])
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

Review [Completions Documentation](https://beta.openai.com/docs/api-reference/completions) for more info.

### Images

Given a prompt and/or an input image, the model will generate a new image.

As Artificial Intelligence continues to develop, so too does the intriguing concept of Dall-E. Developed by OpenAI, a research lab for artificial intelligence purposes, Dall-E has been classified as an AI system that can generate images based on descriptions provided by humans. With its potential applications spanning from animation and illustration to design and engineering - not to mention the endless possibilities in between - it's easy to see why there is such excitement over this new technology.

**Request**

```swift
struct ImagesQuery: Codable {
    /// A text description of the desired image(s). The maximum length is 1000 characters.
    let prompt: String
    /// The number of images to generate. Must be between 1 and 10.
    let n: Int?
    /// The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024.
    let size: String?
}
```

**Response**

```swift
struct ImagesResult: Codable {
    struct URLResult: Codable {
        public let url: String
    }
    let created: TimeInterval
    let data: [URLResult]
}
```
**Example**

```swift
openAI.images(query: .init(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")) { result in
  //Handle response here
}
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

Review [Images Documentation](https://beta.openai.com/docs/api-reference/images) for more info.

### Embeddings

Get a vector representation of a given input that can be easily consumed by machine learning models and algorithms.

**Request**

```swift
struct EmbeddingsQuery: Codable {
    /// ID of the model to use.
    let model: Model
    /// Input text to get embeddings for
    let input: String
}
```

**Response**

```swift
struct EmbeddingsResult: Codable {

    struct Embedding: Codable {

        public let object: String
        public let embedding: [Double]
        public let index: Int
    }
    let data: [Embedding]
}
```

**Example**

```swift
openAI.embeddings(query: .init(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")) { result in
  //Handle response here
}
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

Review [Embeddings Documentation](https://beta.openai.com/docs/api-reference/embeddings) for more info.

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

## Links

- [OpenAI Documentation](https://beta.openai.com/docs/introduction)
- [OpenAI Playground](https://beta.openai.com/playground)
- [OpenAI Examples](https://beta.openai.com/examples)
- [Dall-E](https://labs.openai.com/)
- [Cosine Similarity](https://en.wikipedia.org/wiki/Cosine_similarity)

## License

```
MIT License

Copyright (c) 2022 MacPaw Inc.

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
