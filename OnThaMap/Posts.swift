//
//  Posts.swift
//  OnThaMap
//
//  Created by Khaled Kutbi on 25/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.
//

import Foundation
class Posts {
    
    var studentsInformation: [StudentsInformation]?
    private static var privateShared : Posts?
    
    class func shared() -> Posts { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = Posts()
            return privateShared!
        }
        return uwShared
    }
    class func destroy() {
        privateShared = nil
    }
    private init() {
        
    }
    
    deinit {
        
    }
    
}
