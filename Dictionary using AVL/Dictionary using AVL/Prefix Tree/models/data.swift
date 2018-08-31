//
//  data.swift
//  Prefix Tree
//
//  Created by Dai Long on 3/25/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

public func loaddata() -> [String:String] {
    let path = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Dictionary using AVL/anhviet109K.dict"
    var dic:[String: String] = [:]
    var text: [String] = []
    do {
        let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        text = contents.components(separatedBy: "@")
        text.removeFirst()
        
        
        for string in text {
            var key: String = ""
            for character in string {
                if character == "/" || character == "\n" {break}
                key += String(character)
            }
            dic[key] = string
        }
    }
    catch let error as NSError {
        print("OOP! can't open file dict\n\(error)")
    }
    return dic
}
