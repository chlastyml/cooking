//
//  Helper.swift
//  Cooking
//
//  Created by kacalek on 13/09/2018.
//  Copyright © 2018 kacalek. All rights reserved.
//

import UIKit

class Helper: NSObject {
    public static func randomString(length: Int = 12) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
}
