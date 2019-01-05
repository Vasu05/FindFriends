//
//  PostLocationRequest.swift
//  FindFriends
//
//  Created by vasu on 04/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import Foundation

//"{\"uniqueKey\": \"1234\",
//  \"firstName\": \"John\",
//\"lastName\": \"Doe\",
//\"mapString\": \"Mountain View, CA\",
//\"mediaURL\": \"https://udacity.com\",
//\"latitude\": 37.386052,
//\"longitude\": -122.083851}"

struct StudentDetailsRequest: Codable{
    let uniqueKey  : String?
    let firstName  : String?
    let lastName   : String?
    let mapString  : String?
    let mediaURL   : String?
    let latitude   : Double?
    let longitude  : Double?
}
