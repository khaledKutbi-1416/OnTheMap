//
//  Login.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 23/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation
struct Login: Codable {
    let account: Account
    let session: Session
}

struct Account:Codable {
    let registered: Bool
    let key: String
}

struct Session: Codable {
    let id: String
    let expiration: String
}
