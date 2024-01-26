# **Chapter 28. 오류처리**


## 오류처리란
- `오류처리(Error Handling)`는 프로그램이 오류를 일으켰을 때 이를 감지하고 회복시키는 일련의 과정


## 오류의 표현
- ✅ **스위프트에서 오류는 `Error`라는 프로토콜을 준수하는 타입의 값을 통해 표현된다.**
  - `Error` 프로토콜은 요구사항이 없는 `빈 프로토콜`이지만, `오류를 표현하기 위한 타입(주로 열거형)`은 이 프로토콜을 채택한다.
- 아래와 같이 오류의 종류를 미리 예상하여 열거형응로 표현해준다.
``` Swift
// [ 자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형 ]

enum VendingMachineError: Error {
    case invalidSelection                       // 유효하지 않은 선택
    case insufficientFunds(coinsNeeded: Int)    // 자금 부족 - 필요한 동전 개수
    case outOfStock                             // 품절
}
```

- ✅ 정의한 오류 때문에 다음에 행할 동작이 정상적으로 진행되지 않을 때라면 **`throw` 구문을 사용하여 `오류를 던져(Throw Error)`주면 된다.**
  ``` Swift
  // 예시
  throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
  ```
---


## 오류 포착 및 처리
- 오류를 던지고 나서는 던져진 오류를 처리하기 위한 코드도 작성해 주어야 한다.
  - 해당 코드를 통해 오류 다음에 어떤 동작을 하게 할 것인지 결정하도록 유도해주어야 한다.

- 💡 `스위프트에서 오류를 처리하기 위한 4가지 방법`
  - 함수에서 발생한 오류를 `해당 함수를 호출한 코드에 알리는` 방법
  - `do-catch` 구문을 이용하여 오류를 처리하는 방법
  - `옵셔널` 값으로 오류를 처리하는 방법
  - `오류가 발생하지 않을 것`이라고 확신하는 방법

  ---

### 📌 `함수에서 발생한 오류 알리기`
- ✅ `try` 키워드를 사용하여 던져진 오류를 받을 수 있다.
- ✅ 함수, 메서드, 이니셜라이저의 매개변수 뒤에 `throws` 키워드를 사용하면 오류를 던질 수 있다.
  - 이런 함수는 호출했을 때, 동작 도중 오류가 발생하면 자신을 호출한 코드에 오류를 던져서 오류를 알릴 수 있다.
  ``` Swift
  // 예시
  func canThrowErrors() throws -> String
  ```
  > 💡 `throws` 함수나 메서드는 같은 이름의 `throws`가 명시되지 않는 함수나 메서드와 구분된다.
  > 
  > 💡 `throws`를 포함한 함수, 메서드, 이니셜라이저는 일반 함수, 메서드, 이니셜라이저로 재정의할 수 없다. (반대로 일반 → `throws`로 재정의하는 것은 가능)

- **👉 오류를 던질 수 있는 함수, 메서드, 이니셜라이저를 호출하는 코드는 반드시 `오류를 처리할 수 있는 구문`을 작성해주어야 한다.**

    ``` Swift
    // [ 자판기 동작 도중 발생한 오류 던지기 ]

    struct Item {
        var price: Int
        var count: Int
    }

    class VendingMachine {
        var inventory = [
            "Candy Bar": Item(price: 12, count: 7),
            "Chips": Item(price: 10, count: 4),
            "Biscuit": Item(price: 7, count: 11)
        ]
        
        var coinsDeposited = 0
        
        func dispense(snack: String) {
            print("\(snack) 제공")
        }
        
        // throws 👉 오류를 던질 수 있는 메서드
        func vend(itemNamed name: String) throws {
            // 👉 오류 발생 시 흐름을 제어하기 위해 guard를 통한 빠른 종료 구문을 사용
            
            // 유효한 아이템을 선택했는지 확인
            guard let item = self.inventory[name] else {
                // 👉 특정 조건이 충족되지 않는다면 throw 키워드를 통해 오류를 던져서 오류가 발생했다는 것을 알림
                throw VendingMachineError.invalidSelection
            }
            
            // 선택한 아이템이 품절인지 확인
            guard item.count > 0 else {
                throw VendingMachineError.outOfStock
            }
            
            // 투입한 동전이 아이템을 살 수 있는 가격인지 확인
            guard item.price <= self.coinsDeposited else {
                throw VendingMachineError.insufficientFunds(
                    coinsNeeded: item.price - self.coinsDeposited)
            }
            
            // 남은 동전 계산
            self.coinsDeposited -= item.price
            
            // 아이템 개수 수정
            var newItem = item
            newItem.count - 1
            self.inventory[name] = newItem
            
            self.dispense(snack: name)
        }
    }

    let favoriteSnacks = [
        "yagom": "Chips",
        "jinsung": "Biscuit",
        "heejin": "Chocolate"
    ]

    // 👉 vend(itemNamed:) 메서드가 오류를 던질 가능성이 있으므로 vend(itemNamed:) 메서드를 호출하는 함수 또한 오류를 던질 수 있어야 한다.
    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }

    struct PurchasedSnack {
        let name: String
        init(name: String, vendingMachine: VendingMachine) throws {
            try vendingMachine.vend(itemNamed: name)
            self.name = name
        }
    }

    let machine: VendingMachine = VendingMachine()
    machine.coinsDeposited = 30

    var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)
    // Biscuit 제공

    print(purchase.name)    // Biscuit

    for (person, favoriteSnack) in favoriteSnacks {
        print(person, favoriteSnack)
        /*
        👉 오류가 발생할 수 있는 메서드와 함수를 호출하면서도 try로 시도만 할 뿐 오류가 발생했을 때 처리할 수 있는 코드는 작성되어 있지 않기 때문에
        오류 발생 후 다음 코드는 정상적으로 동작하지 않는다.
        */
        try buyFavoriteSnack(person: person, vendingMachine: machine)
    }
    // jinsung Biscuit
    // Biscuit 제공
    // yagom Chips
    // Chips 제공
    // heejin Chocolate
    // 오류 발생!!
    ```
  ---


### 📌 `do-catch 구문을 이용하여 오류처리`
- 함수, 메서드, 이니셜라이저 등에서 오류를 던져주면 오류 발생을 전달받은 코드 블록은 `do-catch` 구문을 사용하여 오류를 처리해주어야 한다.
  - **✅ `do` 절 내부의 코드에서 오류를 던지면 `catch` 절에서 오류를 전달받아 적절하게 처리해준다.**
  - `catch` 절에서는 `catch` 키워드 뒤에 `처리할 오류의 종류`를 써준다.
  - **👉 만약 `catch` 뒤에 오류의 종류를 명시하지 않고 코드 블록을 생성하면 블록 내부에 암시적으로 `error`라는 이름의 지역 상수가 오류 내용으로 들어온다.**
    ``` Swift
    do {
        try 오류 발생 가능코드
        오류가 발생하지 않으면 실행할 코드
    } catch 오류 패턴 1 {
        처리 코드
    } catch 오류 패턴 2 where 추가 조건 {
        처리 코드
    }
    ```

- 던져진 오류를 `do-catch` 구문을 사용하여 처리하는 함수를 별도로 만들어줌으로써 오류를 받아서 다시 던지던 함수들이 더 이상 다른 곳으로 오류를 던지지 않아도 되는 형태가 되었다.
- 또한 오류를 적절히 처리해준 덕분에 코드가 중간에 중단되지 않고 끝까지 정상 동작한다.
  ``` Swift
  // [ do-catch 구문을 사용하여 던져진 오류를 처리 ]
  
  func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) {
      let snackName = favoriteSnacks[person] ?? "Candy Bar"
      tryingVend(itemNamed: snackName, vendingMachine: vendingMachine)
  }
  
  struct PurchasedSnack {
      let name: String
      init(name: String, vendingMachine: VendingMachine) {
          tryingVend(itemNamed: name, vendingMachine: vendingMachine)
          self.name = name
      }
  }
  
  func tryingVend(itemNamed: String, vendingMachine: VendingMachine) {
      do {
          try vendingMachine.vend(itemNamed: itemNamed)
      } catch VendingMachineError.invalidSelection {
          print("유효하지 않은 선택")
      } catch VendingMachineError.outOfStock {
          print("품절")
      } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
          print("자금 부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
      } catch {
          print("그 외 오류 발생 : ", error)
      }
  }
  
  let machine: VendingMachine = VendingMachine()
  machine.coinsDeposited = 20
  
  var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)
  // Biscuit 제공
  print(purchase.name)    // Biscuit
  
  purchase = PurchasedSnack(name: "Ice Cream", vendingMachine: machine)
  // 유효하지 않은 선택
  print(purchase.name)    // Ice Cream
  
  for (person, favoriteSnack) in favoriteSnacks {
      print(person, favoriteSnack)
      try buyFavoriteSnack(person: person, vendingMachine: machine)
  }
  // heejin Chocolate
  // 유효하지 않은 선택
  // jinsung Biscuit
  // Biscuit 제공
  // yagom Chips
  // 자금 부족 - 동전 4개를 추가로 지급해주세요.
  ```
  ---


### 📌 `옵셔널 값으로 오류처리`
- `try?`를 사용하여 `옵셔널` 값으로 변환하여 오류를 처리할 수도 있다.
- ✅ **`try?` 표현을 통해 동작하던 코드가 오류를 던지면 그 코드의 반환값은 `nil`이 된다.**
``` Swift
// [ 옵셔널 값으로 오류를 처리 ]

func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    return 100
}

// 📌 someThrowingFunction(shouldThrowError:)의 반환 타입이 Int라도 try? 표현을 사용하면 반환 타입이 옵셔널이 된다.
let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)    // nil

let y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)    // Optional(100)
```

- 기존에 반환 타입으로 옵셔널을 활용하던 방법과 결합하여 사용
    ``` Swift
    // [ 옵셔널 값으로 오류를 처리하는 방법과 기존 옵셔널 반환 타입과의 결합 ]

    // 👉 데이터를 디스크에서 가져오지 못하면 서버에서 가져오는 것을 시도해보고 그조차 없으면 nil을 반환
    func fetchData() -> Data? {
        if let data = try? fetchDataFromDisk() {
            return data
        }
        if let data = try? fetchDataFromServer() {
            return data
        }
        return nil
    }
    ```
  ---


### 📌 `오류가 발생하지 않을 것이라고 확신하는 방법`
- 오류를 던질 수 있는 함수 등을 호출할 때 오류가 절대로 발생하지 않을 것이라고 확신할 수 있는 상황이라면 오류가 발생하지 않을 것이라는 전제 하에 `try!` 표현을 사용할 수 있다.
  - 🚧 실제 오류가 발생하면 런타임 오류가 발생하므로 되도록이면 사용하지는 말자
  ``` Swift
  // [ 오류가 발생하지 않음을 확신하여 오류처리 ]
  
  func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
      if shouldThrowError {
          enum SomeError: Error {
              case justSomeError
          }
          
          throw SomeError.justSomeError
      }
      
      return 100
  }
  
  let y: Int = try! someThrowingFunction(shouldThrowError: false)
  print(y)    // 100
  
  let x: Int = try! someThrowingFunction(shouldThrowError: true)  // 런타임 오류!!
  ```
  ---


### 📌 `다시 던지기`
- 함수나 메서드는 `rethrows` 키워드를 사용하여 자신의 `매개변수로 전달받은 함수가 오류를 던진다는 것을` 나타낼 수 있다.
- ✅ **`rethrows` 키워드를 사용하여 `다시 던지기(Rethrowing)`가 가능하게 하려면 `최소 하나 이상의 오류 발생 가능한 함수를 매개변수로 전달`받아야 한다.**
- 👉 다시 던지기 함수/메서드는 자신 내부에 직접적으로 `throw` 구문을 사용할 수 없다. (스스로 오류를 던지지 못한다.)
  - 👉 `catch` 절 내부에서는 `throw` 구문을 작성할 수 있다.
  - 다시 던지기 함수나 메서드가 오류를 던지는 함수를 `do-catch` 구문 내부에서 호출하고, `catch` 절 내부에서 다른 오류를 던짐으로써 오류를 던지는 함수에서 발생한 오류를 제어할 수 있다.
  ``` Swift
  // [ 다시 던지기 함수의 오류 던지기 ]
  
  // 오류를 던지는 함수
  func someThrowingFunction() throws {
      enum SomeError: Error {
          case justSomeError
      }
      
      throw SomeError.justSomeError
  }
  
  // 다시 던지기 함수
  func someFunction(callback: () throws -> Void) rethrows {
      enum AnotherError: Error {
          case justAnotherError
      }
      
      /*
       다시 던지기 함수나 메서드가 오류를 던지는 함수를 do-catch 구문 내부에서 호출하고
       catch 절 내부에서 다른 오류를 던짐으로써 오류를 던지는 함수에서 발생한 오류를 제어할 수 있다.
       */
      do {
          // 매개변수로 전달한 오류 던지기 함수이므로 catch 절에서 제어할 수 있다.
          try callback()
      } catch {
          throw AnotherError.justAnotherError
      }
      
      do {
          // 매개변수로 전달한 오류 던지기 함수가 아니므로 catch 절에서 제어할 수 없다.
          try someThrowingFunction()
      } catch {
          // ❌ 오류 발생!
          throw AnotherError.justAnotherError
      }
      
      // ❌ catch 절 외부에서 단독으로 오류를 던질 수는 없다. 오류 발생 !!
      throw AnotherError.justAnotherError
  }
  ```

- 👉 `부모클래스`의 `다시 던지기 메서드(rethrows 메서드)`는 `자식클래스`에서 `던지기 메서드(throws 메서드)`로 재정의할 수 없다.
  - 그러나 부모클래스의 `던지기 메서드`는 자식클래스에서 `다시 던지기 메서드`로 재정의할 수 있다.
- 👉 만약 `프로토콜 요구사항` 중에 `다시 던지기 메서드`가 있다면, `던지기 메서드`를 구현한다고 해서 `요구사항을 충족시킬 수는 없다.`
  - 그러나 프로토콜 요구사항 중에 `던지기 메서드`가 있다면, `다시 던지기 메서드`를 구현해서 `요구사항을 충족시킬 수 있다.`

  > 즉, *`프로토콜 구현﹒클래스 상속`* 시에
  > - **`rethrows → throws`는 🙅‍♂️ (불가능)**
  > - **`throws → rethrows`는 🙆‍♂️ (가능)**
  >
  > 라고 이해하면 됨
  ``` Swift
  // [ 프로토콜과 상속에서 던지기 함수와 다시 던지기 함수 ]
  
  protocol SomeProtocol {
      func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
      func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
  }
  
  class SomeClass: SomeProtocol {
      func someThrowingFunction(callback: () throws -> Void) throws { }
      func someFunction(callback: () throws -> Void) rethrows { }
      
      // 던지기 메서드는 다시 던지기 메서드를 요구하는 프로토콜을 충족할 수 없다.
      // ❌ 오류 발생!!
      func someRethrowingFunctionFromProtocol(callback: () throws -> Void) throws {
      }
      
      // 다시 던지기 메서드는 던지기 메서드를 요구하는 프로토콜의 요구사항에 부합한다.
      func someThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows {
      }
      
  }
  
  class SomeChildClass: SomeClass {
      // 부모클래스의 던지기 메서드는 자식클래스에서 다시 던지기 메서드로 재정의할 수 있다.
      override func someThrowingFunction(callback: () throws -> Void) rethrows { }
      
      // 부모클래스의 다시 던지기 메서드는 자식클래스에서 던지기 메서드로 재정의할 수 없다.
      // ❌ 오류 발생!!
      override func someFunction(callback: () throws -> Void) throws { }
  }
  ```
  ---


### 📌 `후처리 defer`
- ✅ `defer` 구문을 사용하여 `현재 코드 블록을 나가기 전에 꼭 실행해야 하는 코드`를 작성할 수 있다.
- `defer` 구문은 코드가 블록을 어떤 식으로 빠져나가든 간에 꼭 실행해야 하는 마무리 작업을 할 수 있도록 도와준다.
  - 👉 오류 발생으로 코드 블록을 빠져나가는 것이든, 정상적으로 코드 블록을 빠져나가는 것이든 간에 **`defer` 구문은 코드가 블록을 빠져나가기 전에 무조건 실행되는 것을 보장한다.**

  > 💡 `defer` 구문은 오류처리 상황뿐만 아니라, 함수, 메서드, 반복문, 조건문 등등 보통의 코드 블록 어디에서든 사용할 수 있다.
  
  ``` Swift
  for i in 0...2 {
      defer {
          print("A", terminator: " ")
      }
      print(i, terminator: " ")
      
      if i % 2 == 0 {
          defer {
              print("", terminator: "\n")
          }
          
          print("It's even", terminator: " ")
      }
  }
  // 0 It's even
  // A 1 A 2 It's even
  // A
  ```

- 📌 `defer 구문 활용 예시`
  ``` Swift
  // [ 파일쓰기 예제에서 defer 구문 활용 ]
  
  /*
   👉 함수 내에서 파일을 열어 사용하다가 오류가 발생하여 코드가 블록을 빠져나가더라도
      파일을 정상적으로 닫아 메모리에서 해제할 수 있도록 해준다.
   */
  func writeData() {
      let file = openFile()
      
      // 함수 코드 블록을 빠져나가기 직전 무조건 실행되어 파일을 잊지 않고 닫아준다.
      defer {
          closeFile(file)
      }
      
      if ... {
          return
      }
      
      if ... {
          return
      }
      
      // 처리 끝
  }
  ```
  ---
  
- 👉 `defer` 구문은 현재 코드 범위를 벗어나기 전까지 실행을 미루고(defer) 있다가 `프로그램 실행 흐름이 코드 범위를 벗어나기 직전` 실행된다.
- 👉 `defer` 구문 내부에는 `break`, `return` 등과 같이 `구문을 빠져나갈 수 있는 코드` 또는 `오류를 던지는 코드`는 작성하면 안된다.
- 👉 `여러 개의 defer 구문`이 하나의 범위(블록) 내부에 속해 있다면 맨 마지막에 작성된 구문부터 `역순`으로 실행된다.
- 👉 `오류를 던지기 직전까지 작성된` defer 구문까지만 실행된다.
    ``` Swift
    // [ defer 구문의 실행 순서 ]

    func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
        defer {
            print("First")
        }
        
        if shouldThrowError {
            enum SomeError: Error {
                case justSomeError
            }
            
            throw SomeError.justSomeError
        }
        
        defer {
            print("Second")
        }
        
        defer {
            print("Third")
        }
        
        return 100
    }

    try? someThrowingFunction(shouldThrowError: true)
    // First
    // 👉 오류를 던지기 직전까지 작성된 defer 구문까지만 실행된다.

    try? someThrowingFunction(shouldThrowError: false)
    // Third
    // Second
    // First
    ```

- ✅ 코드 블록 내부에 또 한 단계 하위의 블록을 만들고자 할 때 `catch` 절 없이 `do` 구문을 단독으로 사용할 수 있다.
  - 👉 이럴 때는 `하위 블록이 종료될 때` 그 내부의 `defer` 구문이 실행된다.
  ``` Swift
  // [ 복합적인 defer 구문의 실행 순서 ]
  func someFunction() {
      print("1")
      
      defer {
          print("2")
      }
      
      do {
          defer {
              print("3")
          }
          print("4")
      }
      
      defer {
          print("5")
      }
      
      print("6")
  }
  
  someFunction()
  // 1
  // 4
  // 3
  // 6
  // 5
  // 2
  ```