//
//  CustomError.swift
//  FindFriends
//
//  Created by vasu on 01/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

//{"status": 403,
//"error": "Account not found or invalid credentials."}

import Foundation

struct CustomError : Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case statusMessage = "error"
    }
}
extension CustomError: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}
