//
//  SupportedFileType.swift
//
//
//  Created by Chris Dillard on 12/8/23.
//

import Foundation
import UniformTypeIdentifiers

struct SupportedFileType {
    let fileFormat: String
    let mimeType: String
    let isCodeInterpreterSupported: Bool
    let isRetrievalSupported: Bool
}

let supportedFileTypes: [SupportedFileType] = [
    SupportedFileType(fileFormat: "c",    mimeType: "text/x-c",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "cpp",  mimeType: "text/x-c++",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "csv",  mimeType: "application/csv",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "docx", mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "html", mimeType: "text/html",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "java", mimeType: "text/x-java",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "json", mimeType: "application/json",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "md",   mimeType: "text/markdown",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "pdf",  mimeType: "application/pdf",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "php",  mimeType: "text/x-php",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "pptx", mimeType: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "py",   mimeType: "text/x-python",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "rb",   mimeType: "text/x-ruby",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "tex",  mimeType: "text/x-tex",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "txt",  mimeType: "text/plain",
                      isCodeInterpreterSupported: true, isRetrievalSupported: true),
    SupportedFileType(fileFormat: "css",  mimeType: "text/css",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "jpeg", mimeType: "image/jpeg",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "jpg",  mimeType: "image/jpeg",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "js",   mimeType: "text/javascript",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "gif",  mimeType: "image/gif",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "png",  mimeType: "image/png",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "tar",  mimeType: "application/x-tar",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "ts",   mimeType: "application/typescript",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "xlsx", mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "xml",  mimeType: "application/xml", // or \"text/xml\"
                      isCodeInterpreterSupported: true, isRetrievalSupported: false),
    SupportedFileType(fileFormat: "zip",  mimeType: "application/zip",
                      isCodeInterpreterSupported: true, isRetrievalSupported: false)
]

func supportedUITypes() -> [UTType] {
    var supportedTypes: [UTType] = []
    
    for supportedFileType in supportedFileTypes {
        if let newType = UTType(filenameExtension: supportedFileType.fileFormat) {
            supportedTypes += [newType]
        }
    }

    return supportedTypes
}

extension URL {
    func mimeType() -> String {
        guard let utType = UTType(filenameExtension: self.pathExtension) else {
            return "application/octet-stream" // Default type if unknown
        }
        return utType.preferredMIMEType ?? "application/octet-stream"
    }
}
