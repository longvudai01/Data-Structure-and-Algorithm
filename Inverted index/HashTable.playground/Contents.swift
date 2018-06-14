//: Playground - noun: a place where people can play

import Foundation

var hashTable = HashTable<String, Array<Int>>(capacity: 105)

var allWords = [String]()
let path = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Bai6_thayHiep Inverted index/HashTable.playground/Resources/File.txt" //this is the file. we will write to and read from it

    do {
        // Get the contents
        let contents = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
        let lines : [String] = contents.components(separatedBy: "\n")
        for (numLine, line) in lines.enumerated() {
            let text: [String] = line.components(separatedBy: " ")
            for txt in text {
                if (hashTable[txt] == nil) {
                    hashTable[txt] = [numLine+1]
                }
                else {
                    hashTable[txt]?.append(numLine+1)
                }
            }
        }
    }
    catch let error as NSError {
        print("Ooops! Something went wrong: \(error)")
    }

hashTable["Lorem"]

