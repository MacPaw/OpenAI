//
//  File.swift
//  
//
//  Created by Sergii Kryvoblotskyi on 02/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol URLRequestBuildable {
    func build(token: String, organizationIdentifier: String?, timeoutInterval: TimeInterval) throws -> URLRequest
}
