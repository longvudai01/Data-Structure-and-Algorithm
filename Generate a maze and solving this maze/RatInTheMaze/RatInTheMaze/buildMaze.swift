//
//  buildMaze.swift
//  RatInTheMaze
//  Generate maze with recursive backtracking algorithm
//  Created by Dai Long on 3/2/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation
class Maze {
    
    enum Cell {
        case Space
        case Wall
        case Start
        case Path
        case Goal
    }
    
    var data: [[Cell]] = []
    
    // Generate a random maze.
    init(width: Int, height: Int) {
        for _ in 0 ..< height {
            data.append([Cell](repeating: Cell.Wall, count: width)) //full wall
        }
        for i in 0 ..< width { //left and right
            data[0][i] = Cell.Space
            data[height - 1][i] = Cell.Space
        }
        for i in 0 ..< height { //top and bottom
            data[i][0] = Cell.Space
            data[i][width - 1] = Cell.Space
        }
        data[2][2] = Cell.Space //diem bat dau
        self.carve(x: 2, y: 2)
        data[0][2] = Cell.Wall
        data[1][2] = Cell.Space //start
        data[height - 2][width - 3] = Cell.Space // goal
        data[height - 1][width - 3] = Cell.Wall
    }
    
    // Carve starting at x, y.
    func carve(x: Int, y: Int) {
        let upx = [1, -1, 0, 0]
        let upy = [0, 0, 1, -1]
        var dir = Int(arc4random_uniform(4))
        var count = 0
        while count < 4 {
            let x1 = x + upx[dir]
            let y1 = y + upy[dir]
            let x2 = x1 + upx[dir]
            let y2 = y1 + upy[dir]
            if data[y1][x1] == Cell.Wall && data[y2][x2] == Cell.Wall { //neu phia truoc 2 o la tuong thi carve
                data[y1][x1] = Cell.Space
                data[y2][x2] = Cell.Space
                carve(x: x2, y: y2) //recursion
            } else { //neu khong thi thu cac huong con lai
                dir = (dir + 1) % 4
                count += 1
            }
        }
    }
    
    // Show the maze.
    func show() {
        for row in data {
            for cell in row {
                if cell == Cell.Space {
                    print("  ", separator: "", terminator: "")
                } else if cell == Cell.Wall {
                    print("[]", separator: "", terminator: "")
                } else if cell == Cell.Path {
                    print(" *", separator: "", terminator: "")
                } else if cell == Cell.Start {
                    print(" S", separator: "", terminator: "")
                } else {
                    print(" G", separator: "", terminator: "")
                }
            }
            print("")
        }
    }
    
}

