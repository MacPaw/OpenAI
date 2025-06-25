//
//  MCPToolsView.swift
//  DemoChat
//
//  Created by Tony Li on 24/6/25.
//

import SwiftUI
import MCP

public struct MCPToolsView: View {
    @ObservedObject var mcpStore: MCPToolsStore
    
    public init(mcpStore: MCPToolsStore) {
        self.mcpStore = mcpStore
    }
    
    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // GitHub Token Input
                    githubTokenSection

                    // Connection Status
                    connectionStatusSection

                    // Tools List
                    if mcpStore.isConnected {
                        toolsListSection
                    }
                }
                .padding()
            }
        }
    }

    private var githubTokenSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("GitHub Token")
                    .font(.headline)

                Spacer()

                Link("Get Token", destination: URL(string: "https://github.com/settings/tokens")!)
                    .font(.caption)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Enter your GitHub personal access token to authenticate with GitHub MCP server:")
                    .font(.caption)
                    .foregroundColor(.secondary)

                SecureField("GitHub Token (ghp_...)", text: mcpStore.githubToken)
                    .textFieldStyle(.roundedBorder)
                    .font(.caption)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }

    private var connectionStatusSection: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: mcpStore.isConnected ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(mcpStore.isConnected ? .green : .red)
                
                Text(mcpStore.isConnected ? "Connected to GitHub MCP" : "Not Connected")
                    .font(.headline)
                
                Spacer()
            }
            
            if let error = mcpStore.connectionError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                if mcpStore.isConnecting {
                    ProgressView()
                        .scaleEffect(0.8)
                    Text("Connecting...")
                        .font(.caption)
                } else if mcpStore.isConnected {
                    Button("Disconnect") {
                        Task {
                            await mcpStore.disconnect()
                        }
                    }
                    .buttonStyle(.bordered)
                } else {
                    Button("Connect to GitHub MCP") {
                        Task {
                            await mcpStore.connectToGitHubMCP()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
    
    private var toolsListSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Available Tools")
                    .font(.headline)

                Spacer()

                Text("\(mcpStore.enabledTools.count) enabled")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            // Toggle All Tools Section
            if !mcpStore.availableTools.isEmpty {
                HStack {
                    Text("Enable All Tools")
                        .font(.subheadline)
                        .foregroundColor(.primary)

                    Spacer()

                    Toggle("", isOn: Binding(
                        get: { mcpStore.areAllToolsEnabled },
                        set: { isEnabled in
                            if isEnabled {
                                mcpStore.enableAllTools()
                            } else {
                                mcpStore.disableAllTools()
                            }
                        }
                    ))
                    .labelsHidden()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            
            if mcpStore.availableTools.isEmpty {
                Text("No tools available")
                    .foregroundColor(.secondary)
                    .italic()
                    .padding()
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(mcpStore.availableTools) { tool in
                        toolRow(tool)
                    }
                }
            }
        }
    }
    
    private func toolRow(_ tool: MCPToolsStore.MCPToolInfo) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(tool.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(tool.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { mcpStore.enabledTools.contains(tool.name) },
                set: { _ in mcpStore.toggleTool(tool.name) }
            ))
            .labelsHidden()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(mcpStore.enabledTools.contains(tool.name) ? Color.blue.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(8)
    }

}
