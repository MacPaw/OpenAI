//
//  ChatStore.swift
//  DemoChat
//
//  Created by Sihao Lu on 3/25/23.
//

import Foundation
import Combine
import OpenAI

public final class AssistantStore: ObservableObject {
    public var openAIClient: OpenAIProtocol
    let idProvider: () -> String
    @Published var selectedAssistantId: String?

    @Published var availableAssistants: [Assistant] = []

    public init(
        openAIClient: OpenAIProtocol,
        idProvider: @escaping () -> String
    ) {
        self.openAIClient = openAIClient
        self.idProvider = idProvider
    }

    // MARK: Models

    @MainActor
    func createAssistant(name: String, description: String, instructions: String, codeInterpreter: Bool, retrievel: Bool, fileIds: [String]? = nil) async -> String? {
        do {
            let tools = createToolsArray(codeInterpreter: codeInterpreter, retrieval: retrievel)
            let query = AssistantsQuery(model: Model.gpt4_1106_preview, name: name, description: description, instructions: instructions, tools:tools, fileIds: fileIds)
            let response = try await openAIClient.assistants(query: query, method: "POST", after: nil)
            
            // Refresh assistants with one just created (or modified)
            let _ = await getAssistants()

            // Returns assistantId
            return response.id

        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
        return nil
    }

    @MainActor
    func modifyAssistant(asstId: String, name: String, description: String, instructions: String, codeInterpreter: Bool, retrievel: Bool, fileIds: [String]? = nil) async -> String? {
        do {
            let tools = createToolsArray(codeInterpreter: codeInterpreter, retrieval: retrievel)
            let query = AssistantsQuery(model: Model.gpt4_1106_preview, name: name, description: description, instructions: instructions, tools:tools, fileIds: fileIds)
            let response = try await openAIClient.assistantModify(query: query, asstId: asstId)

            // Returns assistantId
            return response.id

        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
        return nil
    }

    @MainActor
    func getAssistants(limit: Int = 20, after: String? = nil) async -> [Assistant] {
        do {
            let response = try await openAIClient.assistants(query: nil, method: "GET", after: after)

            var assistants = [Assistant]()
            for result in response.data ?? [] {
                let codeInterpreter = result.tools?.filter { $0.toolType == "code_interpreter" }.first != nil
                let retrieval = result.tools?.filter { $0.toolType == "retrieval" }.first != nil
                let fileIds = result.fileIds ?? []

                assistants.append(Assistant(id: result.id, name: result.name, description: result.description, instructions: result.instructions, codeInterpreter: codeInterpreter, retrieval: retrieval, fileIds: fileIds))
            }
            if after == nil {
                availableAssistants = assistants
            }
            else {
                availableAssistants = availableAssistants + assistants
            }
            return assistants

        } catch {
            // TODO: Better error handling
            print(error.localizedDescription)
        }
        return []
    }

    func selectAssistant(_ assistantId: String?) {
        selectedAssistantId = assistantId
    }

    @MainActor
    func uploadFile(url: URL) async -> FilesResult? {
        do {

            let mimeType = url.mimeType()

            let fileData = try Data(contentsOf: url)

            let result = try await openAIClient.files(query: FilesQuery(purpose: "assistants", file: fileData, fileName: url.lastPathComponent, contentType: mimeType))
            return result
        }
        catch {
            print("error = \(error)")
            return nil
        }
    }

    func createToolsArray(codeInterpreter: Bool, retrieval: Bool) -> [Tool] {
        var tools = [Tool]()
        if codeInterpreter {
            tools.append(Tool(toolType: "code_interpreter"))
        }
        if retrieval {
            tools.append(Tool(toolType: "retrieval"))
        }
        return tools
    }
}
