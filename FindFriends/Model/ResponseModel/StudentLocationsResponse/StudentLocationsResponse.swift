//
//  StudentLocationsResponse.swift
//  FindFriends
//
//  Created by vasu on 02/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import Foundation


//"results": [
//{
//    "objectId": "uwe7q3l2Zn",
//    "uniqueKey": "nil",
//    "firstName": "wow",
//    "lastName": "weee",
//    "mapString": "uhhh",
//    "mediaURL": "hggug",
//    "latitude": 39.323777,
//    "longitude": -111.6782223,
//    "createdAt": "2019-01-02T17: 38: 33.811Z",
//    "updatedAt": "2019-01-02T17: 38: 33.811Z"
//}
//]

struct StudentLocationsResponse : Codable {
    
    let results : [StudentDetailsResponse]
}

struct StudentDetailsResponse : Codable{
    let objectId   : String?
    let uniqueKey  : String?
    let firstName  : String?
    let lastName   : String?
    let mapString  : String?
    let mediaURL   : String?
    let latitude   : Float?
    let longitude  : Float?
    let createdAt  : String?
    let updatedAt  : String?
}
