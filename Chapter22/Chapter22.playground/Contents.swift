

//// [ 전위 연산자 구현과 사용 ]
//
//prefix operator **
//
//prefix func ** (value: Int) -> Int {
//    return value * value
//}
//
//let minusFive: Int = -5
//let sqrtMinusFive: Int = **minusFive
//print(sqrtMinusFive) // 25



//// [ 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용 ]
//
//prefix operator **
//
//prefix func ** <T: BinaryInteger> (value: T) -> T {
//    return value * value
//}
//
//let minusFive: Int = -5
//let five: UInt = 5
//
//let sqrtMinusFive: Int = **minusFive
//let sqrtFive: UInt = **five
//
//print(sqrtMinusFive)    // 25
//print(sqrtFive)         // 25




//// [ 제네릭을 사용하지 않은 swapTwoValues(_:_:) 함수 ]
//
//func swapTwoValues(_ a: inout Any, _ b: inout Any) {
//    let temporaryA: Any = a
//    a = b
//    b = temporaryA
//}
//
//var anyOne: Any = 1
//var anyTwo: Any = "Two"
//
//swapTwoValues(&anyOne, &anyTwo)
//print("\(anyOne), \(anyTwo)")   // "Two", 1
//
//var stringOne: String = "A"
//var stringTwo: String = "B"
//swapTwoValues(&stringOne, &stringTwo)   // 오류 - Any 외 다른 타입의 전달인자 전달 불가





//// [ 제네릭을 사용한 swapTwoValues(_:_:) 함수 ]
//
//func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
//    let temporaryA: T = a
//    a = b
//    b = temporaryA
//}
//
//var numberOne: Int = 5
//var numberTwo: Int = 10
//var stringOne: String = "A"
//var stringTwo: String = "B"
//var anyOne: Any = 1
//var anyTwo: Any = "Two"
//
//swapTwoValues(&numberOne, &numberTwo)
//print("\(numberOne), \(numberTwo)") // 10, 5
//
//swapTwoValues(&stringOne, &stringTwo)
//print("\(stringOne), \(stringTwo)") // B, A
//
//swapTwoValues(&anyOne, &anyTwo)
//print("\(anyOne), \(anyTwo)")       // Two, 1
//
//swapTwoValues(&numberOne, &stringOne) // 🚧 같은 타입끼리만 교환 가능하기 때문에 오류 발생




//// [ 제네릭을 사용한 Stack 구조체 타입 ]
//
//struct Stack<Element> {
//    var items = [Element]()
//    mutating func push(_ item: Element) {
//        items.append(item)
//    }
//    mutating func pop() -> Element {
//        return items.removeLast()
//    }
//}
//
// 인스턴스 생성 시 실제로 Element 대신 어떤 타입을 사용할지 명시해준다.
//var doubleStack: Stack<Double> = Stack<Double>()
//
//doubleStack.push(1.0)
//print(doubleStack.items)    // [1.0]
//doubleStack.push(2.0)
//print(doubleStack.items)    // [1.0, 2.0]
//doubleStack.pop()
//print(doubleStack.items)    // [1.0]
//
//var stringStack: Stack<String> = Stack<String>()
//
//stringStack.push("1")
//print(stringStack.items)    // ["1"]
//stringStack.push("2")
//print(stringStack.items)    // ["1", "2"]
//stringStack.pop()
//print(stringStack.items)    // ["1"]
//
//var anyStack: Stack<Any> = Stack<Any>()
//
//anyStack.push(1.0)
//print(anyStack.items)    // [1.0]
//anyStack.push("2")
//print(anyStack.items)    // [1.0, "2"]
//anyStack.pop()
//print(anyStack.items)    // [1.0]






// [ 익스텐션을 통한 제네릭 타입의 기능 추가 ]

//extension Stack {
//    // 기존 제네릭 타입 정의에 명시했던 타입 매개변수인 Element를 익스텐션에서 사용할 수 있다.
//    var topElement: Element? {
//        return self.items.last
//    }
//}

//print(doubleStack.topElement)   // Optional(1.0)
//print(stringStack.topElement)   // Optional("1")
//print(anyStack.topElement)      // Optional(1.0)






//// [ Dictionary 타입 정의 ]
//public struct Dictionary<Key : Hashable, Value> : Collection, ExpressibleByDictionaryLiteral { /* ... */ }




//// [ 제네릭 타입 제약 ]
//
//func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) {
//    // 함수 구현
//}
//
//struct Stack<Element: Hashable> {
//    // 구조체 구현
//}


//// [ 제네릭 타입 제약 추가 ]
//
//// T는 BinaryInteger 프로토콜과 FloatingPoint 프로토콜을 모두 준수하는 타입만 사용할 수 있다.
//func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) where T: FloatingPoint {
//    // 함수 구현
//}



//// [ makeDictionaryWithTwoValue 함수의 구현 ]
//
//func makeDictionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
//    let dictionary: Dictionary<Key, Value> = [key:value]
//    return dictionary
//}







// [ Container 프로토콜 정의 ]

// Container가 어떤 타입의 아이템을 저장해야 할 지에 대해서는 언급하지 않는다.
protocol Container {
    associatedtype ItemType
    var count: Int { get }
    mutating func append(_ item: ItemType)
    subscript(i: Int) -> ItemType { get }
}




//// [ MyContainer 클래스 정의 ]
//
//class MyContainer: Container {
//    var items: Array<Int> = Array<Int>()
//    
//    var count: Int {
//        return items.count
//    }
//    
//    // 연관 타입인 ItemType 대신 실제 타입인 Int로 구현해준다.
//    func append(_ item: Int) {
//        items.append(item)
//    }
//    
//    // 연관 타입인 ItemType 대신 실제 타입인 Int로 구현해준다.
//    subscript(i: Int) -> Int {
//        return items[i]
//    }
//}

//// [ MyContainer 클래스 정의 ]
//
//class MyContainer: Container {
//    // ItemType의 타입 별칭 지정
//    typealias ItemType = Int
//    
//    var items: Array<ItemType> = Array<ItemType>()
//    
//    var count: Int {
//        return items.count
//    }
//    
//    func append(_ item: ItemType) {
//        items.append(item)
//    }
//    
//    subscript(i: Int) -> ItemType {
//        return items[i]
//    }
//}






// [ Stack 구조체의 Container 프로토콜 준수 ]
struct Stack<Element>: Container {
    // 앞부분 예시코드에 나왔던 기존 Stack<Element> 구조체 구현
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Container 프로토콜 준수를 위한 구현
    // => Container 프로토콜의 연관 타입인 ItemType 대신 Stack 구조체의 타입 매개변수인 Element 사용
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}






// [ Stack 구조체의 제네릭 서브스크립트 구현과 사용 ]

extension Stack {
    // Indices라는 플레이스홀더를 사용하여 매개변수를 제네릭하게 받아들인다.
    // Indices는 Sequence 프로토콜을 준수하는 타입으로 제약이 추가되어 있다.
    // Indices타입 Iterator의 Element 타입이 Int 타입이어야 하는 제약도 추가되어 있다.
    subscript<Indices: Sequence>(indices: Indices) -> [Element] where Indices.Iterator.Element == Int {
        var result = [ItemType]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

var integerStack: Stack<Int> = Stack<Int>()
integerStack.append(1)
integerStack.append(2)
integerStack.append(3)
integerStack.append(4)
integerStack.append(5)

print(integerStack[0...2])  // [1, 2, 3]
