# **Chapter 23. 프로토콜 지향 프로그래밍**
- 스위프트의 표준 라이브러리에서 타입과 관련된 대부분의 코드는 `구조체`로 구현되어 있다.
- 상속도 되지 않는 구조체로 다양한 공통 기능을 갖도록 할 수 있었던 것은 `프로토콜`, `익스텐션`, `제네릭` 등을 적절히 잘 활용했기 때문이다.


## 프로토콜 초기구현
- `프로토콜을 정의할 때`는 `정의`만 할 수 있고, 프로토콜의 요구사항을 구현할 수 없다.
- **💡 그러나 `프로토콜의 익스텐션`에서는 프로토콜이 요구하는 기능을 실제로 구현해줄 수 있다.**
  - 🚧 다만 저장 프로퍼티는 익스텐션에서 구현할 수 없기 때문에 각각의 타입에서 직접 구현해야 한다.
- **👉 프로토콜의 요구사항을 익스텐션을 통해 구현하는 것을 `프로토콜 초기구현(Protocol Default Implementations)`이라고 한다.**

- [Chapter 20. 프로토콜](https://github.com/kybeen/Swift-Study/blob/main/Chapter20/Chapter20.md)에서 구현했던 `Receivable`, `Sendable` 프로토콜을 준수하는 `Message`, `Mail` 타입의 코드에서 불필요하게 중복 구현되었던 코드를 아래와 같이 제거해줄 수 있다.
  - `Message`, `Mail` 클래스는 `Receivable`과 `Sendable` 프로토콜을 채택하고 있지만, 실제로 구현한 것은 저장 인스턴스 프로퍼티인 `to` 뿐이다.
  - **그 외의 기능은 이미 각 프로토콜의 익스텐션에 구현되어 있다.**
  ``` Swift
  // [ 익스텐션을 통한 프로토콜의 실제 구현 ]
  
  protocol Receivable {
      func received(data: Any, from: Sendable)
  }
  
  extension Receivable {
      // 메시지를 수신합니다.
      func received(data: Any, from: Sendable) {
          print("\(self) received \(data) from \(from)")
      }
  }
  
  // 무언가를 발신할 수 있는 기능
  protocol Sendable {
      var from: Sendable { get }
      var to: Receivable? { get }
      
      func send(data: Any)
      
      static func isSendableInstance(_ instance: Any) -> Bool
  }
  
  extension Sendable {
      // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
      var from: Sendable {
          return self
      }
      
      // 메시지를 발신한다..
      func send(data: Any) {
          guard let receiver: Receivable = self.to else {
              print("\(self) has no receiver")
              return
          }
          
          // 수신 가능한 인스턴스의 received 메서드를 호출
          receiver.received(data: data, from: self.from)
      }
      
      static func isSendableInstance(_ instance: Any) -> Bool {
          if let sendableInstance: Sendable = instance as? Sendable {
              return sendableInstance.to != nil
          }
          return false
      }
  }
  
  // 수신, 발신이 가능한 Message 클래스
  class Message: Sendable, Receivable {
      var to: Receivable?
  }
  
  // 수신, 발신이 가능한 Mail 클래스
  class Mail: Sendable, Receivable {
      var to: Receivable?
  }
  
  // 두 Message 인스턴스를 생성
  let myPhoneMessage: Message = Message()
  let yourPhoneMessage: Message = Message()
  
  // 아직 수신받을 인스턴스가 없음
  myPhoneMessage.send(data: "Hello")  // Message has no receiver
  
  // Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있다.
  myPhoneMessage.to = yourPhoneMessage
  myPhoneMessage.send(data: "Hello")  // Message received Hello from Message
  
  // Mail 인스턴스 2개 생성
  let myMail: Mail = Mail()
  let yourMail: Mail = Mail()
  
  myMail.send(data: "Hi")     // Mail has no receiver
  
  // Message와 Mail 모두 Sendable과 Receivable 프로토콜을 준수하므로
  // 서로 주고 받을 수 있다.
  myMail.to = yourMail
  myMail.send(data: "Hi")     // Mail received Hi from Mail
  
  myMail.to = myPhoneMessage
  myMail.send(data: "Bye")    // Message received Bye from Mail
  
  // String은 Sendable 프로토콜을 준수하지 않는다.
  Message.isSendableInstance("Hello")             // false
  
  // Message와 Mail은 Sendable 프로토콜을 준수한다.
  Message.isSendableInstance(myPhoneMessage)      // true
  Mail.isSendableInstance(myMail)                 // true
  
  // yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태
  Message.isSendableInstance(yourPhoneMessage)    // false
  Mail.isSendableInstance(myPhoneMessage)         // true
  ```

- 만약 프로토콜의 익스텐션에서 구현한 기능을 사용하지 않고, 타입의 특성에 따라 조금 변경해서 구현하고 싶다면 `재정의`하면 된다.
  - 이미 프로토콜을 준수하는 타입의 메서드를 호출한 것이기 때문에 사실 아래 코드는 재정의라고 할 수는 없다.
  - 프로토콜의 요구사항을 찾아보고 이미 구현되어 있다면 그 기능을 호출하고, 그렇지 않다면 프로토콜 초기구현의 기능을 호출한다.
    ``` Swift
    // [ 익스텐션을 통해 구현된 메서드 재정의 ]

    class Mail: Sendable, Receivable {
        var to: Receivable?
        
        func send(data: Any) {
            print("Mail의 send 메서드는 재정의되었습니다.")
        }
    }

    let mailInstance: Mail = Mail()
    mailInstance.send(data: "Hello")    // Mail의 send 메서드는 재정의되었습니다.
    ```

- [Chapter 22. 제네릭](https://github.com/kybeen/Swift-Study/blob/main/Chapter22/Chapter22.md)에서 작성했던 `Container` 프로토콜 관련 코드를 `제네릭, 프로토콜, 익스텐션`을 적절히 융합하여 재사용성을 높여준 코드는 아래와 같다.
  - 👉 `Stack`, `Queue` 구조체는 서로 동작하는 방식은 다르지만, 특정 아이템을 가질 수 있는 컨테이너라는 특성은 공유하기 때문에 `Container` 프로토콜을 채택하기만 하면 된다.
  - 👉 세부 요구사항은 `Stack`, `Queue` 각각이 조금씩 다르기 때문에 최종적으로는 `Container` 프로토콜을 상속받은 다른 프로토콜을 채택한다.(`Popable`, `Insertable`)
  - 👉 각각의 요소 타입은 제네릭을 통해 사용할 때 결정하므로 타입에 대해 유연하게 동작 가능하다.
    - 스위프트의 클래스는 다중상속을 지원하지 않기 때문에 부모클래스의 기능으로 부족하면 자식클래스에서 다시 구현해야 한다.
    - 하지만 프로토콜 초기구현을 한 프로토콜을 채택했다면 상속도, 추가 구현도 필요 없어진다.
    - 구조체, 열거형 등 상속을 지원하지 않는 값 타입도 초기구현을 한 프로토콜만 채택하면 기능 추가가 가능해진다.
  ``` Swift
  // [ 제네릭, 프로토콜, 익스텐션을 통한 재사용 가능한 코드 작성 ]
  
  protocol SelfPrintable {
      func printSelf()
  }
  
  extension SelfPrintable where Self: Container {
      func printSelf() {
          print(items)
      }
  }
  
  protocol Container: SelfPrintable {
      // 연관 타입을 활용하여 제네릭에 더욱 유연하게 대응할 수 있도록 정의
      associatedtype ItemType
      
      var items: [ItemType] { get set }
      var count: Int { get }
      
      mutating func append(item: ItemType)
      subscript(i: Int) -> ItemType { get }
  }
  
  extension Container {
      mutating func append(item: ItemType) {
          items.append(item)
      }
      
      var count: Int {
          return items.count
      }
      
      subscript(i: Int) -> ItemType {
          return items[i]
      }
  }
  
  protocol Popable: Container {
      mutating func pop() -> ItemType?
      mutating func push(_ item: ItemType)
  }
  
  extension Popable {
      mutating func pop() -> ItemType? {
          return items.removeLast()
      }
      
      mutating func push(_ item: ItemType) {
          self.append(item: item)
      }
  }
  
  protocol Insertable: Container {
      mutating func delete() -> ItemType?
      mutating func insert(_ item: ItemType)
  }
  
  extension Insertable {
      mutating func delete() -> ItemType? {
          return items.removeFirst()
      }
      
      mutating func insert(_ item: ItemType) {
          self.append(item: item)
      }
  }
  
  struct Stack<Element>: Popable {
      var items: [Element] = [Element]()
  }
  
  struct Queue<Element>: Insertable {
      var items: [Element] = [Element]()
  }
  
  var myIntStack: Stack<Int> = Stack<Int>()
  var myStringStack: Stack<String> = Stack<String>()
  var myIntQueue: Queue<Int> = Queue<Int>()
  var myStringQueue: Queue<String> = Queue<String>()
  
  myIntStack.push(3)
  myIntStack.printSelf()  // [3]
  myIntStack.push(2)
  myIntStack.printSelf()  // [3, 2]
  myIntStack.pop()        // 2
  myIntStack.printSelf()  // [3]
  
  myStringStack.push("A")
  myStringStack.printSelf()  // ["A"]
  myStringStack.push("B")
  myStringStack.printSelf()  // ["A", "B"]
  myStringStack.pop()        // "B"
  myStringStack.printSelf()  // ["A"]
  
  myIntQueue.insert(3)
  myIntQueue.printSelf()  // [3]
  myIntQueue.insert(2)
  myIntQueue.printSelf()  // [3, 2]
  myIntQueue.delete()     // 3
  myIntQueue.printSelf()  // [2]
  
  myStringQueue.insert("A")
  myStringQueue.printSelf()  // ["A"]
  myStringQueue.insert("B")
  myStringQueue.printSelf()  // ["A", "B"]
  myStringQueue.delete()     // "A"
  myStringQueue.printSelf()  // ["B"]
  ```
---

## 맵, 필터, 리듀스 직접 구현해보기
- 프로토콜, 익스텐션, 제네릭을 활용해서 [Chapter 15. 맵, 필터, 리듀스](https://github.com/kybeen/Swift-Study/blob/main/Chapter15/Chapter15.md)에서 봤던 `맵, 필터, 리듀스` 메서드를 구현해보자
  - `map` : 컨테이너가 담고 있던 각각의 값을 매개변수를 통해 받은 함수에 적용한 후 다시 컨테이너에 포장하여 반환하는 함수
  - `filter` : 컨테이너 내부의 값을 걸러서 추출해 새로운 컨테이너에 값을 담아 반환하는 함수
  - `reduce` : 컨테이너 내부의 콘텐츠를 하나로 합쳐주는 기능을 실행하는 함수

### 📌 `Map`
- `Int` 타입이 요소로 저장된 `Array` 제네릭 타입 컨테이너(`Array<Int>`)에 `map` 메서드를 호출하면 똑같이 `Array<Int>` 타입의 결과물을 반환한다.
    ``` Swift
    // [ Array 타입의 맵 사용 ]

    let items: Array<Int> = [1, 2, 3]

    let mappedItems: Array<Int> = items.map { (item: Int) -> Int in
        return item * 10
    }

    print(mappedItems)
    ```

- `Stack<Int>`도 똑같이 `map` 메서드를 통해 `Stack<Int>`를 반환받는다고 생각할 수 있다.
  - `Stack`에 구현한 `map` 메서드는 `Stack`의 요소를 변환하는 방법인 `transform` 함수를 전달받는다.
  - `transform` 함수는 `Stack` 요소의 타입인 `Element`의 값을 `T`타입으로 변환한 후 자신이 속해 있는 타입과 같은 컨테이너인 `Stack`의 모습으로 결과를 반환한다.
  ``` Swift
  // [ Stack 구조체의 맵 메서드 ]
  
  struct Stack<Element>: Popable {
      var items: [Element] = [Element]()
      
      func map<T>(transform: (Element) -> T) -> Stack<T> {
          var transformedStack: Stack<T> = Stack<T>()
          
          for item in items {
              transformedStack.items.append(transform(item))
          }
          
          return transformedStack
      }
  }
  
  var myIntStack: Stack<Int> = Stack<Int>()
  myIntStack.push(1)
  myIntStack.push(5)
  myIntStack.push(2)
  myIntStack.printSelf()  // [1, 5, 2]
  var myStrStack: Stack<String> = myIntStack.map{ "\($0)" }
  myStrStack.printSelf()  // ["1", "5", "2"]
  ```


### 📌 `Filter`
- `Filter`또한 `Map`과 마찬가지로 자신과 동일한 모양의 `Array` 타입을 반환해준다.
    ``` Swift
    // [ Array 타입의 필터 사용 ]

    let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
        return item % 2 == 0
    }

    print(filteredItems)    // [2]
    ```

- `Stack`의 필터 또한 `Array`의 필터와 동작하는 모습을 크게 다르지 않다.
  - 각 요소가 조건에 부합하는지 확인하여 부합하면 새로운 `Stack`에 포함하여 반환해준다.
  ``` Swift
  // [ Stack 구조체의 필터 메서드 ]
  
  struct Stack<Element>: Popable {
      var items: [Element] = [Element]()
      
      func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
          var filteredStack: Stack<ItemType> = Stack<ItemType>()
          
          for item in items {
              if includeElement(item) {
                  filteredStack.items.append(item)
              }
          }
          
          return filteredStack
      }
  }
  
  let filteredStack: Stack<Int> = myIntStack.filter { (item: Int) -> Bool in
      return item < 5
  }
  
  filteredStack.printSelf()   // [1, 2]
  ```

### 📌 `Reduce`
- `Array` 타입의 리듀스는 함수를 통해 변환하고 합한 타입을 반환해준다.
- 리듀스는 전달인자로 전달받은 `초깃값`과 `처리함수`를 통해 `초깃값과 동일한 타입의 결과를 반환`한다.
    ``` Swift
    // [ Array 타입의 리듀스 사용 ]

    let combinedItems: Int = items.reduce(0) { (result: Int, next: Int) -> Int in
        return result + next
    }
    print(combinedItems)        // 6

    let combinedItemsDoubled: Double = items.reduce(0.0) { (result: Double, next: Int) -> Double in
        return result + Double(next)
    }
    print(combinedItemsDoubled) // 6.0

    let combinedItemsString: String = items.reduce("") { (result: String, next: Int) -> String in
        return result + "\(next) "
    }
    print(combinedItemsString)  // "1 2 3 "
    ```

    ``` Swift
    // [ Stack 구조체의 리듀스 메서드 ]

    struct Stack<Element>: Popable {
        var items: [Element] = [Element]()

        func reduce<T>(_ initialResult: T, nextPartialResult: (T, Element) -> T) -> T {
            var result: T = initialResult
            
            for item in items {
                result = nextPartialResult(result, item)
            }
            
            return result
        }
    }

    let combinedInt: Int = myIntStack.reduce(100) { (result: Int, next: Int) -> Int in
        return result + next
    }
    print(combinedInt)      // 108

    let combinedDouble: Double = myIntStack.reduce(100.0) { (result: Double, next: Int) -> Double in
        return result + Double(next)
    }
    print(combinedDouble)   // 108.0

    let combinedString: String = myIntStack.reduce("") { (result: String, next: Int) -> String in
        return result + "\(next) "
    }
    print(combinedString)   // "1 5 2 "
    ```
---

## 기본 타입 확장
- 프로토콜 초기구현을 통해 스위프트의 기본 타입을 확장하여 원하는 기능을 공통적으로 추가해불 수도 있다.
- 스위프트 표준 라이브러이에 정의되어 있는 타입은 실제 구현코드를 보고 수정할 수가 없기 때문에 `익스텐션, 프로토콜, 프로토콜의 초기구현`을 사용해 기본 타입에 기능을 추가해볼 수 있다.

- 코드를 수정할 수 없는 스위프트의 기본 타입인 `Int`, `String`, `Double에` `SelfPrintable` 프로토콜과 그 프로토콜의 초기구현으로 공통 기능을 추가한 예시 코드
    ``` Swift
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
    ```