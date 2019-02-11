import UIKit
import XCTest

class Node<T> {
    var value: T
    weak var previous: Node?
    var next: Node?
    
    init(value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var first: Node<T>? {
        return head
    }
    
    var last: Node<T>? {
        return tail
    }
    
    var isEmpty: Bool {
        return head == nil
    }
    
    
    func append(value: T) {
        let node = Node<T>(value: value)
        // IF
        if let lastNode = tail {
            node.previous = tail
            lastNode.next = node
        }
        // ELSE
        else {
            head = node
        }
        // ZAWSZE
        tail = node
    }
    
    var printable: String{
        guard !isEmpty else {
            return "List is empty"
        }
        
        var text = ""
        var node = head
        
        while node != nil {
            text += "\(node!.value)"
            node = node?.next
            
            if node != nil {
                text += ", "
            }
        }
        return text
    }
    
    func node(at index: Int) -> Node<T>? {
        guard index >= 0 else { return nil }
        var node = head
        var localIndex = index
        
        while node != nil {
            if localIndex == 0 {
                return node
            }
            
            localIndex -= 1
            node = node!.next
        }
        return nil
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    func remove(at index: Int) {
        guard let node = node(at: index) else { return }
        let previous = node.previous
        let next = node.next
        
        if let previous = previous {
            previous.next = next
        } else {
            head = next
        }
        
        next?.previous = previous
        
        if next == nil {
            tail = previous
        }
        
        node.previous = nil
        node.next = nil
    }
}

// UNIT TESTS
class LinkedListTests: XCTestCase {
    var list: LinkedList<String>!
    
    override func setUp() {
        super.setUp()
        list = LinkedList<String>()
        list.append(value: "Ford")
        list.append(value: "Tesla")
        list.append(value: "BMW")
    }
    
    func testNodeAt() {
        // Node at
        XCTAssertEqual(list.node(at: 1)?.value, "Tesla")
        XCTAssertNil(list.node(at: 6))
    }
    
    func testRemoveNodeAt() {
        list.remove(at: 0)
        XCTAssertEqual(list.node(at: 0)?.value, "Tesla")
    }
    
    func testRemoveAll() {
        list.removeAll()
        XCTAssertNil(list.node(at: 0))
    }
    
    override func tearDown() {
        list = nil
    }
}

// Run Unit tests
LinkedListTests.defaultTestSuite.run()
