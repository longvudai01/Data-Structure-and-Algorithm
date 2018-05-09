//
//  main.swift
//  Bai 9
//
//  Created by Dai Long on 4/21/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

func getRandomNumbers(maxNumber: Int, listSize: Int)-> [Int] {
    var randomNumbers = Array<Int>()
    while randomNumbers.count < listSize {
        let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
        randomNumbers.append(randomNumber)
    }
    return randomNumbers
}

//let Sets = [59, 29, 71, 41, 100, 56, 99, 20, 95, 65]
//let Sets = [29, 34, 77, 2, 0, 96, 60, 91, 19, 16]
var Sets = [73, 32, 47, 44, 64, 97, 49, 13, 25, 6]
Sets = Sets.sorted() {$0 > $1}
print("Tap mau: \(Sets)")
let N = Sets.count - 1;
var sumOfSets = Sets.reduce(0, +)
print("Tong Tap mau la: \(sumOfSets)")

var T = Int()
var set1: [Int] = []

@discardableResult func recursion(n: Int, sum: Int)-> Bool {
    var flag: Bool = true
    var s = Int()
    if (n < N){
        s = n + 1
    }
    else {
        return false
    }
    
    if (sum == T) {
        flag = true
        set1.append(Sets[0])
    }
    else if (sum < T) {
        for i in s...N {
            let check = recursion(n: i, sum: sum + Sets[i])
            if (check) {
             //   print(Sets[i])
                set1.append(Sets[i])
                flag = true
                break;}
            if (i == N) {
                flag = false
            }
        }
    }
    else if (sum > T) {flag = false}
    return flag
}

//Main
if (sumOfSets%2 == 0) {
    print("Co the tach!\n")
    T = sumOfSets / 2
    recursion(n: 0, sum: Sets[0])
    print("Tap con 1: \(set1)")
    let sumOfSet1 = set1.reduce(0, +)
    print("tong cua tap con 1: \(sumOfSet1)")
}
else {print("Khong the tach")}

