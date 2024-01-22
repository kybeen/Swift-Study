
//// [ 익스텐션을 통한 프로토콜의 실제 구현 ]
//
//protocol Receivable {
//    func received(data: Any, from: Sendable)
//}
//
//extension Receivable {
//    // 메시지를 수신합니다.
//    func received(data: Any, from: Sendable) {
//        print("\(self) received \(data) from \(from)")
//    }
//}
//
//// 무언가를 발신할 수 있는 기능
//protocol Sendable {
//    var from: Sendable { get }
//    var to: Receivable? { get }
//    
//    func send(data: Any)
//    
//    static func isSendableInstance(_ instance: Any) -> Bool
//}
//
//extension Sendable {
//    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
//    var from: Sendable {
//        return self
//    }
//    
//    // 메시지를 발신한다..
//    func send(data: Any) {
//        guard let receiver: Receivable = self.to else {
//            print("\(self) has no receiver")
//            return
//        }
//        
//        // 수신 가능한 인스턴스의 received 메서드를 호출
//        receiver.received(data: data, from: self.from)
//    }
//    
//    static func isSendableInstance(_ instance: Any) -> Bool {
//        if let sendableInstance: Sendable = instance as? Sendable {
//            return sendableInstance.to != nil
//        }
//        return false
//    }
//}
//
//// 수신, 발신이 가능한 Message 클래스
//class Message: Sendable, Receivable {
//    var to: Receivable?
//}
//
//// 수신, 발신이 가능한 Mail 클래스
//class Mail: Sendable, Receivable {
//    var to: Receivable?
//}
//
//// 두 Message 인스턴스를 생성
//let myPhoneMessage: Message = Message()
//let yourPhoneMessage: Message = Message()
//
//// 아직 수신받을 인스턴스가 없음
//myPhoneMessage.send(data: "Hello")  // Message has no receiver
//
//// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있다.
//myPhoneMessage.to = yourPhoneMessage
//myPhoneMessage.send(data: "Hello")  // Message received Hello from Message
//
//// Mail 인스턴스 2개 생성
//let myMail: Mail = Mail()
//let yourMail: Mail = Mail()
//
//myMail.send(data: "Hi")     // Mail has no receiver
//
//// Message와 Mail 모두 Sendable과 Receivable 프로토콜을 준수하므로
//// 서로 주고 받을 수 있다.
//myMail.to = yourMail
//myMail.send(data: "Hi")     // Mail received Hi from Mail
//
//myMail.to = myPhoneMessage
//myMail.send(data: "Bye")    // Message received Bye from Mail
//
//// String은 Sendable 프로토콜을 준수하지 않는다.
//Message.isSendableInstance("Hello")             // false
//
//// Message와 Mail은 Sendable 프로토콜을 준수한다.
//Message.isSendableInstance(myPhoneMessage)      // true
//Mail.isSendableInstance(myMail)                 // true
//
//// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태
//Message.isSendableInstance(yourPhoneMessage)    // false
//Mail.isSendableInstance(myPhoneMessage)         // true






//// [ 익스텐션을 통해 구현된 메서드 재정의 ]
//
//class Mail: Sendable, Receivable {
//    var to: Receivable?
//    
//    func send(data: Any) {
//        print("Mail의 send 메서드는 재정의되었습니다.")
//    }
//}
//
//let mailInstance: Mail = Mail()
//mailInstance.send(data: "Hello")    // Mail의 send 메서드는 재정의되었습니다.







//// [ 제네릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성 ]
//
//protocol SelfPrintable {
//    func printSelf()
//}
//
//extension SelfPrintable where Self: Container {
//    func printSelf() {
//        print(items)
//    }
//}
//
//protocol Container: SelfPrintable {
//    // 연관 타입을 활용하여 제네릭에 더욱 유연하게 대응할 수 있도록 정의
//    associatedtype ItemType
//    
//    var items: [ItemType] { get set }
//    var count: Int { get }
//    
//    mutating func append(item: ItemType)
//    subscript(i: Int) -> ItemType { get }
//}
//
//extension Container {
//    mutating func append(item: ItemType) {
//        items.append(item)
//    }
//    
//    var count: Int {
//        return items.count
//    }
//    
//    subscript(i: Int) -> ItemType {
//        return items[i]
//    }
//}
//
//protocol Popable: Container {
//    mutating func pop() -> ItemType?
//    mutating func push(_ item: ItemType)
//}
//
//extension Popable {
//    mutating func pop() -> ItemType? {
//        return items.removeLast()
//    }
//    
//    mutating func push(_ item: ItemType) {
//        self.append(item: item)
//    }
//}
//
//protocol Insertable: Container {
//    mutating func delete() -> ItemType?
//    mutating func insert(_ item: ItemType)
//}
//
//extension Insertable {
//    mutating func delete() -> ItemType? {
//        return items.removeFirst()
//    }
//    
//    mutating func insert(_ item: ItemType) {
//        self.append(item: item)
//    }
//}
//
//// 익스텐션을 통한 초기구현으로 프로토콜을 채택했기 때문에,
//// 구조체 내부에서 프로토콜 준수를 위한 추가 구현을 해줄 필요가 x
//struct Stack<Element>: Popable {
//    var items: [Element] = [Element]()
//}
//
//struct Queue<Element>: Insertable {
//    var items: [Element] = [Element]()
//}

//var myIntStack: Stack<Int> = Stack<Int>()
//var myStringStack: Stack<String> = Stack<String>()
//var myIntQueue: Queue<Int> = Queue<Int>()
//var myStringQueue: Queue<String> = Queue<String>()
//
//myIntStack.push(3)
//myIntStack.printSelf()  // [3]
//myIntStack.push(2)
//myIntStack.printSelf()  // [3, 2]
//myIntStack.pop()        // 2
//myIntStack.printSelf()  // [3]
//
//myStringStack.push("A")
//myStringStack.printSelf()  // ["A"]
//myStringStack.push("B")
//myStringStack.printSelf()  // ["A", "B"]
//myStringStack.pop()        // "B"
//myStringStack.printSelf()  // ["A"]
//
//myIntQueue.insert(3)
//myIntQueue.printSelf()  // [3]
//myIntQueue.insert(2)
//myIntQueue.printSelf()  // [3, 2]
//myIntQueue.delete()     // 3
//myIntQueue.printSelf()  // [2]
//
//myStringQueue.insert("A")
//myStringQueue.printSelf()  // ["A"]
//myStringQueue.insert("B")
//myStringQueue.printSelf()  // ["A", "B"]
//myStringQueue.delete()     // "A"
//myStringQueue.printSelf()  // ["B"]







//// [ Array 타입의 맵 사용 ]
//
//let items: Array<Int> = [1, 2, 3]
//
//let mappedItems: Array<Int> = items.map { (item: Int) -> Int in
//    return item * 10
//}
//
//print(mappedItems)



//// [ Stack 구조체의 맵 메서드 ]
//
//struct Stack<Element>: Popable {
//    var items: [Element] = [Element]()
//    
//    func map<T>(transform: (Element) -> T) -> Stack<T> {
//        var transformedStack: Stack<T> = Stack<T>()
//        
//        for item in items {
//            transformedStack.items.append(transform(item))
//        }
//        
//        return transformedStack
//    }
//}
//
//var myIntStack: Stack<Int> = Stack<Int>()
//myIntStack.push(1)
//myIntStack.push(5)
//myIntStack.push(2)
//myIntStack.printSelf()  // [1, 5, 2]
//var myStrStack: Stack<String> = myIntStack.map{ "\($0)" }
//myStrStack.printSelf()  // ["1", "5", "2"]









//// [ Array 타입의 필터 사용 ]
//
//let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
//    return item % 2 == 0
//}
//
//print(filteredItems)    // [2]




//// [ Stack 구조체의 필터 메서드 ]
//
//struct Stack<Element>: Popable {
//    var items: [Element] = [Element]()
//    
//    func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
//        var filteredStack: Stack<ItemType> = Stack<ItemType>()
//        
//        for item in items {
//            if includeElement(item) {
//                filteredStack.items.append(item)
//            }
//        }
//        
//        return filteredStack
//    }
//}
//
//let filteredStack: Stack<Int> = myIntStack.filter { (item: Int) -> Bool in
//    return item < 5
//}
//
//filteredStack.printSelf()   // [1, 2]









//// [ Array 타입의 리듀스 사용 ]
//
//let combinedItems: Int = items.reduce(0) { (result: Int, next: Int) -> Int in
//    return result + next
//}
//print(combinedItems)        // 6
//
//let combinedItemsDoubled: Double = items.reduce(0.0) { (result: Double, next: Int) -> Double in
//    return result + Double(next)
//}
//print(combinedItemsDoubled) // 6.0
//
//let combinedItemsString: String = items.reduce("") { (result: String, next: Int) -> String in
//    return result + "\(next) "
//}
//print(combinedItemsString)  // "1 2 3 "




//// [ Stack 구조체의 리듀스 메서드 ]
//
//struct Stack<Element>: Popable {
//    var items: [Element] = [Element]()
//
//    func reduce<T>(_ initialResult: T, nextPartialResult: (T, Element) -> T) -> T {
//        var result: T = initialResult
//        
//        for item in items {
//            result = nextPartialResult(result, item)
//        }
//        
//        return result
//    }
//}
//
//let combinedInt: Int = myIntStack.reduce(100) { (result: Int, next: Int) -> Int in
//    return result + next
//}
//print(combinedInt)      // 108
//
//let combinedDouble: Double = myIntStack.reduce(100.0) { (result: Double, next: Int) -> Double in
//    return result + Double(next)
//}
//print(combinedDouble)   // 108.0
//
//let combinedString: String = myIntStack.reduce("") { (result: String, next: Int) -> String in
//    return result + "\(next) "
//}
//print(combinedString)   // "1 5 2 "






// [ SelfPrintable 프로토콜의 초기구현과 기본 타입의 확장 ]

protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable { }
extension String: SelfPrintable { }
extension Double: SelfPrintable { }

1024.printSelf()    // 1024
3.14.printSelf()    // 3.14
"Hello".printSelf() // "Hello"
