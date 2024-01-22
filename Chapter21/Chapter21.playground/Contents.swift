

//// [ 익스텐션을 통한 연산 프로퍼티 추가 ]
//
//extension Int {
//    var isEven: Bool {
//        return self % 2 == 0
//    }
//    
//    var isOdd: Bool {
//        return self % 2 == 1
//    }
//}
//
//print(1.isEven) // false
//print(2.isEven) // true
//print(1.isOdd)  // true
//print(2.isOdd)  // false



//// [ 익스텐션을 통한 메서드 추가 ]
//
//extension Int {
//    // 인스턴스 메서드 추가
//    func multiply(by n: Int) -> Int {
//        return self * n
//    }
//    
//    // 가변 메서드 추가
//    mutating func multiplySelf(by n: Int) {
//        self = self.multiply(by: n)
//    }
//    
//    // 타입 메서드 추가
//    static func isIntTypeInstance(_ instance: Any) -> Bool {
//        return instance is Int
//    }
//}
//
//print(3.multiply(by: 2))    // 6
//print(4.multiply(by: 5))    // 20
//
//var number: Int = 3
//number.multiplySelf(by: 2)
//print(number)   // 6
//
//Int.isIntTypeInstance(number)   // true
//Int.isIntTypeInstance(3)        // true
//Int.isIntTypeInstance(3.0)      // false
//Int.isIntTypeInstance("3")      // false
//
//prefix operator ++
//
//struct Position {
//    var x: Int
//    var y: Int
//}
//
//extension Position {
//    // + 중위 연산 구현
//    static func + (left: Position, right: Position) -> Position {
//        return Position(x: left.x + right.x, y: left.y + right.y)
//    }
//    
//    // - 전위 연산 구현
//    static prefix func - (vector: Position) -> Position {
//        return Position(x: -vector.x, y: -vector.y)
//    }
//    
//    // += 복합할당 연산자 구현
//    static func += (left: inout Position, right: Position) {
//        left = left + right
//    }
//}
//
//extension Position {
//    // == 비교 연산자 구현
//    static func == (left: Position, right: Position) -> Bool {
//        return (left.x == right.x) && (left.y == right.y)
//    }
//    
//    // != 비교 연산자 구현
//    static func != (left: Position, right: Position) -> Bool {
//        return !(left == right)
//    }
//}
//
//extension Position {
//    // ++ 사용자 정의 연산자 구현
//    static prefix func ++ (position: inout Position) -> Position {
//        position.x += 1
//        position.y += 1
//        return position
//    }
//}
//
//var myPosition: Position = Position(x: 10, y: 10)
//var yourPosition: Position = Position(x: -5, y: -5)
//
//print(myPosition + yourPosition)    // Position(x: 5, y: 5)
//print(-myPosition)                  // Position(x: -10, y: -10)
//
//myPosition += yourPosition
//print(myPosition)                   // Position(x: 5, y: 5)
//
//print(myPosition == yourPosition)   // false
//print(myPosition != yourPosition)   // true
//
//print(++myPosition)                 // Position(x: 6, y: 6)





//// [ 익스텐션을 통한 이니셜라이저 추가 ]
//
//extension String {
//    init(intTypeNumber: Int) {
//        self = "\(intTypeNumber)"
//    }
//    
//    init(doubleTypeNumber: Double) {
//        self = "\(doubleTypeNumber)"
//    }
//}
//
//let stringFromInt: String = String(intTypeNumber: 100)          // "100"
//let stringFromDouble: String = String(doubleTypeNumber: 100.0)  // "100.0"
//
//class Person {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//extension Person {
//    convenience init() {
//        self.init(name: "Unknown")
//    }
//}
//
//let someOne: Person = Person()
//print(someOne.name) // "Unknown"





//// [ 익스텐션을 통한 초기화 위임 이니셜라이저 추가 ]
//
//struct Size {
//    var width: Double = 0.0
//    var height: Double = 0.0
//}
//
//struct Point {
//    var x: Double = 0.0
//    var y: Double = 0.0
//}
//
//struct Rect {
//    var origin: Point = Point()
//    var size: Size = Size()
//}
//
//let defaultRect: Rect = Rect()
//// 아직 Rect에 대해 정의한 사용자 정의 이니셜라이저가 없음
//// => Rect의 이니셜라이저와 멤버와이즈 이니셜라이저가 기본으로 제공됨
//let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0),
//                                size: Size(width: 5.0, height: 5.0))
//
//extension Rect {
//    // 사용자 정의 이니셜라이저를 익스텐션으로 추가했기 때문에 여전히 Rect의 기본 멤버와이즈 이니셜라이저를 호출할 수 있음
//    init(center: Point, size: Size) {
//        let originX: Double = center.x - (size.width / 2)
//        let originY: Double = center.y - (size.height / 2)
//        self.init(origin: Point(x: originX, y: originY), size: size)
//    }
//}
//
//let centerRect: Rect = Rect(center: Point(x: 4.0, y: 4.0),
//                            size: Size(width: 3.0, height: 3.0))





//// [ 익스텐션을 통한 서브스크립트 추가 ]
//
//extension String {
//    subscript(appedValue: String) -> String {
//        return self + appedValue
//    }
//    
//    subscript(repeatCount: UInt) -> String {
//        var str: String = ""
//        
//        for _ in 0..<repeatCount {
//            str += self
//        }
//        
//        return str
//    }
//}
//
//print("abc"["def"]) // "abcdef"
//print("abc"[3])     // "abcabcabc"




// [ 익스텐션을 통한 중첩 데이터 타입 추가 ]

extension Int {
    enum Kind {
        case negative, zero, positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

print(1.kind)       // positive
print(0.kind)       // zero
print((-1).kind)    // negative

func printIntegerKinds(numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}
printIntegerKinds(numbers: [3, 19, -27, 0, -6, 0, 7])
// + + - 0 - 0 + 
