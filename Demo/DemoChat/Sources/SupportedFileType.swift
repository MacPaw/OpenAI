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
    let isFileSearchSupported: Bool
}

let supportedFileTypes: [SupportedFileType] = [
    SupportedFileType(fileFormat: "c",    mimeType: "text/x-c",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "cpp",  mimeType: "text/x-c++",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "csv",  mimeType: "application/csv",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "docx", mimeType: "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "html", mimeType: "text/html",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "java", mimeType: "text/x-java",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "json", mimeType: "application/json",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "md",   mimeType: "text/markdown",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "pdf",  mimeType: "application/pdf",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "php",  mimeType: "text/x-php",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "pptx", mimeType: "application/vnd.openxmlformats-officedocument.presentationml.presentation",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "py",   mimeType: "text/x-python",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "rb",   mimeType: "text/x-ruby",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "tex",  mimeType: "text/x-tex",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "txt",  mimeType: "text/plain",
                      isCodeInterpreterSupported: true, isFileSearchSupported: true),
    SupportedFileType(fileFormat: "css",  mimeType: "text/css",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "jpeg", mimeType: "image/jpeg",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "jpg",  mimeType: "image/jpeg",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "js",   mimeType: "text/javascript",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "gif",  mimeType: "image/gif",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "png",  mimeType: "image/png",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "tar",  mimeType: "application/x-tar",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "ts",   mimeType: "application/typescript",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "xlsx", mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "xml",  mimeType: "application/xml", // or \"text/xml\"
                      isCodeInterpreterSupported: true, isFileSearchSupported: false),
    SupportedFileType(fileFormat: "zip",  mimeType: "application/zip",
                      isCodeInterpreterSupported: true, isFileSearchSupported: false)
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
