//
//  MCPApprovalDialogView.swift
//  DemoChat
//
//  Created by Tony Li on 24/6/25.
//

import SwiftUI
import OpenAI

struct MCPApprovalDialogView: View {
    let approvalRequest: Components.Schemas.MCPApprovalRequest
    let onApprove: () -> Void
    let onDeny: () -> Void
    let onCancel: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Image(systemName: "shield.checkered")
                    .foregroundColor(.orange)
                    .font(.title2)
                
                Text("MCP Tool Permission Request")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
            }
            
            // Request details
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Server:")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(serverDisplayName)
                        .fontWeight(.medium)
                }
                
                HStack {
                    Text("Tool:")
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(approvalRequest.name)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                
                let arguments = approvalRequest.arguments
                
                if !arguments.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Arguments:")
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        ScrollView {
                            Text(formattedArguments)
                                .font(.system(.caption, design: .monospaced))
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(6)
                        }
                        .frame(maxHeight: 100)
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            
            // Warning message
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.orange)
                
                Text("This tool will have access to your data. Only approve if you trust this request.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            // Action buttons
            HStack(spacing: 12) {
                Button("Cancel") {
                    onCancel()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.secondary)
                
                Spacer()
                
                Button("Deny") {
                    onDeny()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                
                Button("Approve") {
                    onApprove()
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(.white)
            }
        }
        .padding(20)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
    
    private var serverDisplayName: String {
        // Use the server label directly since it's already a human-readable name
        return approvalRequest.serverLabel
    }
    
    private var formattedArguments: String {
        let arguments = approvalRequest.arguments
        
        // Try to format JSON nicely
        if let data = arguments.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data),
           let prettyData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            return prettyString
        }
        
        // Fallback to original string
        return arguments
    }
}
