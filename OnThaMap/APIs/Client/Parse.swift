//  Parse.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 19/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.

import UIKit


//MARK: - Parse APIs
class ParseClient {
    
    enum Endpoints {
 
        case getStudentsLocations

        var stringValue: String {
            switch self {
            case .getStudentsLocations:
                return "https://onthemap-api.udacity.com/v1/StudentLocation"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getStudentsLocations(completion:@escaping([StudentLocations],Error?) -> Void){
        let task = URLSession.shared.dataTask(with: ParseClient.Endpoints.getStudentsLocations.url) { (data, response, error) in
            guard let data = data else{
                completion([],error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let objectResponse = try decoder.decode(StudentLocations.self, from: data)
                completion([objectResponse],nil)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
    

}
