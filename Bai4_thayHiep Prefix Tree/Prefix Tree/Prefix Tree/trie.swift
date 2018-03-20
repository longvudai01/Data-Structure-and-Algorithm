//
//  main.swift
//  Trie
//
//  Created by Dai Long on 3/14/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

class TrieNode<T:Hashable> {
    var data: T?
    var children: [T: TrieNode] = [:]
    var isTerminal = false
    
    init(data: T? = nil) {
        self.data = data
    }
    //method
    
    func add(data: T) {
        guard (children[data] == nil) else {return}
        children[data] = TrieNode(data: data)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    var root = Node()

    var allWords = [String]()
     let path = "/Users/dailong/Desktop/Data Structure and Algorithm/Prefix Tree/Prefix Tree/dic.txt" //this is the file. we will write to and read from it
    init() {
        do {
            // Get the contents
            let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
            let lines : [String] = contents.components(separatedBy: "\n")
            for string in lines {
                self.insert(word: string)
            }
        }
        catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func insert(word: String) {
        guard (!word.isEmpty) else {return} //word rong thi thoat
        var currentNode = root
        for character in word.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            }
            else {
                currentNode.add(data: character)
                currentNode = currentNode.children[character]!
            }
        }
        currentNode.isTerminal = true //Diem cuoi
    }
}

extension Trie {
    //tim diem cuoi cua chuoi
    func findLastNode(word: String) -> Node? {
        var lastNode = root
        for character in word {
            if let currentNode = lastNode.children[character] {
                 lastNode = currentNode
            }
            else {return nil}
        }
        return lastNode
    }
    //Tim WordsInSubtrie
    func wordsInSubtrie(rootNode: Node, partialWords: String) -> [String] {
        var subWords = [String]()
        var previousLetter = partialWords
        if let data = rootNode.data {
            previousLetter.append(data)
        }
        if rootNode.isTerminal == true {
            subWords.append(previousLetter)
        }
        
        for child in rootNode.children.values {
            let childWord = wordsInSubtrie(rootNode: child, partialWords: previousLetter)
            subWords += childWord
        }
        return subWords
    }
    
    
    func search(word: String) -> [String] {
        guard (!word.isEmpty) else {return allWords}
        
        let prefixword = word.lowercased()
        //neu tu da cho la duy nhat
        if let lastNode = findLastNode(word: prefixword) {
            if lastNode.isTerminal == true {
                allWords.append(prefixword)
            }
            for childNode in lastNode.children.values {
                let childWords = wordsInSubtrie(rootNode: childNode, partialWords: prefixword)
                allWords += childWords
            }
        }
        return allWords
    }
}

