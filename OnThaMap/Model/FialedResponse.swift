//
//  FialedResponse.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 23/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation

struct FailedResponse: Codable {
    let statusCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case errorMessage = "error"
    }
}

extension FailedResponse: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
}
