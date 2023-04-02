//
//  MultipartFormDataEntry.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation

enum MultipartFormDataEntry {
    
    case file(paramName: String, fileName: String, fileData: Data, contentType: String),
         string(paramName: String, value: Any?)
}
