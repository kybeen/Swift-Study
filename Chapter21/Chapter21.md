# **Chapter 21. 익스텐션**

## 익스텐션이란
- `익스텐션(Extension)`을 활용해서 구조체, 클래스, 열거형, 프로토콜 타입에 `새로운 기능을 추가`할 수 있다.

### 💡 스위프트의 익스텐션으로 타입에 추가할 수 있는 기능
- 연산 타입 프로퍼티 / 연산 인스턴스 프로퍼티
- 타입 메서드 / 인스턴스 메서드
- 이니셜라이저
- 서브스크립트
- 중첩 타입
- 특정 프로토콜을 준수할 수 있도록 기능 추가

> 익스텐션은 `타입에 새로운 기능을 추가`하는 것이기 때문에 `기존에 존재하는 기능을 재정의할 수는 없다.`

### 📌 상속과 익스텐션의 비교
|  | 상속 | 익스텐션 |
| :--- | :--- | :--- |
| 확장 | `수직` 확장 | `수평` 확장 |
| 사용 | `클래스` 타입에서만 사용 | 클래스, 구조체, 프로토콜, 제네릭 등 `모든 타입`에서 사용 |
| 재정의 | `재정의(override) 가능` | `재정의(override) 불가` |

- 외부 라이브러리나 프레임워크를 가져다 사용할 경우에는 원본 소스를 수정하지 못한다. 그렇기 때문에 `외부에서 가져온 타입에 원하는 기능을 추가하고자 할 때` 익스텐션을 사용한다.
---

## 익스텐션 문법
- `extension` 키워드 사용
  ``` Swift
  extension 확장할 타입 이름 {
    // 타입에 추가될 새로운 기능 구현
  }
  ```

- 기존에 존재하는 타입이 `추가로 다른 프로토콜을 채택`할 수 있도록 확장하는 방법
  ``` Swift
  extension 확장할 타입 이름: 프로토콜1, 프로토콜2, 프로토콜3 {
    // 프로토콜 요구사항 구현
  }
  ```
---

## 익스텐션으로 추가할 수 있는 기능
### 📌 `연산 프로퍼티`
- 인스턴스 연산 프로퍼티 뿐만 아니라 `static` 키워드를 사용하여 타입 연산 프로퍼티도 추가할 수 있다.
  - 익스텐션으로 연산 프로퍼티는 추가할 수 있지만, `저장 프로퍼티`는 추가할 수 없다.
  - 타입에 정의되어 있는 기존의 프로퍼티에 프로퍼티 감시자를 추가할 수도 없다.
  ``` Swift
  // [ 익스텐션을 통한 연산 프로퍼티 추가 ]
  
  extension Int {
      var isEven: Bool {
          return self % 2 == 0
      }
      
      var isOdd: Bool {
          return self % 2 == 1
      }
  }
  
  print(1.isEven) // false
  print(2.isEven) // true
  print(1.isOdd)  // true
  print(2.isOdd)  // false
  ```


### 📌 `메서드`
``` Swift
// [ 익스텐션을 통한 메서드 추가 ]

extension Int {
    // 인스턴스 메서드 추가
    func multiply(by n: Int) -> Int {
        return self * n
    }
    
    // 가변 메서드 추가
    mutating func multiplySelf(by n: Int) {
        self = self.multiply(by: n)
    }
    
    // 타입 메서드 추가
    static func isIntTypeInstance(_ instance: Any) -> Bool {
        return instance is Int
    }
}

print(3.multiply(by: 2))    // 6
print(4.multiply(by: 5))    // 20

var number: Int = 3
number.multiplySelf(by: 2)
print(number)   // 6

Int.isIntTypeInstance(number)   // true
Int.isIntTypeInstance(3)        // true
Int.isIntTypeInstance(3.0)      // false
Int.isIntTypeInstance("3")      // false

prefix operator ++

struct Position {
    var x: Int
    var y: Int
}

extension Position {
    // + 중위 연산 구현
    static func + (left: Position, right: Position) -> Position {
        return Position(x: left.x + right.x, y: left.y + right.y)
    }
    
    // - 전위 연산 구현
    static prefix func - (vector: Position) -> Position {
        return Position(x: -vector.x, y: -vector.y)
    }
    
    // += 복합할당 연산자 구현
    static func += (left: inout Position, right: Position) {
        left = left + right
    }
}

extension Position {
    // == 비교 연산자 구현
    static func == (left: Position, right: Position) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    // != 비교 연산자 구현
    static func != (left: Position, right: Position) -> Bool {
        return !(left == right)
    }
}

extension Position {
    // ++ 사용자 정의 연산자 구현
    static prefix func ++ (position: inout Position) -> Position {
        position.x += 1
        position.y += 1
        return position
    }
}

var myPosition: Position = Position(x: 10, y: 10)
var yourPosition: Position = Position(x: -5, y: -5)

print(myPosition + yourPosition)    // Position(x: 5, y: 5)
print(-myPosition)                  // Position(x: -10, y: -10)

myPosition += yourPosition
print(myPosition)                   // Position(x: 5, y: 5)

print(myPosition == yourPosition)   // false
print(myPosition != yourPosition)   // true

print(++myPosition)                 // Position(x: 6, y: 6)
```


### 📌 `이니셜라이저`
- 타입의 정의 부분에 이니셜라이저를 추가하지 않더라도 익스텐션을 통해 이니셜라이저를 추가할 수 있다.
  - 하지만 익스텐션으로 **`클래스 타입`** 에 `편의 이니셜라이저`는 추가할 수 있지만 `지정 이니셜라이저`는 추가할 수 없다.
  - `지정 이니셜라이저`와 `디이니셜라이저`는 반드시 클래스 타입의 구현부에 위치해야 한다. (값 타입은 상관x)
  ``` Swift
  // [ 익스텐션을 통한 이니셜라이저 추가 ]
  
  extension String {
      init(intTypeNumber: Int) {
          self = "\(intTypeNumber)"
      }
      
      init(doubleTypeNumber: Double) {
          self = "\(doubleTypeNumber)"
      }
  }
  
  let stringFromInt: String = String(intTypeNumber: 100)          // "100"
  let stringFromDouble: String = String(doubleTypeNumber: 100.0)  // "100.0"
  
  class Person {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  extension Person {
      convenience init() {
          self.init(name: "Unknown")
      }
  }
  
  let someOne: Person = Person()
  print(someOne.name) // "Unknown"
  ```

- 💡 익스텐션으로 값 타입에 이니셜라이저를 추가했을 때, 해당 값 타입이 아래 조건을 모두 만족한다면 **익스텐션으로 사용자 정의 이니셜라이저를 추가한 이후에도 해당 타입의 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 호출할 수 있다.** ([11.1.6 값 타입의 초기화 위임](https://github.com/kybeen/Swift-Study/blob/main/Chapter11/Chapter11.md) 참고)
  - 👉 모든 저장 프로퍼티에 `기본값`이 있음
  - 👉 타입에 기본 이니셜라이저와 멤버와이즈 이니셜라이저 외에 `추가 사용자 정의 이니셜라이저가 없음`
  ``` Swift
  // [ 익스텐션을 통한 초기화 위임 이니셜라이저 추가 ]
  
  struct Size {
      var width: Double = 0.0
      var height: Double = 0.0
  }
  
  struct Point {
      var x: Double = 0.0
      var y: Double = 0.0
  }
  
  struct Rect {
      var origin: Point = Point()
      var size: Size = Size()
  }
  
  let defaultRect: Rect = Rect()
  // 아직 Rect에 대해 정의한 사용자 정의 이니셜라이저가 없음
  // => Rect의 이니셜라이저와 멤버와이즈 이니셜라이저가 기본으로 제공됨
  let memberwiseRect: Rect = Rect(origin: Point(x: 2.0, y: 2.0),
                                  size: Size(width: 5.0, height: 5.0))
  
  extension Rect {
      // 사용자 정의 이니셜라이저를 익스텐션으로 추가했기 때문에 여전히 Rect의 기본 멤버와이즈 이니셜라이저를 호출할 수 있음
      init(center: Point, size: Size) {
          let originX: Double = center.x - (size.width / 2)
          let originY: Double = center.y - (size.height / 2)
          self.init(origin: Point(x: originX, y: originY), size: size)
      }
  }
  
  let centerRect: Rect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
  ```


### 📌 `서브스크립트`
- 익스텐션으로 타입에 서브스크립트도 추가할 수 있다.
    ``` Swift
    // [ 익스텐션을 통한 서브스크립트 추가 ]

    extension String {
        subscript(appedValue: String) -> String {
            return self + appedValue
        }
        
        subscript(repeatCount: UInt) -> String {
            var str: String = ""
            
            for _ in 0..<repeatCount {
                str += self
            }
            
            return str
        }
    }

    print("abc"["def"]) // "abcdef"
    print("abc"[3])     // "abcabcabc"

    ```


### 📌 `중첩 데이터 타입`
- 익스텐션을 통해 타입에 `중첩 데이터 타입(Nested Type)`을 추가할 수 있다.
  - ([Chapter 24. 타입 중첩](https://github.com/kybeen/Swift-Study/blob/main/Chapter24/Chapter24.md) 참고)
  ``` Swift
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
  ```