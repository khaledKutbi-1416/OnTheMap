//
//  LoginRequest.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 23/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation

struct LoginRequest: Codable{
    
    let username: String
    let password: String
    let loginObject: [String: [String: String]]
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.loginObject = ["udacity": ["username":"\(username)","password": "\(password)"]]
    }
}
