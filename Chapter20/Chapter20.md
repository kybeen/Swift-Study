# **Chapter 20. 프로토콜**


## 프로토콜이란
**`프로토콜(Protocol)`**
- **특정 역할을 하기 위한 메서드, 프로퍼티, 기타 요구사항 등의 청사진을 정의한다.**
- 구조체, 클래스, 열거형은 프로토콜을 `채택(Adopted)`함으로써 특정 기능을 실행하기 위한 프로토콜의 요구사항을 실제로 구현할 수 있다. 👉 `프로토콜을 준수(Conform)`한다고 함
  - 타입에서 프로토콜의 요구사항을 충족시키려면 프로토콜이 제시하는 청사진의 기능을 모두 구현해야 한다. (**`프로토콜은 정의/제시만 할 뿐, 스스로 기능을 구현하지는 않는다.`**)
---

## 프로토콜 채택
``` Swift
protocol 프로토콜 이름 {
    프로토콜 정의
}
```

``` Swift
// [ 타입의 프로토콜 채택 ]

struct SomeStruct: AProtocol, AnotherProtocol {
    // 구조체 정의
}

struct SomeClass: AProtocol, AnotherProtocol {
    // 클래스 정의
}

struct SomeEnum: AProtocol, AnotherProtocol {
    // 열거형 정의
}
```

- 만약 클래스가 다른 클래스를 `상속` 받는다면 **상속받을 클래스 이름 다음에 채택할 프로토콜을 나열**
    ``` Swift
    struct SomeClass: SuperClass, AProtocol, AnotherProtocol {
        // 클래스 정의
    }
    ```
---

## 프로토콜 요구사항
- 프로토콜은 타입이 특정 기능을 실행하기 위해 필요한 프로퍼티/메서드 등을 `요구`한다.

### 📌 `프로퍼티 요구`
- 프로토콜은 프로퍼티를 요구할 때 그 프로퍼티의 종류는 신경쓰지 않는다. (연산 프로퍼티 / 저장 프로퍼티 여부 등)
  - 프로토콜을 채택한 타입은 요구 프로퍼티의 `이름`과 `타입`만 맞도록 구현하면 됨
  - `읽기 전용` / `읽기﹒쓰기 가능` 중 어떻게 사용할 지는 프로토콜이 정해야 한다.
    - 프로토콜이 읽고 쓰기가 가능한 프로퍼티를 요구할 경우 👉 **`읽기 전용`으로 구현 불가**
    - 프로토콜이 읽기 가능한 프로퍼티를 요구할 경우 👉 **`읽기 전용` & `읽기﹒쓰기` 모두 구현 가능**
- **✅ `var` 키워드를 사용한 변수 프로퍼티로 정의해준다.**
  - `읽기﹒쓰기` 👉 `{ get set }`
  - `읽기 전용` 👉 `{ get }`
- ✅ `타입 프로퍼티` 요구 시에는 `static` 키워드 사용
  - 원래 클래스의 타입 프로퍼티에서 상속 가능한 타입 프로퍼티인 `class`와 상속 불가능한 `static`가 나뉘는데, 프로토콜 요구 시에는 이를 구분할 필요x
  ``` Swift
  // [ 프로퍼티 요구 ]

  protocol SomeProtocol {
      var settableProperty: String { get set }         // 읽기﹒쓰기 모두 요구
      var notNeedToBeSettableProperty: String { get }  // 읽기만 가능하다면 어떻게 구현해도 상관x
  }

  protocol AnotherProtocol {
      // 타입 프로퍼티 요구
      static var someTypeProperty: Int { get set }
      static var anotherTypeProperty: Int { get }
  }
  ```

- 예시 코드
    ``` Swift
    // [ Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스 ]

    protocol Sendable {
        var from: String { get }
        var to: String { get }
    }

    class Message: Sendable {
        var sender: String
        var from: String { // 읽기 전용 연산 프로퍼티
            return self.sender
        }
        
        var to: String
        
        init(sender: String, receiver: String) {
            self.sender = sender
            self.to = receiver
        }
    }

    class Mail: Sendable {
        var from: String
        var to: String
        
        init(sender: String, receiver: String) {
            self.from = sender
            self.to = receiver
        }
    }
    ```


### 📌 `메서드 요구`
- 메서드의 실제 구현부인 `{}` 부분은 제외하고, 메서드의 `이름, 매개변수, 반환 타입` 등만 작성한다. (가변 매개변수도 허용)
  - 프로토콜의 메서드 요구에서는 매개변수 기본값을 설정할 수x
  - 타입 메서드 요구 시에는 타입 프로퍼티 요구와 마찬가지로 `static` 키워드만 사용하면 됨

- 예시 코드
    ``` Swift
    // [ Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스 ]

    // 무언가를 수신받을 수 있는 기능
    protocol Receiveable {
        func received(data: Any, from: Sendable)
    }

    // 무언가를 발신할 수 있는 기능
    protocol Sendable {
        var from: Sendable { get }
        var to: Receiveable? { get }
        
        func send(data: Any)
        
        static func isSendableInstance(_ instance: Any) -> Bool
    }

    // 수신, 발신이 가능한 Message 클래스
    class Message: Sendable, Receiveable {
        // 발신은 발신 가능한 객체 → Sendable 프로토콜을 준수하는 타입의 인스턴여야 한다.
        var from: Sendable {
            return self
        }
        
        // 상대방은 수신 가능한 객체 → Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
        var to: Receiveable?
        
        // 메시지를 발신
        func send(data: Any) {
            guard let receiver: Receiveable = self.to else {
                print("Message has no receiver")
                return
            }
            // 수신 가능한 인스턴스의 received 메서드를 호출한다.
            receiver.received(data: data, from: self.from)
        }
        
        // 메시지를 수신
        func received(data: Any, from: Sendable) {
            print("Message received \(data) from \(from)")
        }
        
        // class 메서드이므로 상속이 가능
        class func isSendableInstance(_ instance: Any) -> Bool {
            if let sendableInstance: Sendable = instance as? Sendable {
                return sendableInstance.to != nil
            }
            return false
        }
    }

    // 수신, 발신이 가능한 Mail 클래스
    class Mail: Sendable, Receiveable {
        var from: Sendable {
            return self
        }
        
        var to: Receiveable?
        
        func send(data: Any) {
            guard let receiver: Receiveable = self.to else {
                print("Mail has no receiver")
                return
            }
            receiver.received(data: data, from: self.from)
        }
        
        func received(data: Any, from: Sendable) {
            print("Mail received \(data) from \(from)")
        }
        
        // static 메서드이므로 상속이 불가능
        static func isSendableInstance(_ instance: Any) -> Bool {
            if let sendableInstance: Sendable = instance as? Sendable {
                return sendableInstance.to != nil
            }
            return false
        }
    }

    // 두 Message 인스턴스를 생성
    let myPhoneMessage: Message = Message()
    let yourPhoneMessage: Message = Message()

    // 아직 수신받을 인스턴스가 없음
    myPhoneMessage.send(data: "Hello")  // Message has no receiver

    // Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있다.
    myPhoneMessage.to = yourPhoneMessage
    myPhoneMessage.send(data: "Hello")  // Message received Hello from Message

    // 두 Mail 인스턴스를 생성
    let myMail: Mail = Mail()
    let yourMail: Mail = Mail()

    myMail.send(data: "Hi")     // Mail has no receiver

    // Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있다.
    myMail.to = yourMail
    myMail.send(data: "Hi")     // Mail received Hi from Mail

    myMail.to = myPhoneMessage
    myMail.send(data: "Bye")    // Message received Bye from Mail

    // String은 Sendable 프로토콜을 준수하지 X
    Message.isSendableInstance("Hello")             // false

    // Mail과 Message는 Sendable 프로토콜을 준수한다.
    Message.isSendableInstance(myPhoneMessage)      // true

    // yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태
    Message.isSendableInstance(yourPhoneMessage)    // false
    Mail.isSendableInstance(myPhoneMessage)         // true
    Mail.isSendableInstance(myMail)                 // true
    ```

> **💡 타입으로서의 프로토콜**
> 
> 프로토콜은 요구만 하고 스스로 기능을 구현하지는 않지만, 코드에서 **`완전한 하나의 타입`** 으로 사용할 수 있다.
> - **✅ 함수, 메서드, 이니셜라이저에서 매개변수 타입이나 반환 타입으로 사용될 수 있다.**
> - **✅ 프로퍼티, 변수, 상수 등의 타입으로 사용될 수 있다.**
> - **✅ 배열, 딕셔너리 등 컨테이너 요소의 타입으로 사용될 수 있다.**


### 📌 `가변 메서드 요구`
- **프로토콜이 어떤 타입이든 간에 인스턴스 내부의 값을 변경해야 하는 메서드를 요구할 때는 `mutating` 키워드와 함께 메서드를 정의한다.**
  - `클래스`의 경우에는 원래 `mutating` 키워드가 필요 없기 때문에, 프로토콜 요구 메서드 정의에서 `mutating`을 사용했으면, 실제 클래스 구현에서는 `mutating` 키워드를 적지 않아도 된다. (🚧 구조체 등의 값 타입은 적어줘야 함)
  ``` Swift
  // [ Resettable 프로토콜의 가변 메서드 요구 ]
  
  protocol Resettable {
      mutating func reset()
  }
  
  class Person: Resettable {
      var name: String?
      var age: Int?
      
      func reset() {
          self.name = nil
          self.age = nil
      }
  }
  
  struct Point: Resettable {
      var x: Int = 0
      var y: Int = 0
      
      mutating func reset() {
          self.x = 0
          self.y = 0
      }
  }
  
  enum Direction: Resettable {
      case east, west, south, north, unknown
      
      mutating func reset() {
          self = Direction.unknown
      }
  }
  ```


### 📌 `이니셜라이저 요구`
- 메서드 요구와 마찬가지로 이니셜라이저를 정의하지만 `구현은 하지 x`

    ``` Swift
    // [ 프로토콜의 이니셜라이저 요구와 구조체의 이니셜라이저 요구 구현 ]

    protocol Named {
        var name: String { get }
        
        init(name: String)
    }

    struct Pet: Named {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    ```

- 구조체는 이니셜라이저 요구에 대해 크게 신경 쓸 필요 없지만 `클래스`의 경우에는 이니셜라이저 요구에 부합하는 이니셜라이저를 구현하려면 👉 **`required` 식별자를 붙인 요구 이니셜라이저로 구현해야 한다.**
  - 특정 프로토콜을 채택한 클래스를 상속받는다면, 그 자식 클래스들은 모두 부모 클래스가 준수한 프로토콜을 준수해야 하기 때문에 프로토콜에서 요구하는 이니셜라이저도 반드시 구현해야 한다. 👉 그렇기 때문에 요구되는 이니셜라이저가 있다면 `required` 이니셜라이저로 구현해야 한다.
  ``` Swift
  // [ 클래스의 이니셜라이저 요구 구현 ]
  
  class Person: Named {
      var name: String
      
      // 프로토콜에서 요구하는 이니셜라이저를 클래스에서 구현할 때는 required 필요
      required init(name: String) {
          self.name = name
      }
  }
  ```

- 클래스 자체가 상속받을 수 없는 `final` 클래스라면 `required`를 붙여줄 필요가 없다. 상속할 수 없는 클래스의 요구(`required`) 이니셜라이저 구현은 의미 없기 때문
  ``` Swift
  // [ 상속 불가능한 클래스의 이니셜라이저 요구 구현 ]
  
  final class Person: Named {
      var name: String
      
      // final 클래스에는 required를 적을 필요 x
      init(name: String) {
          self.name = name
      }
  }
  ```

- 특정 클래스에 `프로토콜이 요구하는 이니셜라이저가 이미 구현`되어 있는 상황에서 그 클래스를 상속받는 자식 클래스가 있다면 `required`와 `override`를 모두 명시해서 이니셜라이저를 구현해야 한다.
  - 프로토콜에서 `요구(required)`하고 있고, 부모 클래스의 이니셜라이저를 `재정의(override)`하는 것이기 때문
  ``` Swift
  // [ 상속받은 클래스의 이니셜라이저 요구 구현 및 재정의 ]
  
  class School {
      var name: String
      
      // Named 프로토콜을 채택하지 않았지만 Named 프로토콜에서 요구하는 이니셜라이저가 있음
      init(name: String) {
          self.name = name
      }
  }
  
  class MiddleSchool: School, Named {
      // Named 프로토콜에서 요구하는 이니셜라이저와 동일한 이니셜라이저가 부모 클래스인 School에 구현되어 있기 때문에
      // required override 키워드 둘 다 적어줘야 함
      required override init(name: String) {
          super.init(name: name)
      }
  }
  ```

- `실패 가능한 이니셜라이저`를 요구하는 프로토콜을 준수하는 타입은 해당 이니셜라이저로 구현할 때 실패 가능한 이니셜라이저로 구현해도 되고, 일반 이니셜라이저로 구현해도 된다.
  ``` Swift
  // [ 실패 가능한 이니셜라이저 요구를 포함하는 Named 프로토콜과 Named 프로토콜을 준수하는 다양한 타입들 ]
  
  protocol Named {
      var name: String { get }
      
      init?(name: String) // 실패 가능한 이니셜라이저 요구
  }
  
  
  struct Animal: Named {
      var name: String
      
      // 실패 가능한 이니셜라이저 (옵셔널이 아닌 인스턴스를 반환하는)
      init!(name: String) {
          self.name = name
      }
  }
  
  struct Pet: Named {
      var name: String
      
      // 실패하지 않는 이니셜라이저
      init(name: String) {
          self.name = name
      }
  }
  
  class Person: Named {
      var name: String
      
      // 실패하지 않는 요구 이니셜라이저
      required init(name: String) {
          self.name = name
      }
  }
  
  class School: Named {
      var name: String
      
      // 실패 가능한 요구 이니셜라이저
      required init?(name: String) {
          self.name = name
      }
  }
  ```
---

## 프로토콜의 상속과 클래스 전용 프로토콜
- 프로토콜은 하나 이상의 `프로토콜을 상속`받아 기존 프로토콜의 요구사항보다 더 많은 요구사항을 추가할 수 있다.
  - 클래스의 상속 문법과 유사하다.
``` Swift
// [ 프로토콜의 상속 ]

protocol Readable {
    func read()
}

protocol Writeable {
    func write()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}


class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func write() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}
```

- 프로토콜의 상속 리스트에 `class` 키워드를 추가하면 프로토콜이 **`클래스 타입에만 채택될 수 있도록 제한`** 할 수 있다.
    ``` Swift
    // [ 클래스 전용 프로토콜의 정의 ]

    protocol ClassOnlyProtocol: class, Readable, Writeable {
        func onlyClassMethod()
    }

    class SomeClass: ClassOnlyProtocol {
        func read() {
            print("Read")
        }
        
        func write() {
            print("Write")
        }
        
        func onlyClassMethod() {
            print("Conform Only Class Protocol")
        }
    }

    // ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능하기 때문에 오류!!
    struct SomeStruct: ClassOnlyProtocol {
        func read() { }
        func write() { }
    }
    ```
---

## 프로토콜 조합과 프로토콜 준수 확인
- `하나의 매개변수가 여러 프로토콜을 모두 준수하는 타입`이어야 한다면 하나의 매개변수에 여러 프로토콜을 한 번에 `조합(Composition)`하여 요구할 수 있다.
  - ✅ 프로토콜을 조합하여 요구할 때는 `&`를 사용하여 표현한다.
    - ex) `SomeProtocol & AnotherProtocol`

- 또한 클래스와 프로토콜 조합을 통해 `특정 클래스의 인스턴스 역할을 하는지`도 함께 확인할 수 있다.
  - 조합 중 `클래스 타입`은 `한 타입만 조합`할 수 있다.
  ``` Swift
  // [ 프로토콜 조합 및 프로토콜, 클래스 조합 ]
  
  protocol Named {
      var name: String { get }
  }
  
  protocol Aged {
      var age: Int { get }
  }
  
  struct Person: Named, Aged {
      var name: String
      var age: Int
  }
  
  class Car: Named {
      var name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  class Truck: Car, Aged {
      var age: Int
      
      init(name: String, age: Int) {
          self.age = age
          super.init(name: name)
      }
  }
  
  func celebrateBirthday(to celebrator: Named & Aged) {
      print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
  }
  
  let rei: Person = Person(name: "rei", age: 99)
  celebrateBirthday(to: rei)      // Happy birthday rei!! Now you are 99
  
  let myCar: Car = Car(name: "Boong Boong")
  celebrateBirthday(to: myCar)    // 오류 발생!! Aged를 충족시키지 못하기 때문
  
  // 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합할 수 있기 때문에 오류 발생!!
  var someVariable: Car & Truck & Aged
  
  // Car 클래스의 인스턴스 역할도 수행할 수 있고,
  // Aged 프로토콜을 준수하는 인스턴스만 할당할 수 있다.
  var someVariable: Car & Aged
  
  // Truck 인스턴스는 Car 클래스 역할도 할 수 있고, Aged 프로토콜도 준수하므로 할당할 수 있다.
  someVariable = Truck(name: "Truck", age: 5)
  
  // Car의 인스턴스인 myCar는 Aged 프로토콜을 준수하지 않으므로 할당할 수 없다.
  // 오류 발생!!
  someVariable = myCar
  ```

- ✅ 타입캐스팅에 사용하던 `is`와 `as` 연산자를 사용하면 대상이 프로토콜을 준수하는지 확인할 수 있고, 특정 프로토콜로 캐스팅할 수도 있다. (방법은 [Chapter 19. 타입캐스팅](https://github.com/kybeen/Swift-Study/blob/main/Chapter19/Chapter19.md)과 동일)
  - `is` : 해당 인스턴스가 특정 프로토콜을 준수하는지 확인
  - `as?` : 다른 프로토콜로 다운캐스팅을 시도
  - `as!` : 다른 프로토콜로 강제 다운캐스팅 시도
  ``` Swift
  // [ 프로토콜 확인 및 캐스팅 ]
  
  print(rei is Named)     // true
  print(rei is Aged)      // true
  
  print(myCar is Named)   // true
  print(myCar is Aged)    // false
  
  if let castedInstance: Named = rei as? Named {
      print("\(castedInstance.name) is Named") // rei is Named
  }
  
  if let castedInstance: Aged = rei as? Aged {
      print("\(castedInstance) is Aged 👉 \(castedInstance.age)살임")   // Person(name: "rei", age: 99) is Aged 👉 99살임
  }
  
  if let castedInstance: Named = myCar as? Named {
      print("\(castedInstance) is Named")     // __lldb_expr_37.Car is Named
  }
  
  if let castedInstance: Aged = myCar as? Aged {
      print("\(castedInstance) is Aged")      // 출력 없음...캐스팅 실패
  }
  ```
---

## 프로토콜의 선택적 요구
- 프로토콜의 요구사항 중 일부를 `선택적 요구사항`으로 지정할 수 있다.
- **✅ 선택적 요구사항을 정의하고 싶은 프로토콜은 `@objc` 속성이 부여된 프로토콜이어야 함**
  - `@objc` 속성은 해당 프로토콜을 Objective-C 코드에서 사용할 수 있도록 만드는 역할을 한다. 하지만 **Objective-C 코드 공유 여부와 상관 없이 선택적 요구사항을 정의하려면 `@objc` 속성을 부여해야만 한다.**
- `@objc` 속성이 부여되는 프로토콜은 `Objective-C 클래스를 상속받은 클래스`에서만 채택할 수 있다. (열거형 구조체 등에서는 불가)
  > 👉 `@objc` 속성을 사용하려면 `Foundation` 프레임워크 모듈을 임포트해야 한다.

- `선택적 요구`를 하면 프로토콜을 준수하는 타입에 해당 요구사항을 필수로 구현할 필요가 없어진다.
  - ✅ 선택적 요구사항은 요구사항 정의 앞에 `optional` 식별자를 붙여준다.
  - 💡메서드나 프로퍼티를 선택적 요구사항으로 정의하면 그 요구사항의 타입은 자동으로 `옵셔널`이 된다.
    - ex) `(Int) -> String` 타입의 메서드 👉 `((Int) -> String)?` **(리턴 타입이 아니라 `함수 자체의 타입`이 옵셔널이 되는 것임!!)**
  - 선택적 요구사항은 그 프로토콜을 준수하는 타입에 구현되어 있지 않을 수 있기 때문에 `옵셔널 체이닝`을 통해 호출할 수 있다.
  ``` Swift
  // [ 프로토콜의 선택적 요구 ]
  
  import Foundation
  
  @objc protocol Movable {
      func walk()
      @objc optional func fly()
  }
  
  // 걷기만 할 수 있는 호랑이
  // @objc 속성의 프로토콜을 사용하기 위해 Objective-C의 클래스인 NSObject를 상속
  class Tiger: NSObject, Movable {
      func walk() {
          print("Tiger walks")
      }
  }
  
  // 걷고 날 수 있는 새
  class Bird: NSObject, Movable {
      func walk() {
          print("Bird walks")
      }
      
      func fly() {
          print("Bird flies")
      }
  }
  
  let tiger: Tiger = Tiger()
  let bird: Bird = Bird()
  
  tiger.walk()    // Tiger walks
  //tiger.fly?() // Tiger의 인스턴스 구현 시에 fly() 메서드가 구현되어 있지 않은 것을 확인할 수 있기 때문에 오류 (사용할 수 x)
  bird.walk()     // Bird walks
  bird.fly()      // Bird flies
  
  var movableInstance: Movable = tiger
  
  // Movable 프로토콜 변수에 할당되었을 때는 인스턴스의 타입에 실제로 fly() 메서드가 구현되어 있는지 알 수 없으므로
  // 옵셔널 체인을 통해 메서드 호출 시도
  movableInstance.fly?()  // 응답 없음
  
  movableInstance = bird
  movableInstance.fly?()  // Bird fliss
  ```
---

## 프로토콜 변수와 상수
- 프로토콜 이름을 타입으로 갖는 `변수/상수`에는 `그 프로토콜을 준수하는 타입의 어떤 인스턴스라도` 할당할 수 있다.
  - 프로토콜 이름만으로 자기 스스로 인스턴스를 생성하고 초기화할 수는 없다.

    ``` Swift
    /// 좀만 위로 올려보면 있는 *[📌이니셜라이저 요구 - 실패 가능한 이니셜라이저]* 설명 부분의 예시 코드에서 정의한 프로토콜, 클래스를 사용
    protocol Named {
        var name: String { get }
        
        init?(name: String) // 실패 가능한 이니셜라이저 요구
    }


    struct Animal: Named {
        var name: String
        
        // 실패 가능한 이니셜라이저 (옵셔널이 아닌 인스턴스를 반환하는)
        init!(name: String) {
            self.name = name
        }
    }

    struct Pet: Named {
        var name: String
        
        // 실패하지 않는 이니셜라이저
        init(name: String) {
            self.name = name
        }
    }

    class Person: Named {
        var name: String
        
        // 실패하지 않는 요구 이니셜라이저
        required init(name: String) {
            self.name = name
        }
    }

    class School: Named {
        var name: String
        
        // 실패 가능한 요구 이니셜라이저
        required init?(name: String) {
            self.name = name
        }
    }
    ```

    ``` Swift
    // [ 프로토콜 타입 변수 ]
    var someNamed: Named = Animal(name: "Animal")
    someNamed = Pet(name: "Pet")
    someNamed = Person(name: "Person")
    someNamed = School(name: "School")!
    ```
---

## 위임(Delegation)을 위한 프로토콜
- `위임(Delegation)`은 클래스나 구조체가 자신의 책임이나 임무를 다른 타입의 인스턴스에게 위임하는 `디자인 패턴`
  - 책무를 위임하기 위해 정의한 프로토콜을 준수하는 타입은 자신에게 위임될 일정 책무를 할 수 있다는 것을 보장하기 때문에 다른 인스턴스에게 자신이 해야할 일을 맏길 수 있다.
  - 위임은 `사용자의 특정 행동에 반응`하거나, `비동기 처리`에 많이 사용한다.
- `위임 패턴(Delegate Pattern)`은 애플의 프레임워크에서 사용하는 주요 패턴 중 하나.
  - ex) `UITableView` 타입의 인스턴스가 해야 하는 일을 위임받아 처리하는 인스턴스는 👉 `UITableViewDelegate` 프로토콜을 준수해야 한다.