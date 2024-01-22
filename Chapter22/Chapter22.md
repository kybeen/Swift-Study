# **Chapter 22. 제네릭**
- `제네릭(Generic)`을 이용해 코드를 구현하면 어떤 타입에도 유연하게 대응할 수 있다.
- 제네릭으로 구현한 기능과 타입은 `재사용`하기도 쉽고, `코드의 중복`을 줄이면서 `깔끔하고 추상적인 표현`이 가능해진다.

- Swift 표준 라이브러리 또한 많은 제네릭 코드로 구성되어 있다.
  - ex) `Array`, `Dictionary`, `Set` 등의 타입은 모두 `제네릭 컬렉션`이기 때문에 `Int`, `String` 등 어떤 타입이라도 요소로 가질 수 있는 것임
    <img width="485" alt="스크린샷 2024-01-22 오후 4 55 07" src="https://github.com/kybeen/Swift-Study/assets/89764127/02067076-c811-4271-a909-56e7e2a00d73">

- ✅ 제네릭을 사용하고자 할 때는 `제네릭이 필요한 타입 또는 메서드`의 이름 뒤의 `<>` 사이에 제네릭을 위한 `타입 매개변수`를 써준다.
  ``` Swift
  제네릭을 사용하고자 하는 타입 이름 <타입 매개변수>
  제네릭을 사용하고자 하는 함수 이름 <타입 매개변수> (함수의 매개변수...)
  ```

- [Chapter 5. 연산자](https://github.com/kybeen/Swift-Study/blob/main/Chapter5/Chapter5.md)에서의 예제 코드를 살펴보면
  - 사용자 정의 연산자 `**`는 `Int` 타입에서만 사용이 가능하다. (`UInt` 같은 타입에서는 사용하지 못함)
    ``` Swift
    // [ 전위 연산자 구현과 사용 ]

    prefix operator **

    prefix func ** (value: Int) -> Int {
        return value * value
    }

    let minusFive: Int = -5
    let sqrtMinusFive: Int = **minusFive
    print(sqrtMinusFive) // 25
    ```
  - 다른 타입에도 적용할 수 있는 더 범용적인 연산자로 바꾸려면 제네릭을 이용해 연산자를 구현해주면 된다.
    ``` Swift
    // [ 프로토콜과 제네릭을 이용한 전위 연산자 구현과 사용 ]

    prefix operator **

    prefix func ** <T: BinaryInteger> (value: T) -> T {
        return value * value
    }

    let minusFive: Int = -5
    let five: UInt = 5

    let sqrtMinusFive: Int = **minusFive
    let sqrtFive: UInt = **five

    print(sqrtMinusFive)    // 25
    print(sqrtFive)         // 25
    ```

### 📌 `제네릭이 필요한 이유`
- 아래 예시 코드의 `swapTwoValues(_:_:)` 함수는 `inout` 매개변수로 두 `Any` 타입의 값을 받는다.
  - 이렇게 한다면 `Int` 타입이든, `String` 타입이든 어느 타입이 들어와도 값은 교환할 수 있을 것이다.
- 👉 하지만 `Int`면 `Int`끼리, `String`이면 `String`끼리 교환하는 등의 제한을 줄 수가 없는 문제가 있다.
- 👉 그리고 `inout` 매개변수가 `Any`타입이기 때문에 매개변수로 전달될 전달인자의 타입은 `Any`여야 한다.
    ``` Swift
    // [ 제네릭을 사용하지 않은 swapTwoValues(_:_:) 함수 ]

    func swapTwoValues(_ a: inout Any, _ b: inout Any) {
        let temporaryA: Any = a
        a = b
        b = temporaryA
    }

    var anyOne: Any = 1
    var anyTwo: Any = "Two"

    swapTwoValues(&anyOne, &anyTwo)
    print("\(anyOne), \(anyTwo)")   // "Two", 1

    var stringOne: String = "A"
    var stringTwo: String = "B"
    swapTwoValues(&stringOne, &stringTwo)   // 오류 - Any 외 다른 타입의 전달인자 전달 불가
    ```
---


## 제네릭 함수
- 같은 타입인 두 변수의 값을 교환한다는 목적을 타입에 상관없이 할 수 있도록, 위의 예시 코드를 `제네릭을 사용한 하나의 함수`로 아래처럼 수정할 수 있다.
- ✅ 제네릭 함수는 실제 타입 이름을 써주는 대신에 `플레이스홀더(Placeholder)`를 사용한다. (아래 코드에서의 `T`)
  - 플레이스홀더는 타입의 종류를 알려주지 않지만 `어떤 타입이라는 것은 알려주기 때문에`, 아래 코드의 두 매개변수는 같은 타입이라는 것을 알 수 있다.
  - **`T`의 실제 타입은 함수가 호출되는 순간 결정된다.**
- ✅ 플레이스홀더 타입 `T`는 `타입 매개변수(Type parameter)`의 한 예로 들 수 있다.
  - 타입 매개변수는 플레이스홀더 타입의 이름을 지정하고 명시하는 역할을 하며, 함수 이름 뒤 `<>` 안쪽에 위치한다. (`<T>`)
- ✅ 만약 여러 개의 타입 매개변수를 갖고 싶다면 `<T, U, V>` 같은 식으로 나열해주면 된다.
``` Swift
// [ 제네릭을 사용한 swapTwoValues(_:_:) 함수 ]

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA: T = a
    a = b
    b = temporaryA
}

var numberOne: Int = 5
var numberTwo: Int = 10
var stringOne: String = "A"
var stringTwo: String = "B"
var anyOne: Any = 1
var anyTwo: Any = "Two"

swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)") // 10, 5

swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)") // B, A

swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")       // Two, 1

swapTwoValues(&numberOne, &stringOne) // 🚧 같은 타입끼리만 교환 가능하기 때문에 오류 발생
```

- 의미있는 이름으로 타입 매개변수 이름을 지정해주면 더 명확히 표현할 수 있다.
  - ex) `Dictionary<Key, Value>`
---


## 제네릭 타입
- 제네릭 타입을 구현하면 사용자 정의 타입인 구조체, 클래스, 열거형 등 어떤 타입과도 연관되어 동작할 수 있다.

- 📌 모든 타입을 대상으로 동작할 수 있는 `Stack` 구조체 타입을 구현한 예시
    ``` Swift
    // [ 제네릭을 사용한 Stack 구조체 타입 ]

    struct Stack<Element> {
        var items = [Element]()
        mutating func push(_ item: Element) {
            items.append(item)
        }
        mutating func pop() -> Element {
            return items.removeLast()
        }
    }

    // 인스턴스 생성 시 실제로 Element 대신 어떤 타입을 사용할지 명시해준다.
    var doubleStack: Stack<Double> = Stack<Double>()

    doubleStack.push(1.0)
    print(doubleStack.items)    // [1.0]
    doubleStack.push(2.0)
    print(doubleStack.items)    // [1.0, 2.0]
    doubleStack.pop()
    print(doubleStack.items)    // [1.0]

    var stringStack: Stack<String> = Stack<String>()

    stringStack.push("1")
    print(stringStack.items)    // ["1"]
    stringStack.push("2")
    print(stringStack.items)    // ["1", "2"]
    stringStack.pop()
    print(stringStack.items)    // ["1"]

    var anyStack: Stack<Any> = Stack<Any>()

    anyStack.push(1.0)
    print(anyStack.items)    // [1.0]
    anyStack.push("2")
    print(anyStack.items)    // [1.0, "2"]
    anyStack.pop()
    print(anyStack.items)    // [1.0]
    ```
---


## 제네릭 타입 확장
- `익스텐션`을 통해 제네릭을 사용하는 타입에 기능을 추가하고자 한다면 `익스텐션 정의에 타입 매개변수를 명시하지 않아야 한다.` 대신 원래의 제네릭 정의에 명시한 타입 매개변수를 사용할 수 있다.
``` Swift
// [ 익스텐션을 통한 제네릭 타입의 기능 추가 ]

extension Stack {
    // 기존 제네릭 타입 정의에 명시했던 타입 매개변수인 Element를 익스텐션에서 사용할 수 있다.
    var topElement: Element? {
        return self.items.last
    }
}

print(doubleStack.topElement)   // Optional(1.0)
print(stringStack.topElement)   // Optional("1")
print(anyStack.topElement)      // Optional(1.0)
```
---


## 타입 제약
- 제네릭의 타입 매개변수는 실제 사용 시 타입의 제약 없이 사용할 수 있도록 해준다.
- 하지만 `제네릭 함수가 처리해야 할 기능이 특정 타입에 한정되어야만 처리할 수 있어야 하거나`, `제네릭 타입을 특정 프로토콜을 따르는 타입만 사용할 수 있도록 제약`을 두어야 하는 상황이 발생할 수 있다.
- ✅ **`타입 제약(Type Constraints)`을 사용하면 타입 매개변수가 가져야 할 제약사항을 지정할 수 있다.**
  - 타입 제약은 `클래스 타입` 또는 `프로토콜`로만 줄 수 있다.

- 📌 자주 사용하는 제네릭 타입 중 하나인 `Dictionary`의 키는 `Hashable` 프로토콜을 준수하는 타입만 사용할 수 있다.
  - `Key : Hashable`은 타입 매개변수 `Key`타입은 `Hashable`프로토콜을 준수해야 한다는 것을 의미한다.
  - `Hashable`은 스위프트 표준 라이브러리에 정의되어 있는 프로토콜이며 스위프트의 기본 타입(`String`, `Int`, `Bool` 등)은 모두 `Hashable` 프로토콜을 준수한다.
    <img width="510" alt="스크린샷 2024-01-22 오후 6 14 54" src="https://github.com/kybeen/Swift-Study/assets/89764127/5f36a061-fff2-4170-9d52-e5b1ff1a8ef7">
    ``` Swift
    // [ Dictionary 타입 정의 ]
    public struct Dictionary<Key : Hashable, Value> : Collection, ExpressibleByDictionaryLiteral { /* ... */ }
    ```

- ✅ 제네릭 타입에 제약을 주고 싶으면 `타입 매개변수` 뒤에 `콜론(:)`을 붙인 후 원하는 `클래스 타입`/`프로토콜`을 명시해준다.
    ``` Swift
    // [ 제네릭 타입 제약 ]

    func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) {
        // 함수 구현
    }

    struct Stack<Element: Hashable> {
        // 구조체 구현
    }
    ```
- ✅ `여러 제약`을 추가하고 싶다면 콤마로 구분해주는 것 말고 `where`절을 사용해준다.
    ``` Swift
    // [ 제네릭 타입 제약 추가 ]

    // T는 BinaryInteger 프로토콜과 FloatingPoint 프로토콜을 모두 준수하는 타입만 사용할 수 있다.
    func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) where T: FloatingPoint {
        // 함수 구현
    }
    ```

- `타입 매개변수마다 제약조건을 다르게 구현`해줄 수도 있다.
    ``` Swift
    // [ makeDictionaryWithTwoValue 함수의 구현 ]

    func makeDictionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
        let dictionary: Dictionary<Key, Value> = [key:value]
        return dictionary
    }
    ```

> **💡 스위프트의 표준 라이브러리에 정의되어 있는 프로토콜 중 타입 제약에 자주 사용할 만한 프로토콜에는 `Hashable`, `Equatable`, `Comparable`, `Indexable`, `IteratorProtocol`, `Error`, `Collection`, `CustomStringConvertible` 등이 있다.**
---


## 프로토콜의 연관 타입
- **`연관 타입(Associated Type)`은 `프로토콜`에서 사용할 수 있는 플레이스홀더 이름이다.**
  - 타입 매개변수의 역할을 프로토콜에서 수행할 수 있도록 만들어진 기능

- 아래 코드에서는 존재하지 않는 타입인 `ItemType을` `연관 타입`으로 정의하여 프로토콜 정의에서 타입 이름으로 활용한다. (타입 매개변수와 유사한 기능)
    ``` Swift
    // [ Container 프로토콜 정의 ]

    // Container가 어떤 타입의 아이템을 저장해야 할 지에 대해서는 언급하지 않는다.
    protocol Container {
        associatedtype ItemType
        var count: Int { get }
        mutating func append(_ item: ItemType)
        subscript(i: Int) -> ItemType { get }
    }
    ```
    ``` Swift
    // [ MyContainer 클래스 정의 ]

    class MyContainer: Container {
        var items: Array<Int> = Array<Int>()
        
        var count: Int {
            return items.count
        }
        
        // 연관 타입인 ItemType 대신 실제 타입인 Int로 구현해준다.
        func append(_ item: Int) {
            items.append(item)
        }
        
        // 연관 타입인 ItemType 대신 실제 타입인 Int로 구현해준다.
        subscript(i: Int) -> Int {
            return items[i]
        }
    }
    ```
- 만약 `ItemType`을 어떤 타입으로 사용할지 조금 더 명확히 해주고 싶다면, `typealias ItemType = Int`라고 `타입 별칭`을 지정해줄 수 있다.
    ``` Swift
    class MyContainer: Container {
        // ItemType의 타입 별칭 지정
        typealias ItemType = Int
        
        var items: Array<ItemType> = Array<ItemType>()
        
        var count: Int {
            return items.count
        }
        
        func append(_ item: ItemType) {
            items.append(item)
        }
        
        subscript(i: Int) -> ItemType {
            return items[i]
        }
    }
    ```

- 프로토콜의 연관 타입에 실제 타입을 대응하여 사용할 수도 있지만, **제네릭 타입에서는 `연관 타입`과 `타입 매개변수`를 대응시킬 수도 있다.**
    ``` Swift
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
    ```
---


## 제네릭 서브스크립트
- 제네릭 함수와 마찬가지로 서브스크립트도 제네릭을 활용하여 타입 제한 없이 유연하게 사용할 수 있도록 구현할 수 있다.
    ``` Swift
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
    ```