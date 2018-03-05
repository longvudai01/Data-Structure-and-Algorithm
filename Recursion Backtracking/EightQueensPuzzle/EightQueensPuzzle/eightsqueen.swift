//
//  main.swift
//  EightQueensPuzzle
//
//  Created by Dai Long on 2/7/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation
import Darwin

//CREATE Chess Board 2D
func createchessBoard<T>(_ count: Int, _ value: T) -> [T] {
    return [T](repeating: value, count: count)
}

//placeQueen-unsafe
func placeQueen (_ unsafeState: inout Array<(x: Int, y: Int, sub: Int, sum: Int)>, _ xCoordinate: Int, _ yCoordinate: Int){
    if (xCoordinate == -20) {
        unsafeState.removeLast()
    }
    else {
        unsafeState.append((xCoordinate, yCoordinate, yCoordinate - xCoordinate, yCoordinate + xCoordinate))
    }
}

//check state of chess Piece
func checkState (_ unsafeState: inout Array<(x: Int, y: Int, sub: Int, sum: Int)>, _ xCoordinate: Int, _ yCoordinate: Int) -> Bool {
    let c = yCoordinate - xCoordinate
    let d = yCoordinate + xCoordinate
    var bool = 0
    if unsafeState.isEmpty {
        bool = 1
    }
    else {
    for (x,y,sub,sum) in unsafeState {
        if (xCoordinate == x || yCoordinate == y || c == sub || d == sum) {
            bool = 0
            break
        }
        else {
            bool = 1
        }
    }
    }
    if (bool == 0) {
        return false
    }
    else {return true}
}

//show result
func showresult (_ unsafeState: inout Array<(x: Int, y: Int, sub: Int, sum: Int)>) {
    for (x,y,_,_) in unsafeState {
        print("cot \(x+1), hang \(y+1)")
    }
//    print("\n")
    exit(0) //thoat
}

// Solving
func Try (_ chessBoard: Array<Array<Int>>,_ unsafeState: inout Array<(x: Int, y: Int, sub: Int, sum: Int)>, _ column: Int) {
    for row in 0...7 {
        if (checkState(&unsafeState, column, row) == true) { //kiem tra trang thai. neu an toan thi tiep tuc
            placeQueen(&unsafeState, column, row)
            if (column == 7) {
                showresult(&unsafeState)
            }
            else {Try(chessBoard,&unsafeState, column + 1)}
        
        placeQueen(&unsafeState, -20, -20) //xoa Queen tai vi tri [row][column] de tiep tuc voi [row + 1][column]
        }
    }
}

//main
var chessBoard = createchessBoard(8, createchessBoard(8, 20)) //create 8x8 maps
var unsafeState : Array<(x: Int, y: Int, sub: Int, sum: Int)>
unsafeState = []
Try(chessBoard, &unsafeState, 0)
