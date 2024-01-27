# **Chapter 29. 메모리 안전**
- 스위프트는 안전을 중요시하는 언어이기 때문에 컴파일러가 코드에서 위험을 줄일 수 있도록 많은 장치를 두었다.
- 변수를 사용하기 전에 초기화를 강제하고, 해제된 메모리에 접근할 수 없도록 설계하며 메모리를 안전하게 접근할 수 있도록 되어 있다.
- 스위프트 컴파일러는 메모리 접근 충돌이 생길만한 코드를 미연에 알려준다.


## 메모리 접근 충돌의 이해
- `메모리 접근 충돌`은 서로 다른 코드에서 `동시에 같은 위치의 메모리에 접근할 때` 발생한다.
``` Swift
// [ 코드를 통해 메모리에 접근하는 유형 ]

// one이 저장될 메모리 위치에 쓰기 접근
var one: Int = 1

// one이 저장된 메모리 위치에 읽기 접근
print("숫자 출력 : \(one)")
```

### 📌 `메모리 접근의 특성`
- **💡 메모리 접근 충돌을 일으키는 메모리 접근의 3 가지 특성**
  - **✅ 최소한 한 곳에서 `쓰기` 접근한다.**
  - **✅ `같은 메모리 위치`에 접근한다.**
  - **✅ `접근 타이밍`이 겹친다.**
  > 위의 3 가지 조건에 모두 해당하는 메모리 접근이 `두 군데 이상의 코드에서 동시에` 일어나면 `메모리 접근 충돌`이 발생

- `단일 스레드` 환경에서는 대부분의 메모리 접근이 순간적 접근이고 동시에 다른 코드에서 접근할 일이 없다.
    ``` Swift
    // [ 순차적, 순간적 메모리 접근 ]

    func oneMore(than number: Int) -> Int {
        return number + 1
    }

    var myNumber: Int = 1
    myNumber = oneMore(than: myNumber)
    print(myNumber)
    // 2
    ```

- 💡 **반면에 `장기적 메모리 접근` 방식으로 메모리 접근 중일 때는 `해당 메모리 접근이 끝나기 전에 다른 코드에서 메모리에 접근할 가능성`이 있다.**
  - 👉 접근 타이밍이 겹치게 되는 대표적 상황은 함수나 메서드에서 `inout`을 사용한 입출력 매개변수를 사용하는 경우나 구조체에서 `mutating` 키워드를 사용하는 가변 메서드를 사용하는 경우이다.
- 메모리의 같은 위치에 접근하는 여러 접근의 타이밍이 겹친다고 해서 무조건 메모리 접근 충돌이 발생하는 것은 아니지만 대체로 가능성이 매우 크다.
- 메모리 접근 충돌을 코드에서 정적으로 예측할 수 있는 경우 컴파일러에서 오류로 취급하여 컴파일하지 않는다.

  > 💡 특정 변수나 상수의 메모리 주소를 알고 싶을 경우 아래 코드 참고
  ``` Swift
  // 값 타입의 경우
  var number: Int = 100
  print(Unmanaged<AnyObject>.fromOpaque(&number).toOpaque())
  
  // 참조 타입의 경우
  var object: SomeClass = SomeClass()
  print(Unmanaged<AnyObject>.passUnretained(object).toOpaque())
  ```
---


## 입출력 매개변수에서의 메모리 접근 충돌
- **`입출력 매개변수를 갖는 함수`는 동작 중 모두 `장기적 메모리 접근`을 한다.**
  - 👉 즉, 함수의 실행과 동시에 입출력 매개변수의 쓰기 접근이 시작되고 함수가 종료될 때까지 쓰기 접근을 유지한다. 쓰기 접근은 함수가 종료될 때 종료된다.
  - 👉 입출력 매개변수를 통한 장기적 메모리 접근 중에는 `매개변수로 전달하는 변수`는 `다른 접근이 제한`된다.
  ``` Swift
  // [ 입출력 매개변수에서의 메모리 접근 충돌 ]

  var step: Int = 1
  
  func increment(_ number: inout Int) {
      number += step
  }
  
  /*
   👉 step 변수는 increment(_:) 함수의 입출력 매개변수로 전달되었는데
      함수 내부에서 같은 메모리 공간에 읽기 접근을 하려고 시도하기 때문에 메모리 접근 충돌이 발생한다.
   */
  increment(&step)    // ❌ 오류 발생!!
  ```

  - 이런 경우 `새로운 변수를 생성`해서 해결할 수 있다.
    ``` Swift
    // [ 입출력 매개변수에서의 메모리 접근 충돌 ]

    var step: Int = 1
    var copyOfStep: Int = step

    func increment(_ number: inout Int) {
        number += copyOfStep
    }

    print(step, copyOfStep) // 1 1
    increment(&step)
    print(step, copyOfStep) // 2 1
    ```

- `2개 이상의 입출력 매개변수로 같은 변수를 전달하는 상황`에서도 `메모리 접근 충돌`이 발생할 수 있다.
    ``` Swift
    // [ 복수의 입출력 매개변수로 하나의 변수를 전달하여 메모리 접근 충돌 ]

    func balance(_ x: inout Int, _ y: inout Int) {
        let sum = x + y
        x = sum / 2
        y = sum - x
    }
    var playerOneScore: Int = 42
    var playerTwoScore: Int = 30
    balance(&playerOneScore, &playerTwoScore)   // 문제 없음
    balance(&playerOneScore, &playerOneScore)   // ❌ 오류 발생!!
    // 👉 playerOneScore라는 변수의 메모리 위치를 함수가 실행되는 동안 동시에 장기적 메모리 접근을 시도하기 때문에 문제가 발생한다.
    // 👉 이 경우에는 컴파일러에서 미리 컴파일 오류로 알려준다.
    ```
---


## 메서드 내부에서 self 접근의 충돌
- `구조체의 가변 메서드`는 메서드 실행 중에 `self`에 쓰기 접근을 하기 때문에 `메서드의 입출력 매개변수로 전달받은 메모리 위치`와 `자기 자신(self)에 해당하는 인스턴스의 메모리 위치가` 같을 경우 `메모리 접근 충돌`이 발생할 수 있다.
``` Swift
// [ 게임 캐릭터를 정의한 GamePlayer 구조체 ]

struct GamePlayer {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth() {
        // 👉 실행 중 인스턴스 자신인 self에 장기적으로 쓰기 접근을 한다.
        // 👉 restoreHealth() 메서드 내부의 코드 중 인스턴스의 다른 프로퍼티를 동시에 접근하는 코드가 없기 때문에 메모리 접근 충돌이 발생하지 않음
        self.health = GamePlayer.maxHealth
    }
    
    mutating func shareHealth(with teammate: inout GamePlayer) {
        // 👉 다른 캐릭터의 인스턴스를 입출력 매개변수로 받기 때문에 메모리 접근 충돌이 발생할 여지가 있다.
        balance(&teammate.health, &health)
    }
}

var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
var maria: GamePlayer = GamePlayer(name: "Maria", health: 5, energy: 10)

// [ 메모리 접근 충돌이 없는 shareHealth(with:) 메서드 호출 ]
/*
 👉 teammate 입출력 매개변수로 전달된 maria는 shareHealth(with:) 메서드가 실행되는 중에 쓰기 접근을 하고,
    가변 메서드를 실행해야 하는 oscar도 쓰기 접근을 한다. 하지만 서로 다른 메모리 위치에 있기 때문에 접근 충돌이 발생하지 x
 */
oscar.shareHealth(with: &maria)

// [ 메모리 접근 충돌이 발생하는 shareHealth(with:) 메서드 호출 ]
/*
 👉 teammate 입출력 매개변수로 전달받은 메모리 위치와 oscar 인스턴스의 메모리 위치는 같은 곳이기 때문에
    동시에 쓰기 접근을 하면 메모리 접근 충돌이 발생한다.
 */
oscar.shareHealth(with: &oscar) // ❌ 오류 발생!!
```
---


## 프로퍼티 접근 중 충돌
- **구조체, 열거형, 튜플 등은 `값 타입`이다. 값 타입에서 `자신의 인스턴스 내부 프로퍼티를 변경`한다는 것은 `자신 스스로의 값을 변경`한다는 의미로 볼 수 있다.**
  - 👉 프로퍼티에 읽고 쓰기를 위한 접근을 하는 것은 인스턴스 자신 전체에 대한 읽고 쓰기 접근 권한이 필요하다는 뜻으로도 생각할 수 있다.

- 📌 `예시 코드`
  - `balance(_:_:)` 함수의 두 매개변수는 모두 입출력 매개변수이므로 함수가 실행 중이면 두 매개변수 모두 쓰기 접근을 한다.
  - `oscar의 프로퍼티인 health`를 매개변수로 전달하면 `oscar 인스턴스 자체의 값이 변경될 것을 의미`하므로 `oscar 인스턴스 자체`에 쓰기 접근을 해야 한다.
  - 두 번째 입출력 매개변수로 전달한 oscar의 energy 프로퍼티도 마찬가지로 oscar 인스턴스의 쓰기 접근을 해야 하므로 `두 접근이 충돌할 수밖에 없다.`
  ``` Swift
  // [ 프로퍼티 접근 중 메모리 접근 충돌 ]

  balance(&oscar.health, &oscar.energy)
  ```

- 위의 📌 `예시 코드`는 `oscar`가 `전역변수일 때`의 이야기이기 때문에 유사한 상황이 발생할 일은 많지 않다.
  - 💡 만약 `oscar`가 **`지역변수`** 라면
    - 👉 아래 코드에서의 `oscar`는 `someFunction() 함수 안에서만 사용하는 변수`기 때문에 **`다른 위치의 코드에서 접근할 일이 없다.`**
    - 👉 함수의 두 입출력 매개변수로 oscar의 두 프로퍼티를 전달했음에도 불구하고 `지역변수로 쓰이던 oscar는 현재 함수 안에서 순차적으로 실행될 코드 외의 영역에서 접근할 코드가 없기 때문에` **`다른 코드에서 oscar의 메모리 위치에 접근하여 문제가 발생할 여지가 없다.`**
    - 👉 이런 상황에서는 컴파일러는 `오류로 취급하지 않는다.`
    ``` Swift
    // 전역변수와 지역변수의 메모리 접근의 차이

    func someFunction() {
        var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
        // 👉 balance(_:_:) 함수 안에서만 oscar의 메모리 위치에 접근하기 때문에 문제될 것이 없다.
        balance(&oscar.health, &oscar.energy)
    }
    ```
  ---

- 메모리 안전 때문에 `구조체의 프로퍼티 메모리에 접근하는 타이밍이 겹치는 것을 무조건 제한해야 하는 것은 아님.`
- 💡 **다음의 3개 조건을 충족하면 구조체의 프로퍼티 메모리에 동시게 접근하더라도 안전이 보장된다.**
  - 👉 연산 프로퍼티나 클래스 프로퍼티가 아닌 `인스턴스의 저장 프로퍼티에만 접근`
  - 👉 전역 변수가 아닌 `지역 변수`일 때
  - 👉 클로저에 의해 `획득(Captured) 되지 않았거나`, `비탈출 클로저에 의해서만 획득` 되었을 때
- `위의 세 조건을 충족하지 않는 경우`에는 컴파일러가 안전을 담보할 수 없기 때문에 `접근을 제한하도록 오류로 취급`한다.