# **Chapter 26. where 절**
- 스위프트의 `where` 절은 특정 패턴과 결합하여 조건을 추가하는 역할을 한다.
---

## where 절의 활용
- 💡 `where` 절은 크게 2 가지 용도로 사용된다.
  - **👉 패턴과 결합하여 조건 추가**
  - **👉 타입에 대한 제약 추가**

### **📌 `값 바인딩, 와일드카드 패턴과 결합한 where 절`**
  ``` Swift
  // [ 값 바인딩, 와일드카드 패턴과 where 절의 활용 ]
  
  let tuples: [(Int, Int)] = [(1, 2), (1, -1), (1, 0), (0, 2)]
  
  // 값 바인딩, 와일드카드 패턴
  for tuple in tuples {
      switch tuple {
      case let (x, y) where x == y: print("x == y")
      case let (x, y) where x == -y: print("x == -y")
      case let (x, y) where x > y: print("x > y")
      case (1, _): print("x == 1")
      case (_, 2): print("y == 2")
      default: print("\(tuple.0), \(tuple.1)")
      }
  }
  /*
   x == 1
   x == -y
   x > y
   y == 2
   */
  
  var repeatCount: Int = 0
  // 값 바인딩 패턴
  for tuple in tuples {
      switch tuple {
      case let (x, y) where x == y && repeatCount > 2: print("x==y")
      case let (x, y) where repeatCount < 2: print("\(x), \(y)")
      default: print("Nothing")
      }
      
      repeatCount += 1
  }
  /*
   1, 2
   1, -1
   Nothing
   Nothing
   */
  
  let firstValue: Int = 50
  let secondValue: Int = 30
  
  // 값 바인딩 패턴
  switch firstValue + secondValue {
  case let total where total > 100: print("total > 100")
  case let total where total < 0: print("wrong value")
  case let total where total == 0: print("zero")
  case let total: print(total)
  }
  // 80
  ```
  ---


### **📌 `옵셔널 패턴과 결합한 where 절`**
  ``` Swift
  // [ 옵셔널 패턴과 where 절의 활용 ]
  
  let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
  
  for case let number? in arrayOfOptionalInts where number > 2 {
      print("Found a \(number)")
  }
  // Found a 3
  // Found a 5
  ```
  ---


### **📌 `타입캐스팅 패턴과 결합한 where 절`**
  ``` Swift
  // [ 타입캐스팅 패턴과 where 절의 활용 ]
  
  let anyValue: Any = "ABC"
  
  switch anyValue {
  case let value where value is Int: print("value is Int")
  case let value where value is String: print("value is String")
  case let value where value is Double: print("value is Double")
  default: print("Unknown type")
  }
  // value is String
  
  var things: [Any] = [Any]()
  
  things.append(0)
  things.append(0.0)
  things.append(42)
  things.append(3.14159)
  things.append("hello")
  things.append((3.0, 5.0))
  things.append({ (name: String) -> String in "Hello, \(name)" })
  
  for thing in things {
      switch thing {
      case 0 as Int:
          print("zero as an Int")
      case 0 as Double:
          print("zero as a Double")
      case let someInt as Int:
          print("an integer value of \(someInt)")
      case let someDouble as Double where someDouble > 0:
          print("a positive double value of \(someDouble)")
      case is Double:
          print("some other double value that I don't want to print")
      case let someString as String:
          print("a string value of \"\(someString)\"")
      case let (x, y) as (Double, Double):
          print("an (x, y) point at \(x), \(y)")
      case let stringConverter as (String) -> String:
          print(stringConverter("Michael"))
      default:
          print("something else")
      }
  }
  /*
   zero as an Int
   zero as a Double
   an integer value of 42
   a positive double value of 3.14159
   a string value of "hello"
   an (x, y) point at 3.0, 5.0
   Hello, Michael
   */
  ```
  ---



### **📌 `표현 패턴과 결합한 where 절`**
  ``` Swift
  // [ 표현 패턴과 where 절의 활용 ]
  
  var point: (Int, Int) = (1, 2)
  
  switch point {
  case (0, 0): print("원점")
  case (-2...2, -2...2) where point.0 != 1: print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
  default: print("point (\(point.0), \(point.1))")
  }
  // point (1, 2)
  ```
  ---



### **📌 `where 절을 활용한 프로토콜 익스텐션의 적용 조건 제한`**
- ✅ `프로토콜 익스텐션`에 `where` 절을 추가하면 **`이 익스텐션이 특정 프로토콜을 준수하는 타입에만 적용될 수 있도록`** 제약을 줄 수 있다.
  - ex) `extension SelfPrintable where Self: Container`
    - 👉 `SelfPrintable` 프로토콜을 준수하는 타입 중 `Container` 프로토콜도 준수하는 타입에만 이 익스텐션이 적용됨
  ``` Swift
  // [ where 절을 활용한 프로토콜 익스텐션의 프로토콜 준수 제약 추가 ]
  
  protocol SelfPrintable {
      func printSelf()
  }
  
  struct Person: SelfPrintable { }
  
  extension Int: SelfPrintable { }
  extension UInt: SelfPrintable { }
  extension String: SelfPrintable { }
  extension Double: SelfPrintable { }
  
  extension SelfPrintable where Self: FixedWidthInteger, Self: SignedInteger {
      func printSelf() {
          print("FixedWidthInteger와 SignedInteger을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of: self))")
      }
  }
  
  extension SelfPrintable where Self: CustomStringConvertible {
      func printSelf() {
          print("CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of: self))")
      }
  }
  
  extension SelfPrintable {
      func printSelf() {
          print("그 외 SelfPrintable을 준수하는 타입 \(type(of: self))")
      }
  }
  
  Int(-8).printSelf()
  // FixedWidthInteger와 SignedInteger을 준수하면서 SelfPrintable을 준수하는 타입 Int
  
  UInt(8).printSelf()
  // CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 UInt
  
  String("rei").printSelf()
  // CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 String
  
  Double(8.0).printSelf()
  // CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 Double
  
  Person().printSelf()
  // 그 외 SelfPrintable을 준수하는 타입 Person
  ```
  ---




### **📌 `where 절을 사용해 제네릭 함수의 타입 매개변수와 프로토콜의 연관 타입에 제약 추가하기`**
- **✅ `타입 매개`변수와 `연관 타입`의 제약을 추가하는 데 `where` 절을 사용할 수 있다.**
- `제네릭 함수(메서드)`의 반환 타입 뒤에 `where` 절을 포함하면 타입 매개변수와 연관 타입에 요구사항을 추가할 수 있다.
  - 👉 제네릭의 `where` 절을 사용한 요구사항은 타입 매개변수가 특정 클래스를 상속받았는지 또는 특정 프로토콜을 준수하는지를 표현할 수 있다.
  - [제네릭의 타입 제약(22.4장)](https://github.com/kybeen/Swift-Study/blob/main/Chapter22/Chapter22.md)에서 소개된 아래와 같은 방식으로 제네릭에 타입 제약을 추가하는 것은 `where 절을 사용하지 않고 간편하게 타입 제약을 추가할 수 있도록 제공되는 기능`임 (👉 `where` 절을 사용해서도 똑같이 구현할 수 있다.)
    ``` Swift
    struct Stack<Element: Hashable> {
        // 구조체 구현
    }
    ```

  ``` Swift
  // [ where 절을 활용한 타입 매개변수와 연관 타입의 타입 제약 추가 ]
  
  // 타입 매개변수 T가 BinaryInteger 프로토콜을 준수하는 타입
  func doubled<T>(integerValue: T) -> T where T: BinaryInteger {
      return integerValue * 2
  }
  // 위 함수와 같은 표현
  func doubled<T: BinaryInteger>(integerValue: T) -> T {
      return integerValue * 2
  }
  
  // 타입 매개변수 T와 U가 CustomStringConvertible 프로토콜을 준수하는 타입
  func prints<T, U>(first: T, second: U) where T: CustomStringConvertible, U: CustomStringConvertible {
      print(first)
      print(second)
  }
  // 위 함수와 같은 표현
  func prints<T: CustomStringConvertible, U: CustomStringConvertible>(first: T, second: U) {
      print(first)
      print(second)
  }
  
  // 타입 매개변수 S1과 S2가 Sequence 프로토콜을 준수하며
  // S1과 S2가 준수하는 프로토콜인 Sequence 프로토콜의 연관 타입인 Element가 같은 타입
  func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S1.Element: Equatable, S2: Sequence, S2.Element: Equatable {
      // ...
  }
  // 위 함수와 같은 표현
  func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S2: Sequence, S1.Element: Equatable, S1.Element == S2.Element {
      // ...
  }
  // 위 함수와 같은 표현
  func compareTwoSequences<S1: Sequence, S2: Sequence>(a: S1, b: S2) where S1.Element: Equatable, S1.Element == S2.Iterator.Element {
      // ...
  }
  
  // 프로토콜의 연관 타입에도 타입 제약을 줄 수 있다.
  protocol Container {
      associatedtype ItemType where ItemType: BinaryInteger
      var count: Int { get }
      
      mutating func append(_ item: ItemType)
      subscript(i: Int) -> ItemType { get }
  }
  // 위 표현과 같은 표현
  protocol Container where ItemType: BinaryInteger {
      associatedtype ItemType
      var count: Int { get }
      
      mutating func append(_ item: ItemType)
      subscript(i: Int) -> ItemType { get }
  }
  ```
  ---



### 📌 `연관 타입이 특정 프로토콜을 준수하는 경우에만 프로토콜을 채택하도록 제네릭 타입의 연관 타입에 제약조건 추가하기`
  ``` Swift
  // [ where 절을 활용한 제네릭 타입의 연관 타입 제약 추가 ]
  
  protocol Talkable { }
  protocol CallToAll {
      func callToAll()
  }
  
  struct Person: Talkable { }
  struct Animal { }
  
  // Array의 연관 타입인 Element가 Talkable 프로토콜을 준수하는 경우에만 CallToAll 프로토콜 채택
  extension Array: CallToAll where Element: Talkable {
      func callToAll() { }
  }
  
  let people: [Person] = []
  let cats: [Animal] = []
  
  people.callToAll()
  cats.callToAll() // ❌ 컴파일 오류 발생 !!
  // 👉 cats의 Element(원소)의 타입이 Animal인데, Animal은 Talable 프로토콜을 준수하지 않기 때문에 CallToAll 프로토콜을 채택하지 않음
  ```
  ---



### 📌 `where 절을 사용하여 메서드에 제약조건 추가하기`
  ``` Swift
  // [ where 절을 활용한 제네릭 타입의 메서드 제약 추가 ]
  
  struct Stack<Element> {
      var items = [Element]()
      mutating func push(_ item: Element) {
          items.append(item)
      }
      
      mutating func pop() -> Element {
          return items.removeLast()
      }
  }
  
  // 익스텐션을 사용한 제네릭 타입 확장
  extension Stack {
      // Element가 Comparable 프로토콜을 준수해야 메서드가 동작하도록 where절을 통해 제약을 줌
      func sorted() -> [Element] where Element: Comparable {
          return items.sorted()
      }
  }
  ```