//
//  Dog.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 21/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation
import UIKit

class DogApi{
    enum Endpoint{
        case randomImgaeFromAllDogCollection
        case randomImageFromBreed(String)
        case listAllBreeds

        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue :String {
            switch self {
            case .randomImgaeFromAllDogCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageFromBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
     
    }
    
    class func requestListBreeds(completionHandler: @escaping([String],Error?) -> Void){
        let task = URLSession.shared.dataTask(with: DogApi.Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else{
                completionHandler([],error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds,nil)
        }
        task.resume()
    }
    class func requestRandomImage(breed:String,completionHandler: @escaping (DogImage?,Error?) -> Void){
           let randomImageEndpoint = DogApi.Endpoint.randomImageFromBreed(breed).url
           let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
                     guard let data = data else{ return completionHandler(nil,error)}
                     let decoder = JSONDecoder()
                     let imageData = try! decoder.decode(DogImage.self, from: data)
                         print(imageData)
                        completionHandler(imageData,nil)
       }
        task.resume()
    }
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?,Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, errror) in
                     guard let data = data else { return completionHandler(nil,errror )}
                        let downlodedImage = UIImage(data: data)
                        completionHandler(downlodedImage,nil)
                     }
                     task.resume()
    }
   
}
