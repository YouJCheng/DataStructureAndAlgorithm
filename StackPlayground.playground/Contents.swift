//: Playground - noun: a place where people can play

import UIKit

/*
棧（Stack）
Data
    linked list: 持有的線性表

Operation
    init: 初始化
    count: 棧的元素个数
    isEmpty:是否為空
    push:入棧
    pop: 出棧
    top: 返回頂部元素
*/

public struct Stack<T> {

    //array
    fileprivate var stackArray = [T]()

    //count
    public var count: Int {
        return stackArray.count
    }

    //is empty ?
    public var isEmpty: Bool {
        return stackArray.isEmpty
    }

    //top element
    public var top: T? {

        if isEmpty {
            return nil
        } else {
            return stackArray.last
        }
    }

    //push operation
    public mutating func push(_ element: T) {
        stackArray.append(element)
    }


    //pop operation
    public mutating func pop() -> T? {

        if isEmpty {
            print("stack is empty")
            return nil
        } else {
            return stackArray.removeLast()
        }
    }

    //print all
    public mutating func printAllElements() {

        guard count > 0 else {
            print("stack is empty")
            return
        }

        print("\nprint all stack elemets:")
        for (index, value) in stackArray.enumerated() {
            print("index:[\(index)],value:\(value)")
        }
    }
}

var stack = Stack.init(stackArray: [])
stack.printAllElements() //stack is empty
stack.isEmpty //true
stack.push(2)
stack.printAllElements()
//[0]2
stack.isEmpty //false
stack.top     //2

stack.push(3)
stack.printAllElements()
//[0]2
//[1]3
stack.isEmpty //false
stack.top     //3


stack.pop()
stack.printAllElements()
//[0]2
stack.isEmpty //false
stack.top     //2

stack.pop()
stack.printAllElements() //stack is empty
stack.top //nil
stack.isEmpty //true
stack.pop() //stack is empty
