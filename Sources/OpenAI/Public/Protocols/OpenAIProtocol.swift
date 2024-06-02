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
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<CompletionsResult, Error>`, will contain either the `CompletionsResult` object with the generated completions, or an error if the request failed.
    **/
    func completions(query: CompletionsQuery, completion: @escaping (Result<CompletionsResult, Error>) -> Void)

    /**
     This function sends a completions query to the OpenAI API and retrieves generated completions in response. The Completions API enables you to build applications using OpenAI's language models, like the powerful GPT-3. The result is returned by chunks.

     Example:
     ```
     let query = CompletionsQuery(model: .textDavinci_003, prompt: "What is 42?")
     openAI.completions(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: A `CompletionsQuery` object containing the input parameters for the API request. This includes the prompt, model, temperature, max tokens, and other settings.
       - onResult: A closure which receives the result when the API request finishes. The closure's parameter, `Result<CompletionsResult, Error>`, will contain either the `CompletionsResult` object with the generated completions, or an error if the request failed.
       - completion: A closure that is being called when all chunks are delivered or uncrecoverable error occured
    **/
    func completionsStream(query: CompletionsQuery, control: StreamControl, onResult: @escaping (Result<CompletionsResult, Error>) -> Void, completion: ((Error?) -> Void)?)
    
    /**
     This function sends an images query to the OpenAI API and retrieves generated images in response. The Images Generation API enables you to create various images or graphics using OpenAI's powerful deep learning models.

     Example:
     ```
     let query = ImagesQuery(prompt: "White cat with heterochromia sitting on the kitchen table", n: 1, size: ImagesQuery.Size._1024)
     openAI.images(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: An `ImagesQuery` object containing the input parameters for the API request. This includes the query parameters such as the text prompt, image size, and other settings.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ImagesResult, Error>`, will contain either the `ImagesResult` object with the generated images, or an error if the request failed.
    **/
    func images(query: ImagesQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void)
    
    /**
     This function sends an image edit query to the OpenAI API and retrieves generated images in response. The Images Edit API enables you to edit images or graphics using OpenAI's powerful deep learning models.

     Example:
     ```
     let query = ImagesEditQuery(image: "@whitecat.png", prompt: "White cat with heterochromia sitting on the kitchen table with a bowl of food", n: 1, size: ImagesQuery.Size._1024)
     openAI.imageEdits(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: An `ImagesEditQuery` object containing the input parameters for the API request. This includes the query parameters such as the image to be edited, an image to be used a mask if applicable, text prompt, image size, and other settings.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ImagesResult, Error>`, will contain either the `ImagesResult` object with the generated images, or an error if the request failed.
    **/
    func imageEdits(query: ImageEditsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void)
    
    /**
     This function sends an image variation query to the OpenAI API and retrieves generated images in response. The Images Variations API enables you to create a variation of a given image using OpenAI's powerful deep learning models.

     Example:
     ```
     let query = ImagesVariationQuery(image: "@whitecat.png", n: 1, size: ImagesQuery.Size._1024)
     openAI.imageVariations(query: query) { result in
       //Handle result here
     }
     ```
     
     - Parameters:
       - query: An `ImagesVariationQuery` object containing the input parameters for the API request. This includes the query parameters such as the image to use as a basis for the variation(s), image size, and other settings.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ImagesResult, Error>`, will contain either the `ImagesResult` object with the generated images, or an error if the request failed.
    **/
    func imageVariations(query: ImageVariationsQuery, completion: @escaping (Result<ImagesResult, Error>) -> Void)
    
    /**
     This function sends an embeddings query to the OpenAI API and retrieves embeddings in response. The Embeddings API enables you to generate high-dimensional vector representations of texts, which can be used for various natural language processing tasks such as semantic similarity, clustering, and classification.

     Example:
     ```
     let query = EmbeddingsQuery(model: .textSearchBabbageDoc, input: "The food was delicious and the waiter...")
     openAI.embeddings(query: query) { result in
       //Handle response here
     }
     ```
     
     - Parameters:
       - query: An `EmbeddingsQuery` object containing the input parameters for the API request. This includes the list of text prompts to be converted into embeddings, the model to be used, and other settings.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<EmbeddingsResult, Error>`, will contain either the `EmbeddingsResult` object with the generated embeddings, or an error if the request failed.
    **/
    func embeddings(query: EmbeddingsQuery, completion: @escaping (Result<EmbeddingsResult, Error>) -> Void)
    
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
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ChatResult, Error>`, will contain either the `ChatResult` object with the model's response to the conversation, or an error if the request failed.
    **/
    func chats(query: ChatQuery, completion: @escaping (Result<ChatResult, Error>) -> Void)
    
    /**
     This function sends a chat query to the OpenAI API and retrieves chat stream conversation responses. The Chat API enables you to build chatbots or conversational applications using OpenAI's powerful natural language models, like GPT-3. The result is returned by chunks.
     
     Example:
     ```
     let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: "user", content: "who are you")])
     openAI.chats(query: query) { result in
       //Handle response here
     }
     ```

     - Parameters:
       - query: A `ChatQuery` object containing the input parameters for the API request. This includes the lists of message objects for the conversation, the model to be used, and other settings.
       - onResult: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ChatStreamResult, Error>`, will contain either the `ChatStreamResult` object with the model's response to the conversation, or an error if the request failed.
       - completion: A closure that is being called when all chunks are delivered or uncrecoverable error occured
    **/
    func chatsStream(query: ChatQuery, control: StreamControl, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?)
    
    /**
     This function sends a chat query to the OpenAI API and retrieves chat stream conversation responses. 
     
     The Chat API enables you to use custom url to start a chat query.
    **/
    func chatsStream(query: ChatQuery, url: URL, control: StreamControl, onResult: @escaping (Result<ChatStreamResult, Error>) -> Void, completion: ((Error?) -> Void)?)
    
    /**
     This function sends an edits query to the OpenAI API and retrieves an edited version of the prompt based on the instruction given.
     
     Example:
     ```
     let query = EditsQuery(model: .gpt4, input: "What day of the wek is it?", instruction: "Fix the spelling mistakes")
     openAI.edits(query: query) { result in
       //Handle response here
     }
     ```

     - Parameters:
       - query: An `EditsQuery` object containing the input parameters for the API request. This includes the input to be edited, the instruction specifying how it should be edited, and other settings.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<EditsResult, Error>`, will contain either the `EditsResult` object with the model's response to the queried edit, or an error if the request failed.
    **/
    func edits(query: EditsQuery, completion: @escaping (Result<EditsResult, Error>) -> Void)
    
    /**
     This function sends a model query to the OpenAI API and retrieves a model instance, providing owner information. The Models API in this usage enables you to gather detailed information on the model in question, like GPT-3.
     
     Example:
     ```
     let query = ModelQuery(model: .gpt3_5Turbo)
     openAI.model(query: query) { result in
       //Handle response here
     }
     ```

     - Parameters:
       - query: A `ModelQuery` object containing the input parameters for the API request, which is only the model to be queried.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ModelResult, Error>`, will contain either the `ModelResult` object with more information about the model, or an error if the request failed.
    **/
    func model(query: ModelQuery, completion: @escaping (Result<ModelResult, Error>) -> Void)
    
    /**
     This function sends a models query to the OpenAI API and retrieves a list of models. The Models API in this usage enables you to list all the available models.
     
     Example:
     ```
     openAI.models() { result in
       //Handle response here
     }
     ```

     - Parameters:
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ModelsResult, Error>`, will contain either the `ModelsResult` object with the list of model types, or an error if the request failed.
    **/
    func models(completion: @escaping (Result<ModelsResult, Error>) -> Void)
    
    /**
     This function sends a moderations query to the OpenAI API and retrieves a list of category results to classify how text may violate OpenAI's Content Policy.
     
     Example:
     ```
     let query = ModerationsQuery(input: "I want to kill them.")
     openAI.moderations(query: query) { result in
       //Handle response here
     }
     ```

     - Parameters:
       - query: A `ModerationsQuery` object containing the input parameters for the API request. This includes the input text and optionally the model to be used.
       - completion: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ModerationsResult, Error>`, will contain either the `ModerationsResult` object with the list of category results, or an error if the request failed.
    **/
    @available(iOS 13.0, *)
    func moderations(query: ModerationsQuery, completion: @escaping (Result<ModerationsResult, Error>) -> Void)
    
    /**
     This function sends an `AudioSpeechQuery` to the OpenAI API to create audio speech from text using a specific voice and format.
     
     Example:
     ```
     let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 1.0)
     openAI.audioCreateSpeech(query: query) { result in
        // Handle response here
     }
     ```
     
     - Parameters:
       - query: An `AudioSpeechQuery` object containing the parameters for the API request. This includes the Text-to-Speech model to be used, input text, voice to be used for generating the audio, the desired audio format, and the speed of the generated audio.
       - completion: A closure which receives the result. The closure's parameter, `Result<AudioSpeechResult, Error>`, will either contain the `AudioSpeechResult` object with the audio data or an error if the request failed.
     */
    func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping (Result<AudioSpeechResult, Error>) -> Void)
    
    /**
    Transcribes audio data using OpenAI's audio transcription API and completes the operation asynchronously.

    - Parameter query: The `AudioTranscriptionQuery` instance, containing the information required for the transcription request.
    - Parameter completion: The completion handler to be executed upon completion of the transcription request.
                          Returns a `Result` of type `AudioTranscriptionResult` if successful, or an `Error` if an error occurs.
     **/
    func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping (Result<AudioTranscriptionResult, Error>) -> Void)
    
    /**
    Translates audio data using OpenAI's audio translation API and completes the operation asynchronously.

    - Parameter query: The `AudioTranslationQuery` instance, containing the information required for the translation request.
    - Parameter completion: The completion handler to be executed upon completion of the translation request.
                         Returns a `Result` of type `AudioTranslationResult` if successful, or an `Error` if an error occurs.
     **/
    func audioTranslations(query: AudioTranslationQuery, completion: @escaping (Result<AudioTranslationResult, Error>) -> Void)
}
