//
//  OpenAIProvider.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

public protocol OpenAIProtocol {
    
    /**
     This function sends a completions query to the OpenAI API and retrieves generated completions in response. The Completions API enables you to build applications using OpenAI's language models, like the powerful GPT-3.

     Example:
     ```
     let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?")
     openAI.completions(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: A `CompletionsQuery` object containing the input parameters for the API request. This includes the prompt, model, temperature, max tokens, and other settings.
       - timeoutInterval: A `TimeInterval` specifying the timeout for the API request. If the specified interval elapses before the API request completes, the function will return an error.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<CompletionsResult, Error>`, will contain either the `CompletionsResult` object with the generated completions, or an error if the request failed.
    **/
    func completions(query: CompletionsQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<CompletionsResult, Error>) -> Void)
    
    /**
     This function sends an images query to the OpenAI API and retrieves generated images in response. The Images Generation API enables you to create various images or graphics using OpenAI's powerful deep learning models.

     Example:
     ```
     let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: "1024x1024")
     openAI.images(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: An `ImagesQuery` object containing the input parameters for the API request. This includes the query parameters such as the model, text prompt, image size, and other settings.
       - timeoutInterval: A `TimeInterval` specifying the timeout for the API request. If the specified interval elapses before the API request completes, the function will return an error.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ImagesResult, Error>`, will contain either the `ImagesResult` object with the generated images, or an error if the request failed.
    **/
    func images(query: ImagesQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<ImagesResult, Error>) -> Void)
    
    /**
     This function sends an embeddings query to the OpenAI API and retrieves embeddings in response. The Embeddings API enables you to generate high-dimensional vector representations of texts, which can be used for various natural language processing tasks such as semantic similarity, clustering, and classification.

     Example:
     ```
     let query = EmbeddingsQuery(model: .textSearchBabbadgeDoc, input: "The food was delicious and the waiter...")
     openAI.embeddings(query: query) { result in
       //Handle response here
     }
     ```
     
     - Parameters:
       - query: An `EmbeddingsQuery` object containing the input parameters for the API request. This includes the list of text prompts to be converted into embeddings, the model to be used, and other settings.
       - timeoutInterval: A `TimeInterval` specifying the timeout for the API request. If the specified interval elapses before the API request completes, the function will return an error.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<EmbeddingsResult, Error>`, will contain either the `EmbeddingsResult` object with the generated embeddings, or an error if the request failed.
    **/
    func embeddings(query: EmbeddingsQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void)
    
    /**
     This function sends a chat query to the OpenAI API and retrieves chat conversation responses. The Chat API enables you to build chatbots or conversational applications using OpenAI's powerful natural language models, like GPT-3.
     
     Example:
     ```
     let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: "user", content: "who are you")])
     openAI.chats(query: query) { result in
       //Handle response here
     }
     ```

     - Parameters:
       - query: A `ChatQuery` object containing the input parameters for the API request. This includes the lists of message objects for the conversation, the model to be used, and other settings.
       - timeoutInterval: A `TimeInterval` specifying the timeout for the API request. If the specified interval elapses before the API request completes, the function will return an error.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ChatResult, Error>`, will contain either the `ChatResult` object with the model's response to the conversation, or an error if the request failed.
    **/
    func chats(query: ChatQuery, timeoutInterval: TimeInterval, completion: @escaping (Result<ChatResult, Error>) -> Void)
}
