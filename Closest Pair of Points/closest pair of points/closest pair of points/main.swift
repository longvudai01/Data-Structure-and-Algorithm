//
//  main.swift
//  closest pair of points
//
//  Created by Dai Long on 2/13/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

//distancce
func distances (_ point1: points,_ point2: points) -> Double { return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y))}
//min
func mindist (_ first: Double, _ second: Double) -> Double {return first <= second ? first : second}
// find points < d in two section
func findvertical (_ listOfPointsHalf: Array<points>, _ vertical: Double, _ dmin: Double) -> Array<points> {
    var setofTwoHalves: [points] = []
    var i = 0
    for value in listOfPointsHalf {
        if (Double(abs(vertical - value.x)) <= dmin) {
            setofTwoHalves.append(listOfPointsHalf[i])
        }
        i += 1
    }
    return setofTwoHalves
}

//Rescursion of halve
func mininhalf (_ listOfPointsHalf: Array<points>,_ dmin: inout Array<Double>, _ hiendiem: inout Array<(p1: points,p2: points)>) -> (Double, (points, points)) {
    var listOfPointsHalf_copy: [points] = listOfPointsHalf
    
    if (listOfPointsHalf_copy.count == 2) {
        let last = distances(listOfPointsHalf[0], listOfPointsHalf[1])
        dmin.append(last)
        hiendiem.append((p1: listOfPointsHalf[0], p2: listOfPointsHalf[1]))
        }
    else {
        for i in 1..<listOfPointsHalf.count {
            dmin.append(distances(listOfPointsHalf[0], listOfPointsHalf[i]))
            hiendiem.append((p1: listOfPointsHalf[0], p2: listOfPointsHalf[i]))

        }
        listOfPointsHalf_copy.removeFirst()
        mininhalf(listOfPointsHalf_copy, &dmin, &hiendiem)
    }
    let tendiem = dmin.index(of: dmin.min()!)
    return (dmin.min()! ,(hiendiem[tendiem!]))
}


//main
listOfPoints.append(contentsOf: addPoints(howmany: 10))
var HienDiem:Array<(p1: points, p2: points)> = []
var HienDiemL:Array<(p1: points, p2: points)> = []
var HienDiemR:Array<(p1: points, p2: points)> = []
//call
var dminhalf1: [Double] = []
var dminhalf2: [Double] = []
var dmintempt: [Double] = []


if (listOfPoints.count < 2) {
    print("Error!")
    exit(0);
}
//if lower than 5 element => brute force
if (listOfPoints.count < 5) {
    //brute forces
    let N = listOfPoints.count - 1
    var i: Int
    for index in 0..<N {
         i = index + 1
        for point in i..<listOfPoints.count {
            dmintempt.append(distances(listOfPoints[point], listOfPoints[index]))
        }
    }
    print(dmintempt.min()!)
    exit(0)
}
//sort followed by ascending order
listOfPoints.sort {
    $0.x < $1.x
}
//divide points list
var half: Int = listOfPoints.count/2 - 1
var listOfPointsLeft:[points] = []
var listOfPointsRight: [points] = []

for index in 0...half {
    listOfPointsLeft.append(listOfPoints[index])
}
for index in half..<listOfPoints.count {
    listOfPointsRight.append(listOfPoints[index])
}
let minR = mininhalf(listOfPointsRight, &dminhalf1, &HienDiemR)
let minL = mininhalf(listOfPointsLeft, &dminhalf2, &HienDiemL)
var dmin2sec = mindist(minL.0, minR.0) //Find the min distance between 2 halve


var temp1 : [points] = findvertical(listOfPointsLeft, listOfPoints[half].x, dmin2sec)
var temp2 : [points] = findvertical(listOfPointsRight, listOfPoints[half].x, dmin2sec)
temp1.append(contentsOf: temp2[1..<temp2.count])
if (temp1.count < 2) {
    print(dmin2sec)
    if (dmin2sec == minR.0) {print(minR.1)}
    else {print(minL.1)}
}
else {
    var dmincenter = mininhalf(temp1, &dmintempt, &HienDiem)
    let result = mindist(dmin2sec, dmincenter.0)
    print(result)
    if (result == dmin2sec) {if (dmin2sec == minR.0) {print(minR.1)}
    else {print(minL.1)}}
    else {print(dmincenter.1)}}
