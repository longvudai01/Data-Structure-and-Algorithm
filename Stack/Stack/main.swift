//
//  main.swift
//  Stack
//
//  Created by Dai Long on 3/1/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

import Foundation
public struct StackList<T> {
    fileprivate var head: Node<T>? = nil
    private var _count: Int = 0
    init() {}
    
    public mutating func push(item: T) {
        let node: Node<T> = Node(data: item)
        node.next = head
        head = node
        _count += 1
    }
    public mutating func pop() -> T? {
        if isEmpty() {
            print("Can't get element. Stack is nil!!")
            return nil
        }
        
        let topNode: Node<T> = head!
        head = head?.next
        _count -= 1
        return topNode.data
    }
    public func peek() -> T? {
        if isEmpty() {
            return nil
        }
        return head!.data
    }
    public func isEmpty() -> Bool {
        return _count == 0 ? true : false
    }
    public func count() -> Int {
        return _count
    }
}

private class Node<T> {
    fileprivate var data: T
    fileprivate var next: Node<T>?
    init(data: T) {
        next = nil
        self.data = data
    }
}
//Driver
//2,2,3,4,5,6,7,7

var stack: StackList<Int> = StackList<Int>()
//stack.push(item: 2)
//stack.push(item: 2)
//stack.push(item: 32)

print(stack.isEmpty())
