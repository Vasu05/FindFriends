//
//  LoginResponse.swift
//  FindFriends
//
//  Created by vasu on 31/12/18.
//  Copyright © 2018 Vasu. All rights reserved.
//

import Foundation

//{
//    "account":{
//        "registered":true,
//        "key":"3903878747"
//    },
//    "session":{
//        "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
//        "expiration":"2015-05-10T16:48:30.760460Z"
//    }
//}

struct LoginResponse : Codable {
  
    let account : account
    let session : session
}

struct account : Codable {
    let registered : Bool
    let key        : String
}

struct session : Codable{
    let id  : String
    let expiration : String
}
