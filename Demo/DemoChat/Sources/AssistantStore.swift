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
    func createAssistant(name: String, description: String, instructions: String, codeInterpreter: Bool, fileSearch: Bool, functions: [FunctionDeclaration], fileIds: [String]? = nil) async -> String? {
        do {
            let toolResources: ToolResources? = if let fileIds {
                ToolResources(fileSearch: nil, codeInterpreter: .init(fileIds: fileIds))
            } else {
                nil
            }
            
            let tools = createToolsArray(codeInterpreter: codeInterpreter, fileSearch: fileSearch, functions: functions)
            let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools:tools, toolResources: toolResources)
            let response = try await openAIClient.assistantCreate(query: query)
            
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
    func modifyAssistant(asstId: String, name: String, description: String, instructions: String, codeInterpreter: Bool, fileSearch: Bool, functions: [FunctionDeclaration], fileIds: [String]? = nil) async -> String? {
        do {
            let toolResources: ToolResources? = if let fileIds {
                ToolResources(fileSearch: nil, codeInterpreter: .init(fileIds: fileIds))
            } else {
                nil
            }
            
            let tools = createToolsArray(codeInterpreter: codeInterpreter, fileSearch: fileSearch, functions: functions)
            let query = AssistantsQuery(model: Model.gpt4_o_mini, name: name, description: description, instructions: instructions, tools:tools, toolResources: toolResources)
            let response = try await openAIClient.assistantModify(query: query, assistantId: asstId)

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
            let response = try await openAIClient.assistants(after: after)

            var assistants = [Assistant]()
            for result in response.data ?? [] {
                let tools = result.tools ?? []
                let codeInterpreter = tools.contains { $0 == .codeInterpreter }
                let fileSearch = tools.contains { $0 == .fileSearch }
                let functions = tools.compactMap {
                    switch $0 {
                    case let .function(declaration):
                        return declaration
                    default:
                        return nil
                    }
                }
                let fileIds = result.toolResources?.codeInterpreter?.fileIds ?? []

                assistants.append(Assistant(id: result.id, name: result.name ?? "", description: result.description, instructions: result.instructions, codeInterpreter: codeInterpreter, fileSearch: fileSearch, fileIds: fileIds, functions: functions))
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

    func createToolsArray(codeInterpreter: Bool, fileSearch: Bool, functions: [FunctionDeclaration]) -> [Tool] {
        var tools = [Tool]()
        if codeInterpreter {
            tools.append(.codeInterpreter)
        }
        if fileSearch {
            tools.append(.fileSearch)
        }
        return tools + functions.map { .function($0) }
    }
}
