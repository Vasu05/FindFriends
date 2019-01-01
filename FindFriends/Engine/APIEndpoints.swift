//
//  APIEndpoints.swift
//  FindFriends
//
//  Created by vasu on 31/12/18.
//  Copyright © 2018 Vasu. All rights reserved.
//

import Foundation

class APIEndPoints{
    
    enum EndPoints {
        
        static let base = "https://parse.udacity.com/parse/classes"
        
        case login
        
        
        var stringValue: String {
            switch self {
            case .login:
                  return "https://onthemap-api.udacity.com/v1/session"
            
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
}
