# **Chapter 9. 구조체와 클래스**
- 스위프트에서는 `구조체`와 `클래스`의 모습과 문법이 거의 흡사함
- 가장 큰 차이점은
  - `구조체`의 인스턴스는 `값 타입`
  - `클래스`의 인스턴스는 `참조 타입`
- 스위프트에서는 소스파일 하나에 여러 개의 구조체와 여러 개의 클래스를 정의하고 구현할 수 있다. (중첩 타입의 정의 및 선언도 가능)
---


## 구조체

### `구조체 정의`
``` Swift
// [ BasicInformation 구조체 정의 예시 ]

struct BasicInformation {
    var name: String
    var age: Int
}
```

### `구조체 인스턴스의 생성 및 초기화`
- 구조체 정의 후, `인스턴스를 생성하고 초기화`할 때는 기본적으로 생성되는 `멤버와이즈 이니셜라이저`를 사용한다.
  - 구조체에 기본 생성된 이니셜라이저의 매개변수는 구조체의 프로퍼티 이름으로 자동 지정된다.
- **💡 구조체를 상수 `let`으로 선언하면 인스턴스 내부의 프로퍼티 값을 변경할 수 없고, 변수 `var`로 선언하면 내부 프로퍼티가 `var`로 선언되었을 경우 값을 변경해줄 수 있다.**

``` Swift
// [ BasicInformation 구조체의 인스턴스 생성 및 사용 ]

// 프로퍼티 이름으로 자동 생성된 이니셜라이저를 사용하여 인스턴스 생성
var reiInfo: BasicInformation = BasicInformation(name: "rei", age: 25)
reiInfo.age = 100 // 변경 가능
reiInfo.name = "레이" // 변경 가능

let ybInfo: BasicInformation = BasicInformation(name: "yb", age: 25)
ybInfo.age = 100 // 변경 불가 - 오류
ybInfo.name = "영빈" // 변경 불가 - 오류
```
---

## 클래스

### `클래스 정의`
- 스위프트의 클래스는 부모클래스가 없더라도 상속 없이 단독으로 정의가 가능

``` Swift
// [ Person 클래스 정의 ]

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}
```

### `클래스 인스턴스의 생성과 초기화`
- **💡 구조체와 다르게 클래스의 인스턴스는 참조 타입이므로 인스턴스를 상수 `let`으로 선언해도 내부 프로퍼티 값을 변경할 수 있다.**

``` Swift
// [ Person 클래스의 인스턴스 생성 및 사용 ]

// Person 클래스의 프로퍼티는 기본값이 지정되어 있기 때문에 따로 초깃값을 전달해줄 필요X
var rei: Person = Person()
rei.height = 200
rei.weight = 100

let yb: Person = Person()
yb.height = 200
yb.weight = 100
```

### `클래스 인스턴스의 소멸`
- 클래스의 인스턴스는 참조 타입이기 때문에 더는 참조할 필요가 없을 때 **`메모리에서 해제(소멸)`** 된다.
  - 클래스 내부에 `deinit` 메서드를 구현해주면 소멸되기 직전 `deinit` 메서드가 호출됨 (`디이니셜라이저(Deinitializer)`)
  - 디이니셜라이저는 `클래스당 하나만 구현`할 수 있으며 `매개변수와 반환 값을 가질 수 없다.`
  - 보통 `deinit` 메서드에는 인스턴스가 메모리에서 해제되기 직전에 처리할 코드가 들어간다.
    - ex) 데이터 저장 등...
``` Swift
// [ Person 클래스의 인스턴스 생성 및 소멸 ]

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("Person 클래스의 인스턴스가 소멸됩니다.")
    }
}

var rei: Person? = Person()
rei = nil // Person 클래스의 인스턴스가 소멸됩니다.
```
---

## 구조체와 클래스의 차이
- **💡 구조체와 클래스의 같은 점**
  - 값을 저장하기 위해 프로퍼티를 정의할 수 있다.
  - 기능 실행을 위해 메서드를 정의할 수 있다.
  - 서브스크립트 문법을 통해 구조체 또는 클래스가 갖는 값에 접근하도록 서브스크립트를 정의할 수 있다.
  - 초기화될 때의 상태를 지정하기 위해 이니셜라이저를 정의할 수 있다.
  - 초기구현과 더불어 새로운 기능 추가를 위해 익스텐션을 통해 확장할 수 있다.
  - 특정 기능을 실행하기 위해 특정 프로토콜을 준수할 수 있다.

- **🚧 구조체와 클래스의 다른 점**
  - 구조체는 상속할 수 없다.
  - 타입캐스팅은 클래스의 인스턴스에만 허용된다.
  - 디이니셜라이저는 클래스의 인스턴스에서만 활용할 수 있다.
  - 참조 횟수 계산(Reference Counting)은 클래스의 인스턴스에만 적용된다.

### `값 타입과 참조 타입`
- 값 타입과 참조 타입의 가장 큰 차이는 **`'무엇이 전달되느냐'`** 임
  - `값 타입`의 값을 넘긴다면 **`전달될 값이 복사`** 되어 전달된다.
  - `참조 타입`의 값이 전달되면 값을 복사하지 않고 **`참조(주소)가 전달`** 된다.

- 참조는 C, C++ 등의 언어에서 사용되는 `포인터(Pointer)`와 매우 유사한 개념이지만, 스위프트에서 참조를 표현하기 위해 `*`를 사용하지는 않는다.

``` Swift
// [ 값 타입과 참조 타입의 차이 ]

struct BasicInformation {
    let name: String
    var age: Int
}

var reiInfo: BasicInformation = BasicInformation(name: "rei", age: 99)
reiInfo.age = 100

// reiInfo의 값을 복사하여 할당
var friendInfo: BasicInformation = reiInfo

print("rei's age: \(reiInfo.age)") // 100
print("friend's age: \(friendInfo.age)") // 100

friendInfo.age = 999

print("rei's age: \(reiInfo.age)") // 100 - 변동X
print("friend's age: \(friendInfo.age)") // 999 - reiInfo의 값을 복사해왔기 때문에 별개의 값을 갖는다.

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

var rei: Person = Person()
var friend: Person = rei

print("rei's height: \(rei.height)") // 0.0
print("friend's height: \(friend.height)") // 0.0

friend.height = 185.5
print("rei's height: \(rei.height)") // 185.5 - friend는 rei를 참조하기 때문에 값이 변동된다.
print("friend's height: \(friend.height)") // 185.5 - rei와 friend가 참조하는 곳이 같음을 알 수 있다.

func changeBasicInfo(_ info: BasicInformation) {
    var copiedInfo: BasicInformation = info
    copiedInfo.age = 1
}
func changePersonInfo(_ info: Person) {
    info.height = 155.3
}

// changeBasicInfo(_:)로 전달되는 전달인자는 값이 복사되어 전달되기 때문에 reiInfo의 값만 전달된다.
changeBasicInfo(reiInfo)
print("rei's age: \(reiInfo.age)") // 100

// changePersonInfo(_:)의 전달인자로 rei의 참조가 전달되었기 때문에 rei가 참조하는 값들에 변화가 생긴다.
changePersonInfo(rei)
print("rei's height: \(rei.height)") // 155.3
```

- `값 타입`의 데이터를 함수의 전달인자로 전달하면 `메모리에 전달인자를 위한 인스턴스가 새로 생성`된다.
- `참조 타입`의 데이터는 전달인자로 전달할 때 새로운 인스턴스가 아닌 `기존의 인스턴스 참조`를 전달한다.
- (함수의 전달인자 뿐만 아니라 새로운 변수에 할당될 때도 마찬가지)

- **💡 클래스의 인스턴스끼리 참조가 같은지 확인할 때는 `식별 연산자(Identity Operators`를 사용한다.**
    ``` Swift
    // [ 식별 연산자의 사용 ]

    var rei: Person = Person()
    let friend: Person = rei                // rei의 참조를 할당
    let anotherFriend: Person = Person()    // 새로운 인스턴스를 생성

    print(rei === friend)           // true
    print(rei === anotherFriend)    // false
    print(friend !== anotherFriend) // true
    ```
---

### `스위프트의 기본 데이터 타입은 모두 구조체이다.`
- 스위프트의 기본 데이터 타입들은(`Bool`, `Int`, `Array`, `Dictionary`, `Set` 등등...) `모두 구조체로 구현`되어 있다.
  - 👉 기본 데이터 타입은 모두 값 타입

    ``` Swift
    // [ 스위프트 String 타입의 정의 ]

    public struct String {
        // An empty 'String'.
        public init()
    }
    ```
---

## 구조체와 클래스 선택해서 사용하기
구조체와 클래스는 새로운 데이터 타입을 정의하고 기능을 추가한다는 점이 같다. 하지만 구조체 인스턴스는 값 타입이고, 클래스 인스턴스는 참조 타입이기 때문에 용도는 다르다.

프로젝트의 성격, 데이터의 활용도, 특정 타입을 구현할 때 등에 맞춰 구조체와 클래스 중 하나를 선택해서 사용해야 한다.

**💡 애플의 가이드라인에서 `다음 조건 중 하나 이상에 해당`한다면 `구조체`를 사용하는 것을 권장한다.**
- 연관된 간단한 값의 집합을 캡슐화하는 것만이 목적일 때
- 캡슐화한 값을 참조하는 것보다 복사하는 것이 합당할 때
- 구조체에 저장된 프로퍼티가 값 타입이며 참조하는 것보다 복사하는 것이 합당할 때
- 다른 타입으로부터 상속받거나 자신을 상속할 필요가 없을 때
---
- 이런 몇 가지 상황을 제외하고는 `대다수의 사용자 정의 데이터 타입`은 `클래스`로 구현할 일이 더 많다.