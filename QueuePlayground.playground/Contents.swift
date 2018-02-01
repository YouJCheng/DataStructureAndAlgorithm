//: Playground - noun: a place where people can play

import UIKit

/*
隊列（Queue） 先進先出
Data
    linked list: 持有的線性表

Operation
    init: 初始化
    count: 元素個数
    isEmpty: 是否為空
    front: 獲取最前元素
    enqueue: 插入到隊尾
    dequeue: 刪除頭元素並返回
 */

struct Queue<T> {

    fileprivate var queueArray = [T]()

    fileprivate var count:Int {
        return queueArray.count
    }

    fileprivate var isEmpty: Bool {
        return queueArray.isEmpty
    }

    public var front: T? {
        if !isEmpty {
            return queueArray.first
        } else {
            return nil
        }
    }

    public mutating func enqueue(_ element:T) {

        queueArray.append(element)

    }

    public mutating func dequeue() -> T? {

        if isEmpty {
            print("Queue is empty")
            return nil
        } else {
            return queueArray.removeFirst()
        }

    }

    //print all
    public mutating func printAllElements() {

        guard count > 0 else {
            print("queue is empty")
            return
        }

        print("\nprint all queue elemets:")
        for (index, value) in queueArray.enumerated() {
            print("[\(index)]\(value)")
        }
    }

}
var queue = Queue.init(queueArray: [])
queue.printAllElements()//queue is empty
queue.isEmpty //true
queue.count   //0


queue.enqueue(2)
queue.printAllElements()
queue.isEmpty  //false
//[0]2

queue.enqueue(3)
queue.printAllElements()
//[0]2
//[1]3


queue.enqueue(4)
queue.printAllElements()
//[0]2
//[1]3
//[2]4
queue.front //2


queue.dequeue()
queue.printAllElements()
//[0]3
//[1]4
queue.front //3


queue.dequeue()
queue.printAllElements()
//[0]4
queue.front //4

queue.dequeue()
queue.printAllElements() //queue is empty
queue.front //return nil, and print : queue is empty
queue.isEmpty //true
queue.count//0

