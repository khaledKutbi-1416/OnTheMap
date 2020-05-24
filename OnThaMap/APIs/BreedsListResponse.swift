//
//  BreedsListResponse.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 22/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation

struct BreedsListResponse: Codable{
    
    let status: String
    let message: [String:[String]]
    
}
