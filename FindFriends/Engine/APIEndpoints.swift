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
        case getUserLocations
        case postUserLocation
        case signup
        
        var stringValue: String {
            switch self {
            case .login:
                  return "https://onthemap-api.udacity.com/v1/session"
            case .getUserLocations:
                return    APIEndPoints.EndPoints.base+"/StudentLocation?limit=100&order=-updatedAt"
            case .postUserLocation:
                return  APIEndPoints.EndPoints.base+"/StudentLocation"
                
            case .signup:
                return "https://auth.udacity.com/sign-up"
            
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
}
