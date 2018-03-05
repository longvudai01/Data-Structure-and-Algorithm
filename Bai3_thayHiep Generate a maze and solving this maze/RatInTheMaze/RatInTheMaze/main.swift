//
//  main.swift
//  RatInTheMaze
//
//  Created by Dai Long on 2/20/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation

var maze = Maze(width: 27, height: 27)

struct MazeLocation: Hashable {
    let row: Int
    let col: Int
    var hashValue: Int {
        return row.hashValue ^ col.hashValue
    }
    static func == (lhs: MazeLocation, rhs: MazeLocation) -> Bool {
        return lhs.row == rhs.row && lhs.col == rhs.col
    }
}

func markMaze(_ maze: Maze, path: [MazeLocation], start: MazeLocation,
              goal: MazeLocation) {
    for ml in path {
        maze.data[ml.row][ml.col] = .Path
    }
    maze.data[start.row][start.col] = .Start
    maze.data[goal.row][goal.col] = .Goal
}

func successorsForMaze(_ maze: Maze) -> (MazeLocation) -> [MazeLocation] {
    func successors(ml: MazeLocation) -> [MazeLocation] { //no diagonals
        var newMLs: [MazeLocation] = [MazeLocation]()
        if (ml.row + 1 < maze.data.count) && (maze.data[ml.row + 1][ml.col] != .Wall) {
            newMLs.append(MazeLocation(row: ml.row + 1, col: ml.col))
        }
        if (ml.row - 1 >= 0) && (maze.data[ml.row - 1][ml.col] != .Wall) {
            newMLs.append(MazeLocation(row: ml.row - 1, col: ml.col))
        }
        if (ml.col + 1 < maze.data.count) && (maze.data[ml.row][ml.col + 1] != .Wall) {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col + 1))
        }
        if (ml.col - 1 >= 0) && (maze.data[ml.row][ml.col - 1] != .Wall) {
            newMLs.append(MazeLocation(row: ml.row, col: ml.col - 1))
        }
        return newMLs
    }
    return successors
}

//queue
public class Queue<T> {
    private var container: [T] = [T]()
    public var isEmpty: Bool {
        return container.isEmpty
    }
    public func push(thing: T) {
        container.append(thing)
    }
    public func pop() -> T {
        return container.removeFirst()
    }
}

//Node
class Node<T>: Hashable {
    let state: T
    let parent: Node?
    let cost: Float
    init(state: T, parent: Node?, cost: Float = 0.0) {
        self.state = state
        self.parent = parent
        self.cost = cost
    }
    
    var hashValue: Int { return (Int)(cost) }
    static func == <T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs === rhs
    }
}

//BFS
func bfs<StateType: Hashable>(initialState: StateType, goalTestFn: (StateType)
    -> Bool, successorFn: (StateType) -> [StateType]) -> Node<StateType>? {
    
    // frontier is where we've yet to go
    let frontier: Queue<Node<StateType>> = Queue<Node<StateType>>()
    frontier.push(thing: Node(state: initialState, parent: nil))
    
    // explored is where we've been
    var explored: Set<StateType> = Set<StateType>()
    explored.insert(initialState)
    
    // keep going while there is more to explore
    while !frontier.isEmpty {
        let currentNode = frontier.pop()
        let currentState = currentNode.state
        
        // if we found the goal, we're done
        if goalTestFn(currentState) {
            return currentNode
        }
        
        // check where we can go next and haven't explored
        for child in successorFn(currentState) where !explored.contains(child) {
            explored.insert(child)
            frontier.push(thing: Node(state: child, parent: currentNode))
        }
    }
    return nil // never found the goal
}

func nodeToPath<StateType>(_ node: Node<StateType>) -> [StateType] {
    var path: [StateType] = [node.state]
    var currentNode = node.parent
    // work backwards from end to front
    while currentNode != nil {
        path.insert(currentNode!.state, at: 0)
        currentNode = currentNode!.parent
    }
    return path
}
let start = MazeLocation(row: 1, col: 2)
let goal = MazeLocation(row: maze.data.count - 2, col: maze.data.count - 3)

func goalTest(ml: MazeLocation) -> Bool {
    return ml == goal
}

let solution = bfs(initialState: start, goalTestFn: goalTest, successorFn: successorsForMaze(maze))
let path = nodeToPath(solution!)
markMaze(maze, path: path, start: start, goal: goal)
maze.show()
