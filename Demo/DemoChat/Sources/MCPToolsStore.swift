//
//  MCPToolsStore.swift
//  DemoChat
//
//  Created by Tony Li on 24/6/25.
//

import Foundation
import MCP
import OpenAI
import Logging
import SwiftUI

@MainActor
public final class MCPToolsStore: ObservableObject {
    @Published public var availableTools: [MCPToolInfo] = []
    @Published public var enabledTools: Set<String> = []
    @Published public var isConnecting: Bool = false
    @Published public var connectionError: String?
    @Published public var isConnected: Bool = false

    public var githubToken: Binding<String>
    private var mcpClient: MCP.Client?
    private let logger = Logger(label: "mcp.tools.store")

    // Persistence keys
    private let enabledToolsKey = "mcpEnabledTools"
    
    public struct MCPToolInfo: Identifiable, Hashable {
        public let id: String
        public let name: String
        public let description: String
        public let inputSchema: MCP.Value?
        
        public init(from tool: MCP.Tool) {
            self.id = tool.name
            self.name = tool.name
            self.description = tool.description
            self.inputSchema = tool.inputSchema
        }
    }
    
    public init(githubToken: Binding<String>) {
        self.githubToken = githubToken
        loadEnabledTools()

        // Auto-connect if token is available
        if !githubToken.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            Task {
                await connectToGitHubMCP()
            }
        }
    }
    
    /// Connect to GitHub MCP server and discover available tools
    public func connectToGitHubMCP() async {
        isConnecting = true
        connectionError = nil

        // Check if GitHub token is provided
        guard !githubToken.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            connectionError = "GitHub token is required for authentication"
            isConnecting = false
            return
        }

        do {
            // Create MCP client
            let client = MCP.Client(
                name: "OpenAI-Demo",
                version: "1.0.0"
            )

            // Create HTTP transport for GitHub MCP server with authentication headers
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = [
                "Authorization": "Bearer \(githubToken.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines))"
            ]

            let transport = HTTPClientTransport(
                endpoint: URL(string: "https://api.githubcopilot.com/mcp/")!,
                configuration: configuration,
                streaming: true,
                logger: logger
            )
            
            // Connect to the server
            let result = try await client.connect(transport: transport)
            
            // Check if server supports tools
            guard result.capabilities.tools != nil else {
                throw MCPError.invalidRequest("GitHub MCP server does not support tools")
            }
            
            // List available tools
            let toolsResponse = try await client.listTools()

            // Update UI
            self.mcpClient = client
            self.availableTools = toolsResponse.tools.map { MCPToolInfo(from: $0) }
            self.isConnected = true

            // Restore enabled tools that are still available
            let availableToolNames = Set(self.availableTools.map { $0.name })
            self.enabledTools = self.enabledTools.intersection(availableToolNames)

            logger.info("Successfully connected to GitHub MCP server with \(toolsResponse.tools.count) tools")
            
        } catch {
            connectionError = error.localizedDescription
            logger.error("Failed to connect to GitHub MCP server: \(error)")
        }
        
        isConnecting = false
    }
    
    /// Disconnect from MCP server
    public func disconnect() async {
        if let client = mcpClient {
            await client.disconnect()
            mcpClient = nil
        }

        isConnected = false
        availableTools = []
        enabledTools = []
        connectionError = nil

        // Clear the GitHub token from storage
        githubToken.wrappedValue = ""

        // Clear saved enabled tools
        UserDefaults.standard.removeObject(forKey: enabledToolsKey)
    }
    
    /// Toggle tool enabled state
    public func toggleTool(_ toolName: String) {
        if enabledTools.contains(toolName) {
            enabledTools.remove(toolName)
        } else {
            enabledTools.insert(toolName)
        }
        saveEnabledTools()
    }

    /// Enable all available tools
    public func enableAllTools() {
        enabledTools = Set(availableTools.map { $0.name })
        saveEnabledTools()
    }

    /// Disable all tools
    public func disableAllTools() {
        enabledTools.removeAll()
        saveEnabledTools()
    }

    /// Check if all available tools are enabled
    public var areAllToolsEnabled: Bool {
        !availableTools.isEmpty && enabledTools.count == availableTools.count
    }
    
    /// Get list of enabled tool names for OpenAI API
    public var allowedTools: Components.Schemas.MCPTool.AllowedToolsPayload? {
        guard !enabledTools.isEmpty else { return nil }
        return .case1(Array(enabledTools))
    }

    /// Get authentication headers for GitHub MCP server
    public var authHeaders: [String: String]? {
        guard !githubToken.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }
        return ["Authorization": "Bearer \(githubToken.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines))"]
    }

    // MARK: - Persistence

    private func loadEnabledTools() {
        if let savedTools = UserDefaults.standard.array(forKey: enabledToolsKey) as? [String] {
            enabledTools = Set(savedTools)
        }
    }

    private func saveEnabledTools() {
        UserDefaults.standard.set(Array(enabledTools), forKey: enabledToolsKey)
    }

}
