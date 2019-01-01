//
//  LoginRequest.swift
//  FindFriends
//
//  Created by vasu on 31/12/18.
//  Copyright © 2018 Vasu. All rights reserved.
//

//{
//    "udacity" : {
//        "username" : "Vasuchnd@gmail.com",
//        "password" : "****"
//    }
//}

import Foundation


struct LoginRequest : Codable{
    
    let udacity : LoginDetails
    
}

struct LoginDetails : Codable{
    
    let username : String
    let password : String    
}
