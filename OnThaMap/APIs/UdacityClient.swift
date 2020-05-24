//  Udacity.swift
//  OnThaMap
//  Created by Khaled Kutbi on 19/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit
import MapKit


//MARK: - Udacity APIs
class UdacityClient {
    
    struct Auth{
        static var sessionId = ""
        static var objectId = ""
    }
    
    
    enum Endpoints {
        static var session = URLSession.shared
        static var base = "https://onthemap-api.udacity.com/v1"
            
            case Login
            case Logout
            case Signup
            case GetStudentsLocations(String, String)
            case PostStudentLocation

        var stringValue: String {
               switch self {
                case .Login:
                    return Endpoints.base + "/session"
                case .Logout:
                    return Endpoints.base + "/session"
                case .Signup:
                    return "https://auth.udacity.com/sign-up"
                case .GetStudentsLocations(let max , let order):
                    return Endpoints.base + "/StudentLocation?limit=" + max + "&order=" + order
                case .PostStudentLocation:
                    return Endpoints.base + "/StudentLocation"
            }
           }
           var url: URL {
               return URL(string: stringValue)!
           }
       }
    
    //MARK: - Login to udacity account request
    class func loginRequest(username:String, password: String, completion: @escaping (Bool, Error?) -> Void)  {
        
        var request = URLRequest(url: Endpoints.Login.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            // no data received
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false, error)
                }
                return
            }
            
            // data received but may be an error message
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            print("Login: \n"+String(data: newData, encoding: .utf8)!)
            let decoder = JSONDecoder()
            do {
                let loginFailedResponse = try decoder.decode(FailedResponse.self, from: newData)
                             DispatchQueue.main.async {
                                 completion(false, loginFailedResponse)
                             }
                             return
            }catch{
                let loginResponse = try! decoder.decode(Login.self, from: newData)
                Auth.sessionId = loginResponse.session.id
                Auth.objectId = loginResponse.account.key
                DispatchQueue.main.async {
                                  completion(true, nil)
                }
                              return
            }

        }
        task.resume()
        
    }
     //MARK: - Logout from udacity account request
    class func logoutRequest(completion:@escaping(Bool,Error?) -> Void){
    
        var request = URLRequest(url:Endpoints.Logout.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(false,error)
                }
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range) /* subset response data! */
            let decoder = JSONDecoder()
            do {
                _ = try decoder.decode(Logout.self, from: newData)
                Auth.sessionId = ""
                DispatchQueue.main.async{
                completion(true,nil)
                }
            }catch{
                completion(false,error)
            }
        }
        task.resume()
}
     //MARK: - Get student location request
    class func getStudentLocation(completion: @escaping([StudentsInformation],Error?) -> Void){
        let max = "100"
        let order = "-updatedAt"
        let request = URLRequest(url: Endpoints.GetStudentsLocations(max, order).url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
                     guard let data = data else {
                         completion ([], error)
                         return
                     }
                let decoder = JSONDecoder()
                     do {
                        let studentInformationResponse = try decoder.decode(StudentsLocationsResponse.self, from: data)
                         DispatchQueue.main.async {
                            completion(studentInformationResponse.results, nil)
                           
                         }
                     } catch let error {
                         DispatchQueue.main.async {
                             completion([],error)
                         }
                         return
                     }
                 }
             task.resume()
    }
     //MARK: - Post student location request
    class func postStudentLocation(location:MKPlacemark,mediaURL:String,completion:@escaping(Bool,Error?) -> Void){
        var request = URLRequest(url: Endpoints.PostStudentLocation.url)
        request.httpMethod = "POST"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
 
        request.httpBody = "{\"uniqueKey\": \"\(Auth.objectId)\", \"firstName\": \"khaled\", \"lastName\": \"kutbi\",\"mapString\": \"\(location.name ?? "")\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(location.coordinate.latitude), \"longitude\": \(location.coordinate.longitude)}".data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else{
                DispatchQueue.main.async {
                    completion(false,error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                _ = try decoder.decode(PostStudentLocation.self, from: data)
                DispatchQueue.main.async {
                    completion(true,nil)
                }
            }catch let error {
                DispatchQueue.main.async {
                    completion(false,error)
                }
                return
            }
    
        }
        task.resume()
    }
}
