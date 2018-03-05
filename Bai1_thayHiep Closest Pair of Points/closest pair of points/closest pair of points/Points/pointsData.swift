//
//  pointsData.swift
//  closest pair of points
//
//  Created by Dai Long on 2/13/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

// Point P[] = {{2, 3}, {12, 30}, {40, 50}, {5, 1}, {12, 10}, {3, 4}}; => min sqrt 2

func randomPoint (_ x: inout Double,_ y: inout Double) {
    srand48(time(nil))
    x = Double(arc4random_uniform(101))
    y = Double(arc4random_uniform(101))
}
func addPoints (howmany element: Int) -> [points] {
    var list: [points] = []
    var x = Double()
    var y = Double()
    for _ in 0..<element {
        randomPoint(&x,&y)
        list.append(points(x: x, y: y))
    }
    return list
}
var listOfPoints: [points] = []

