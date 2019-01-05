//
//  LoginEngine.swift
//  FindFriends
//
//  Created by vasu on 31/12/18.
//  Copyright © 2018 Vasu. All rights reserved.
//

import Foundation

class Engine {
    
   static var mDataSource : [StudentDetailsResponse]?
    
    class func taskForGETRequest<ResponseType :Decodable>(url : URL,responseType : ResponseType.Type ,completion: @escaping (ResponseType? ,Error? ) -> Void){
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["X-Parse-Application-Id":AppCredentials.Parse_Application_ID ,"X-Parse-REST-API-Key":AppCredentials.REST_API_Key ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(nil,error)
                }
                return
            }

            let decoder = JSONDecoder()
            
            do{
                let responseData = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseData, nil)
                }
            }
            catch{
                do{
                    let errorResponse = try decoder.decode(CustomError.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil,errorResponse)
                    }
                }catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType,loginFlag:Bool = true ,completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            
            let range = Range(5..<data.count)
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: loginFlag ? newData : data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch
            {
              do{
                let errorResponse = try decoder.decode(CustomError.self, from: newData) as Error
                DispatchQueue.main.async {
                        completion(nil,errorResponse)
                }
              }catch{
                    DispatchQueue.main.async {
                    completion(nil, error)
                    }
              }
    
            }
        }
       
        task.resume()
    }
    
    class func login(usrname: String, password : String , completion : @escaping(Bool?,Error?)->Void)
    {
        let bodyValue = LoginDetails.init(username:usrname , password: password)
        let body = LoginRequest.init(udacity: bodyValue)
        taskForPOSTRequest(url: APIEndPoints.EndPoints.login.url, responseType: LoginResponse.self, body: body) {
            (data, error) in
            if let _ = data {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    class func getUsersLocation(completion:@escaping (StudentLocationsResponse?,Error?)->Void){
     
        taskForGETRequest(url: APIEndPoints.EndPoints.getUserLocations.url, responseType: StudentLocationsResponse.self) {
            (data, error) in
            
            if let response = data {
                
                mDataSource = response.results
                completion(response ,nil)
            }
            else{
                completion(nil,error)
            }
            
            
        }
        
    }
    class func postUserLocation(dataobj :StudentDetailsRequest ,completion:@escaping(Bool,Error?)->Void){
        
        taskForPOSTRequest(url: APIEndPoints.EndPoints.postUserLocation.url,responseType: postLocationResponse.self, body: dataobj,loginFlag: false)
        {
            (response, error) in
            
            if let _ = response {
                completion(true,nil)
            }
            else
            {
                completion(false,error)
            }
            
            
        }
        
        
    }
}
