//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

/* 節點(node)

 Data
    value:持有的数据

Operation 操作
    init: 初始化
    previous: 指向上一節點的指針
    next: 指向下一節點的指針
*/

public class LinkedListNode<T> {

    //value of a node
    var value: T

    //pointer to previous node 指針指向前一個節點
    weak var previous: LinkedListNode?

    //pointer to next node 指針指向後一個節點
    var next: LinkedListNode?

    //init
    public init(value: T) {
        self.value = value
    }
}
/* 链表（linked list）

Data
    linked list: 持有的線性表

Operation
    init: 初始化
    count: 持有節點總個數
    isEmpty: 是否為空
    first: 頭節點
    last: 尾節點
    node: 傳入index導出節點
    insert: 插入node到指定節點
    insertToHead: 插入節點到表頭
    appendToTail: 插入節點到表尾
    removeAll: 移除所有節點
    remove: 移除傳入的節點
    removeAt: 移除傳入index的節點
*/
public class LinkedList<T> {

    // typealias 重新命名LinkedListNode<T> 讓Code 容易閱讀
    public typealias Node = LinkedListNode<T>

    private var head: Node?

    public var isEmpty: Bool {
        return head == nil
    }

    public var first: Node? {
        return head
    }

    public var last: Node? {

        // 先判斷 head 是否為nil， 若有返回nil。
        guard var node = head else {
            return nil
        }

        // until node.next is nil
        /*
         while 控制語句來判斷node.next節點是否存在：
         如果存在，則繼續+1或者繼續往下尋找，直到node.next為nil時才停止。
         鍊錶的尋址方式：通過頭結點開始，以節點的.next指針來尋找下一個節點。
         鍊錶的尾節點，它的.next指針不指向任何對象，因為它本來就是鍊錶的最後一項。
         */

        while let next = node.next {
            node = next
        }
        return node
    }

    /// total count of nodes
    public var count: Int {

        guard var node = head else {
            return 0
        }

        var count = 1
        /*
         while 控制語句來判斷node.next節點是否存在：
        如果存在，則繼續+1或者繼續往下尋找，直到node.next為nil時才停止。
        鍊錶的尋址方式：通過頭結點開始，以節點的.next指針來尋找下一個節點。
        鍊錶的尾節點，它的.next指針不指向任何對象，因為它本來就是鍊錶的最後一項。
         */

        while let next = node.next {
            node = next
            count += 1
        }
        return count

    }

    //get node of index
    public func node(atIndex index: Int) -> Node? {

        if index == 0 {
            //head node
            return head!
        } else {

            var node = head!.next

            guard index < count else {
                return nil;
            }

            for _ in 1..<index {
                // go on finding by .next
                node = node?.next
                if node == nil {
                    break
                }
            }

            return node!
        }
    }

    /// insert node to last index
    public func appendToTail(value: T) {

        let newNode = Node(value: value)

        if let lastNode = last {

            // update last node: newNode becomes new last node;
            // the previous last node becomes the second-last node
            newNode.previous = lastNode
            lastNode.next = newNode

        } else {
            // blank linked list
            head = newNode
        }
    }

    //insert node to index 0
    public func insertToHead(value: T) {

        let newHead = Node(value: value)

        if head == nil {

            // blank linked list
            head = newHead

        }else {

            newHead.next = head
            head?.previous = newHead
            head = newHead

        }
    }

    //insert node in specific index
    public func insert(_ node: Node, atIndex index: Int) {

        if index < 0 {

            print("invalid input index")
            return
        }

        let newNode = node

        if count == 0 {

            head = newNode

        } else {

            if index == 0 {

                newNode.next = head
                head?.previous = newNode
                head = newNode

            } else {

                if index > count {

                    print("out of range")
                    return

                }

                let prev = self.node(atIndex: index-1)
                let next = prev?.next

                newNode.previous = prev
                newNode.next = prev?.next
                prev?.next = newNode
                next?.previous = newNode
            }

        }
    }

    //removing all nodes
    public func removeAll() {
        head = nil
    }

    //remove the last node
    public func removeLast() -> T? {

        guard !isEmpty else {
            return nil
        }

        return remove(node: last!)
    }

    //remove a node by it's refrence
    public func remove(node: Node) -> T? {

        guard head != nil else {
            print("linked list is empty")
            return nil
        }

        let prev = node.previous
        let next = node.next

        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }

        next?.previous = prev

        node.previous = nil
        node.next = nil
        return node.value
    }


    //remove a node by it's index
    public func removeAt(_ index: Int) -> T? {

        guard head != nil else {
            print("linked list is empty")
            return nil
        }

        let node = self.node(atIndex: index)
        guard node == nil else {
            return nil
        }
        return remove(node: node!)
    }


    public func printAllNodes(){

        guard head != nil else {
            print("linked list is empty")
            return
        }

        var node = head

        print("\nstart printing all nodes:")

        for index in 0..<count {

            if node == nil {
                break
            }

            print("[\(index)]\(node!.value)")
            node = node!.next

        }
    }


}

let list = LinkedList<String>()
list.isEmpty   // true
list.first     // nil
list.count     // 0

list.appendToTail(value: "Swift")
list.isEmpty         // false
list.first!.value    // "Swift"
list.last!.value     // "Swift"
list.count           //1

list.appendToTail(value:"is")
list.first!.value    // "Swift"
list.last!.value     // "is"
list.count           // 2

list.appendToTail(value:"great")
list.first!.value    // "Swift"
list.last!.value     // "great"
list.count           // 3


list.printAllNodes()
//[0]Swift
//[1]is
//[2]Great

list.node(atIndex: 0)?.value // Swift
list.node(atIndex: 1)?.value // is
list.node(atIndex: 2)?.value // great
list.node(atIndex: 3)?.value // nil


list.insert(LinkedListNode.init(value: "language"), atIndex: 1)
list.printAllNodes()
//[0]Swift
//[1]language
//[2]is
//[3]great


list.remove(node: list.first!)
list.printAllNodes()
//[0]language
//[1]is
//[2]great


list.removeAt(1)
list.printAllNodes()
//[0]language
//[1]great

list.removeLast()
list.printAllNodes()
//[0]language

list.insertToHead(value: "study")
list.count             // 2
list.printAllNodes()
//[0]study
//[1]language


list.removeAll()
list.printAllNodes()//linked list is empty

list.insert(LinkedListNode.init(value: "new"), atIndex: 3)
list.printAllNodes()
//[0]new

list.insert(LinkedListNode.init(value: "new"), atIndex: 3) //out of range
list.printAllNodes()
//[0]new

list.insert(LinkedListNode.init(value: "new"), atIndex: 1)
list.printAllNodes()
//[0]new
//[1]new

