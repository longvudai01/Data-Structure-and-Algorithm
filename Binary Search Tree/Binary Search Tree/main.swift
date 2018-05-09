//
//  main.swift
//  Binary Search Tree
//
//  Created by Dai Long on 3/23/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

class Node<T: Comparable> {
    //MARK: properties
    var value: T
    var parent: Node?
    var leftNode: Node?
    var rightNode: Node?
    
    //file
    let path = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Binary Search Tree/tree.txt"
    
    //Initializer
    init(value: T) {
        self.value = value
        self.leftNode = nil
        self.rightNode = nil
    }
    
    //Convenience init
    public convenience init (array: [T]) {
        precondition(array.count > 1)
        self.init(value: array.first!)
        for value in array.dropFirst() {
            self.insert(value: value)
        }
    }
    
    //MARK: methods
    //insert
    public func insert(value: T) {
        if value < self.value {
            if let left = self.leftNode {
                left.insert(value: value)
            } else {
                self.leftNode = Node(value: value) //left above outside of scope
                self.leftNode?.parent = self
            }
        }
        else {
            if let right = self.rightNode {
                right.insert(value: value)
            } else {
                rightNode = Node(value: value)
                rightNode?.parent = self
            }
        }
    }
    
    //search
    
}
extension Node: CustomStringConvertible {
    
    
    public var description: String {
        var text = ""
        let current = String(describing: value)

        if let left = leftNode {
            let tem = current + " -- \(left.value);\n"
            text += tem
            text += "\(left.description)"
        }
        if let right = rightNode {
            let tem = current + " -- \(right.value);\n"
            text += tem
            text += "\(right.description)"
        }
        do {
            try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch let error as NSError {
            print("Oops! something went wrong: \(error)")
        }
        return text
    }
}

let tree = Node<Int>(array: [7, 2, 3, 4 , 5, 10, 9, 1, 55])
print(tree)
