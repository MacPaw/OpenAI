//
//  OpenAIProtocol.swift
//  OpenAI
//
//  Created by Oleksii Nezhyborets on 01.02.2025.
//

import Foundation

#if canImport(Combine)
@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol OpenAIModern: OpenAIAsync, OpenAICombine {}
#else
@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol OpenAIModern: OpenAIAsync {}
#endif

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
extension OpenAI: OpenAIProtocol {}

@available(iOS 13.0, tvOS 13.0, macOS 10.15, watchOS 6.0, *)
public protocol OpenAIProtocol: OpenAIModern {
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
    @discardableResult func images(query: ImagesQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func imageEdits(query: ImageEditsQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func imageVariations(query: ImageVariationsQuery, completion: @escaping @Sendable (Result<ImagesResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func embeddings(query: EmbeddingsQuery, completion: @escaping @Sendable (Result<EmbeddingsResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func chats(query: ChatQuery, completion: @escaping @Sendable (Result<ChatResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a chat query to the OpenAI API and retrieves chat stream conversation responses. The Chat API enables you to build chatbots or conversational applications using OpenAI's powerful natural language models, like GPT-3. The result is returned by chunks.
     
     Example:
     ```
     let query = ChatQuery(model: .gpt3_5Turbo, messages: [.init(role: "user", content: "who are you")])
     let cancellable = openAI.chats(query: query) { result in
         //Handle response here
     }
     // Hold reference to `cancellableSession` to keep it alive
     // Call `cancellable.cancelRequest()` when done
     ```
     
     - Parameters:
        - query: A `ChatQuery` object containing the input parameters for the API request. This includes the lists of message objects for the conversation, the model to be used, and other settings.
        - onResult: A closure which receives the result when the API request finishes. The closure's parameter, `Result<ChatStreamResult, Error>`, will contain either the `ChatStreamResult` object with the model's response to the conversation, or an error if the request failed.
        - completion: A closure that is being called when all chunks are delivered or uncrecoverable error occured.
     
     - Returns: An object that references the streaming session.
     
     - Note: This method creates and configures separate session object specifically for streaming. In order for it to work properly and don't leak memory you should hold a reference to the returned value, and when you're done - call cancel() on it.
     */
    @discardableResult func chatsStream(query: ChatQuery, onResult: @escaping @Sendable (Result<ChatStreamResult, Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest
    
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
    @discardableResult func model(query: ModelQuery, completion: @escaping @Sendable (Result<ModelResult, Error>) -> Void) -> CancellableRequest
    
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
     */
    @discardableResult func models(completion: @escaping @Sendable (Result<ModelsResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func moderations(query: ModerationsQuery, completion: @escaping @Sendable (Result<ModerationsResult, Error>) -> Void) -> CancellableRequest
    
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
    @discardableResult func audioCreateSpeech(query: AudioSpeechQuery, completion: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void) -> CancellableRequest
    
    /** This function sends an `AudioSpeechQuery` to the OpenAI API to create audio speech from text using a specific voice and format.
     Example:
     ```
     let query = AudioSpeechQuery(model: .tts_1, input: "Hello, world!", voice: .alloy, responseFormat: .mp3, speed: 1.0)
     openAI.audioCreateSpeechStream(query: query) { result in
        // Handle response here
     }
     ```
     - Parameters:
       - query: An `AudioSpeechQuery` object containing the parameters for the API request. This includes the Text-to-Speech model to be used, input text, voice to be used for generating the audio, the desired audio format, and the speed of the generated audio.
       - onResult: A closure which receives the result when the API request finishes. The closure's parameter, `Result<AudioSpeechResult, Error>`, will contain either the `AudioSpeechResult` object with the generated Audio chunk, or an error if the request failed.
       - completion: A closure that is being called when all chunks are delivered or uncrecoverable error occured
    */
    func audioCreateSpeechStream(query: AudioSpeechQuery, onResult: @escaping @Sendable (Result<AudioSpeechResult, Error>) -> Void, completion: (@Sendable (Error?) -> Void)?) -> CancellableRequest

    /**
     Transcribes audio data using OpenAI's audio transcription API and completes the operation asynchronously.
     
     - Parameter query: The `AudioTranscriptionQuery` instance, containing the information required for the transcription request.
     - Parameter completion: The completion handler to be executed upon completion of the transcription request.
     Returns a `Result` of type `AudioTranscriptionResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func audioTranscriptions(query: AudioTranscriptionQuery, completion: @escaping @Sendable (Result<AudioTranscriptionResult, Error>) -> Void) -> CancellableRequest
    
    /**
     Translates audio data using OpenAI's audio translation API and completes the operation asynchronously.
     
     - Parameter query: The `AudioTranslationQuery` instance, containing the information required for the translation request.
     - Parameter completion: The completion handler to be executed upon completion of the translation request.
     Returns a `Result` of type `AudioTranslationResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func audioTranslations(query: AudioTranslationQuery, completion: @escaping @Sendable (Result<AudioTranslationResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a assistants query to the OpenAI API to list assistants that have been created.
     
     Example: List Assistants
     ```
     openAI.assistants() { result in
     //Handle response here
     }
     ```
     
     - Parameter after: A cursor for use in pagination. after is an object ID that defines your place in the list.
     - Parameter completion: The completion handler to be executed upon completion of the assistant request.
     Returns a `Result` of type `AssistantsResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func assistants(after: String?, completion: @escaping @Sendable (Result<AssistantsResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends an assistants query to the OpenAI API and creates an assistant.
     
     ```
     let query = AssistantsQuery(model: Model.gpt4_1106_preview, name: name, description: description, instructions: instructions, tools: tools, fileIds: fileIds)
     openAI.createAssistant(query: query) { result in
     //Handle response here
     }
     ```
     
     - Parameter query: The `AssistantsQuery` instance, containing the information required for the assistant request.
     - Parameter completion: The completion handler to be executed upon completion of the assistant request.
     Returns a `Result` of type `AssistantResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func assistantCreate(query: AssistantsQuery, completion: @escaping @Sendable (Result<AssistantResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a assistants query to the OpenAI API and modifies an assistant. The Assistants API in this usage enables you to modify an assistant.
     
     Example: Modify Assistant
     ```
     let query = AssistantsQuery(model: Model.gpt4_1106_preview, name: name, description: description, instructions: instructions, tools: tools, fileIds: fileIds)
     openAI.assistantModify(query: query, assistantId: "asst_1234") { result in
     //Handle response here
     }
     ```
     
     - Parameter query: The `AssistantsQuery` instance, containing the information required for the assistant request.
     - Parameter assistantId: The assistant id for the assistant to modify.
     - Parameter completion: The completion handler to be executed upon completion of the assistant request.
     Returns a `Result` of type `AssistantResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func assistantModify(query: AssistantsQuery, assistantId: String, completion: @escaping @Sendable (Result<AssistantResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a threads query to the OpenAI API and creates a thread. The Threads API in this usage enables you to create a thread.
     
     Example: Create Thread
     ```
     let threadsQuery = ThreadsQuery(messages: [Chat(role: message.role, content: message.content)])
     openAI.threads(query: threadsQuery) { result in
     //Handle response here
     }
     
     ```
     - Parameter query: The `ThreadsQuery` instance, containing the information required for the threads request.
     - Parameter completion: The completion handler to be executed upon completion of the threads request.
     Returns a `Result` of type `ThreadsResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func threads(query: ThreadsQuery, completion: @escaping @Sendable (Result<ThreadsResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a threads query to the OpenAI API that creates and runs a thread in a single request.
     
     Example: Create and Run Thread
     ```
     let threadsQuery = ThreadQuery(messages: [Chat(role: message.role, content: message.content)])
     let threadRunQuery = ThreadRunQuery(assistantId: "asst_1234"  thread: threadsQuery)
     openAI.threadRun(query: threadRunQuery) { result in
     //Handle response here
     }
     ```
     - Parameter query: The `ThreadRunQuery` instance, containing the information required for the request.
     - Parameter completion: The completion handler to be executed upon completion of the threads request.
     Returns a `Result` of type `RunResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func threadRun(query: ThreadRunQuery, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a runs query to the OpenAI API and creates a run. The Runs API in this usage enables you to create a run.
     
     Example: Create Run
     ```
     let runsQuery = RunsQuery(assistantId:  currentAssistantId)
     openAI.runs(threadId: threadsResult.id, query: runsQuery) { result in
     //Handle response here
     }
     ```
     
     - Parameter threadId: The thread id for the thread to run.
     - Parameter query: The `RunsQuery` instance, containing the information required for the runs request.
     - Parameter completion: The completion handler to be executed upon completion of the runs request.
     Returns a `Result` of type `RunResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func runs(threadId: String, query: RunsQuery, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a thread id and run id to the OpenAI API and retrieves a run. The Runs API in this usage enables you to retrieve a run.
     
     Example: Retrieve Run
     ```
     openAI.runRetrieve(threadId: currentThreadId, runId: currentRunId) { result in
     //Handle response here
     }
     ```
     - Parameter threadId: The thread id for the thread to run.
     - Parameter runId: The run id for the run to retrieve.
     - Parameter completion: The completion handler to be executed upon completion of the runRetrieve request.
     Returns a `Result` of type `RunRetrieveResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func runRetrieve(threadId: String, runId: String, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a thread id and run id to the OpenAI API and retrieves a list of run steps. The Runs API in this usage enables you to retrieve a runs run steps.
     
     Example: Retrieve Run Steps
     ```
     openAI.runRetrieveSteps(threadId: currentThreadId, runId: currentRunId) { result in
     //Handle response here
     }
     ```
     - Parameter threadId: The thread id for the thread to run.
     - Parameter runId: The run id for the run to retrieve.
     - Parameter before: String?: The message id for the run step that defines your place in the list of run steps. Pass nil to get all.
     - Parameter completion: The completion handler to be executed upon completion of the runRetrieve request.
     Returns a `Result` of type `RunRetrieveStepsResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func runRetrieveSteps(threadId: String, runId: String, before: String?, completion: @escaping @Sendable (Result<RunRetrieveStepsResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function submits tool outputs for a run to the OpenAI API. It should be submitted when a run is in status `required_action` and `required_action.type` is `submit_tool_outputs`
     
     - Parameter threadId: The thread id for the thread which needs tool outputs.
     - Parameter runId: The run id for the run  which needs tool outputs.
     - Parameter query: An object containing the tool outputs, populated based on the results of the requested function call
     - Parameter completion: The completion handler to be executed upon completion of the runSubmitToolOutputs request.
     Returns a `Result` of type `RunResult` if successful, or an `Error` if an error occurs.
     */
    @discardableResult func runSubmitToolOutputs(threadId: String, runId: String, query: RunToolOutputsQuery, completion: @escaping @Sendable (Result<RunResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a thread id and run id to the OpenAI API and retrieves a threads messages.
     The Thread API in this usage enables you to retrieve a threads messages.
     
     Example: Get Threads Messages
     ```
     openAI.threadsMessages(threadId: currentThreadId) { result in
     //Handle response here
     }
     ```
     
     - Parameter threadId: The thread id for the thread to run.
     - Parameter before: String?: The message id for the message that defines your place in the list of messages. Pass nil to get all.
     - Parameter completion: The completion handler to be executed upon completion of the runRetrieve request.
     Returns a `Result` of type `ThreadsMessagesResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func threadsMessages(threadId: String, before: String?, completion: @escaping @Sendable (Result<ThreadsMessagesResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a thread id and message contents to the OpenAI API and returns a run.
     
     Example: Add Message to Thread
     ```
     let query = MessageQuery(role: message.role.rawValue, content: message.content)
     openAI.threadsAddMessage(threadId: currentThreadId, query: query) { result in
     //Handle response here
     }
     ```
     
     - Parameter threadId: The thread id for the thread to run.
     - Parameter query: The `MessageQuery` instance, containing the information required for the threads request.
     - Parameter completion: The completion handler to be executed upon completion of the runRetrieve request.
     Returns a `Result` of type `ThreadAddMessageResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func threadsAddMessage(threadId: String, query: MessageQuery, completion: @escaping @Sendable (Result<ThreadAddMessageResult, Error>) -> Void) -> CancellableRequest
    
    /**
     This function sends a purpose string, file contents, and fileName contents to the OpenAI API and returns a file id result.
     
     Example: Upload file
     ```
     let query = FilesQuery(purpose: "assistants", file: fileData, fileName: url.lastPathComponent, contentType: "application/pdf")
     openAI.files(query: query) { result in
     //Handle response here
     }
     ```
     - Parameter query: The `FilesQuery` instance, containing the information required for the files request.
     - Parameter completion: The completion handler to be executed upon completion of the files request.
     Returns a `Result` of type `FilesResult` if successful, or an `Error` if an error occurs.
     **/
    @discardableResult func files(query: FilesQuery, completion: @escaping @Sendable (Result<FilesResult, Error>) -> Void) -> CancellableRequest
}
