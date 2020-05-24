//
//  User.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 17/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation


struct StudentsLocationsResponse: Codable {

    let results: [StudentsInformation]
}

struct StudentsInformation: Codable {

    let firstName: String
    let lastName: String
    let longitude: Double
    let latitude: Double
    let mapString: String
    let mediaURL: String
    let uniqueKey: String
    let objectId: String
    let createdAt: String
    let updatedAt: String
  
}
