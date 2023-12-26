# **Chapter 10. 프로퍼티와 메서드**
- `프로퍼티`는 클래스, 구조체 또는 열거형 등에 `관련된 값`을 뜻한다.
- `메서드`는 특정 타입에 `관련된 함수`를 뜻한다.

## 프로퍼티
- `저장 프로퍼티(Stored Properties)` : 인스턴스의 변수 또는 상수. 구조체와 클래스에서만 사용할 수 있다.
- `연산 프로퍼티(Computed Properties)` : 특정 연산을 실행한 결괏값. 클래스, 구조체, 열거형에 쓰일 수 있다.
- `타입 프로퍼티(Type Properties)` : 특정 타입에 사용되는 프로퍼티
- `프로퍼티 감시자(Property Observers)` : 프로퍼티의 값이 변할 때 값의 변화에 따른 특정 작업을 실행
---

### `저장 프로퍼티`
- 클래스/구조체의 인스턴스와 연관된 값을 저장하는 가장 단순한 개념의 프로퍼티
- 저장 프로퍼티를 정의할 때 프로퍼티 기본값과 초깃값을 지정해줄 수 있다.

> 💡 `구조체`의 저장 프로퍼티가 옵셔널이 아니더라도, `구조체는 저장 프로퍼티를 모두 포함하는 이니셜라이저를 자동으로 생성`한다.

> 💡 반면 `클래스`의 저장 프로퍼티는 옵셔널이 아니라면 `프로퍼티 기본값을 지정`해주거나 `사용자 정의 이니셜라이저를 통해 반드시 초기화`해주어야 한다.

> 💡 `클래스 인스턴스의 상수 프로퍼티`는 `인스턴스가 초기화될 때` 한 번만 값을 할당할 수 있다.

``` Swift
// [ 저장 프로퍼티의 선언 및 인스턴스 생성 ]

// 좌표
struct CoordinatePoint {
    var x: Int      // 저장 프로퍼티
    var y: Int      // 저장 프로퍼티
}

// 구조체에는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있다.
let reiPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

// 사람의 위치 정보
class Position {
    var point: CoordinatePoint // 저장 프로퍼티(변수) - 위치(Point)는 변경될 수 있기 때문에 변수 저장 프로퍼티
    let name: String // 저장 프로퍼티(상수)
    
    // 프로퍼티 기본값을 지정해주지 않는다면 이니셜라이저를 따로 정의해주어야 한다.
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}

// 사용자 정의 이니셜라이저를 호출해서 프로퍼티 초깃값을 할당해 주어야 인스턴스 생성이 가능함
let reiPosition: Position = Position(name: "rei", currentPoint: reiPoint)
```

- 클래스의 저장 프로퍼티에 `초깃값을 지정`해주면 따로 사용자 정의 이니셜라이저를 구현해줄 필요가 없다.
    ``` Swift
    // [ 저장 프로퍼티의 초깃값 지정 ]

    // 좌표
    struct CoordinatePoint {
        var x: Int = 0      // 저장 프로퍼티
        var y: Int = 0      // 저장 프로퍼티
    }

    // 프로퍼티의 초깃값을 할당했다면 굳이 전달인자로 초깃값을 넘길 필요가 없다.
    let reiPoint: CoordinatePoint = CoordinatePoint()
    // 기존의 초깃값 할당 이니셜라이저도 사용 가능함
    let ybPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

    print("rei's point: \(reiPoint.x), \(reiPoint.y)")
    // rei's point: 0, 0
    print("yb's point: \(ybPoint.x), \(ybPoint.y)")
    // yb's point: 10, 5

    // 사람의 위치 정보
    class Position {
        var point: CoordinatePoint = CoordinatePoint()  // 저장 프로퍼티
        var name: String = "Unknown"                    // 저장 프로퍼티
    }

    // 초깃값을 지정해줬다면 사용자 정의 이니셜라이저를 사용하지 않아도 된다.
    let reiPosition: Position = Position()

    reiPosition.point = reiPoint
    reiPosition.name = "rei"
    ```

- 이니셜라이저의 저장 프로퍼티가 `옵셔널`이라면 굳이 초깃값을 넣어주지 않아도 된다.
  - **위의 방법들과 적절히 혼합하여 의도에 맞도록 구조체와 클래스를 정의할 수 있어야 한다.**
  ``` Swift
  // [ 옵셔널 저장 프로퍼티 ]

  // 좌표
  struct CoordinatePoint {
      // 위치는 x, y 값이 모두 있어야 하므로 옵셔널이면 안 된다.
      var x: Int
      var y: Int
  }
  
  // 사람의 위치 정보
  class Position {
      // 현재 사람의 위치를 모를 수도 있다. 👉 옵셔널
      var point: CoordinatePoint?
      let name: String
      
      init(name: String) {
          self.name = name
      }
  }
  
  // 이름은 필수지만 위치는 모를 수 있음
  let reiPosition: Position = Position(name: "rei")
  
  // 위치를 알게되면 그 때 위치 값을 할당
  reiPosition.point = CoordinatePoint(x: 20, y: 10)
  ```
---

### `지연 저장 프로퍼티`
- `지연 저장 프로퍼티(Lazy Stored Properties)`는 `필요할 때 값이 할당되는 프로퍼티`다.
- 옵셔널 타입의 저장 프로퍼티와는 다른 용도
- 지연 저장 프로퍼티는 `호출이 있어야 값을 초기화`
- `lazy` 키워드를 사용
- 상수는 인스턴스가 완전히 생성되기 전에 초기화해야 하므로 지연 저장 프로퍼티와는 맞지 않다. 따라서 지연 저장 프로퍼티는 `var` 키워드를 사용하여 변수로 정의한다.

> 지연 저장 프로퍼티는 주로 복잡한 클래스나 구조체를 표현할 때 많이 사용된다.
*ex) 클래스 인스턴스의 저장 프로퍼티로 다른 클래스나 구조체의 인스턴스를 할당해야 하는 경우 등...*

> 지연 저장 프로퍼티를 잘 사용하면 불필요한 성능저하나 메모리 낭비를 줄일 수 있다.

``` Swift
// [ 지연 저장 프로퍼티 ]

struct CoordinatePoint {
    var x: Int = 0
    var y: Int = 0
}

class Position {
    lazy var point: CoordinatePoint = CoordinatePoint()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let reiPosition: Position = Position(name: "rei")

// 이 코드를 통해 point 프로퍼티로 처음 접근할 때
// point 프로퍼티의 CoordinatePoint가 생성된다.
print(reiPosition.point) // CoordinatePoint(x: 0, y: 0)
```

> 💡 다중 스레드 환경에서 지연 저장 프로퍼티에 동시다발적으로 접근할 때는 한 번만 초기화된다는 보장이 없다. 아직 생성되지 않은 지연 프로퍼티에 여러 스레드가 비슷한 시점에 접근하게 되면 여러번 초기화될 수도 있다.
---

### `연산 프로퍼티`
- 실제 값을 저장하는 프로퍼티가 아니라, `특정 상태에 따른 값을 연산하는 프로퍼티`
- `접근자(getter)`나 `설정자(setter)`의 역할을 할 수도 있다.
- `클래스, 구조체, 열거형`에 연산 프로퍼티를 정의할 수 있다.
- 연산 프로퍼티는 `읽기 전용 상태로 구현하기는 쉽지만`, `쓰기 전용 상태로는 구현할 수 없다.`
---
- 아래와 같이 `메서드로 접근자와 설정자를 구현`하게 되면 접근자/설정자 이름의 일관성을 유지하기 힘듦
- 또한 해당 포인트에 접근할 때와 설정할 때 사용되는 코드를 한 번에 읽기도 쉽지X
    ``` Swift
    // [ 연산 프로퍼티를 적용하지 않고 메서드로 접근자와 설정자를 구현한 코드 ]

    struct CoordinatePoint {
        var x: Int  // 저장 프로퍼티
        var y: Int  // 저장 프로퍼티
        
        // 대칭점을 구하는 메서드 - 접근자
        // Self는 타입 자기 자신을 뜻함 (Self 대신 CoordinatePoint 사용해도 됨)
        func oppositePoint() -> Self {
            return CoordinatePoint(x: -x, y: -y)
        }
        
        // 대칭점을 설정하는 메서드 - 설정자
        // mutating 키워드에 대한 내용은 10.2.1절에서
        mutating func setOppositePoint(_ opposite: CoordinatePoint) {
            x = -opposite.x
            y = -opposite.y
        }
    }

    var reiPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

    // 현재 좌표
    print(reiPosition)                  // 10, 20
    // 대칭 좌표
    print(reiPosition.oppositePoint())  // -10, -20

    // 대칭 좌표를 (15, 10)으로 설정하면
    reiPosition.setOppositePoint(CoordinatePoint(x: 15, y: 10))
    // 현재 좌표는 -15, -10으로 설정된다.
    print(reiPosition)  // -15, -10
    ```

- ✅ `연산 프로퍼티`를 사용하면 좀 더 간결하고 확실하게 표현 가능
  - `하나의 프로퍼티에 접근자와 설정자가 모두` 모여있고, 해당 프로퍼티가 어떤 역할을 하는지 좀 더 명확하게 표현이 가능
  - `설정자의 매개변수`로 원하는 이름을 소괄호 안에 명시해주면 `set` 메서드 내부에서 전달받은 전달인자를 사용할 수 있다.
    - 매개변수를 따로 표기하지 않으면 관용적인 표현으로 `newValue`로 매개변수 이름을 대신할 수 있다.
    - 접근자 내부 코드가 단 한 줄이고, 결괏값 타입과 프로퍼티 타입이 같다면 return 키워드도 생략 가능
    ``` Swift
    // [ 연산 프로퍼티의 정의와 사용 ]

    struct CoordinatePoint {
        var x: Int  // 저장 프로퍼티
        var y: Int  // 저장 프로퍼티
        
        // 대칭 좌표
        var oppositePoint: CoordinatePoint { // 연산 프로퍼티
            // 접근자
            get {
                return CoordinatePoint(x: -x, y: -y)
            }
            
            // 설정자
            set(opposite) {
                x = -opposite.x
                y = -opposite.y
            }
        }
    }

    var reiPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)

    // 현재 좌표
    print(reiPosition)                  // 10, 20
    // 대칭 좌표
    print(reiPosition.oppositePoint)    // -10, -20

    // 대칭 좌표를 (15, 10)으로 설정하면
    reiPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)
    // 현재 좌표는 (-15, -10)으로 설정된다.
    print(reiPosition)  // -15, -10
    ```
---

### `프로퍼티 감시자`
- `프로퍼티 감시자(Property Observers)`를 사용하면 프로퍼티의 값이 변경됨에 따라 적절한 작업을 취할 수 있다.
- 프로퍼티 감시자는 `프로퍼티의 값이 새로 할당될 때마다 호출`된다.
- 프로퍼티의 값이 변경되기 직전에 호출하는 `willSet` 메서드와 프로퍼티 값이 변경된 직후에 호출하는 `didSet` 메서드가 있다.
  - 각각의 메서드에는 매개변수가 하나씩 있다.
  - `willSet` 👉 프로퍼티가 변경될 값 (`newValue`)
  - `didSet` 👉 변경되기 전의 값 (`oldValue`)
  - 기본 이름 말고 원하는 매개변수 이름으로도 사용 가능
  > `didSet` 감시자 코드 블록 내부에서 `oldValue` 값을 참조하지 않거나 매개변수 목록에 명시적으로 매개변수를 적어주지 않으면(예: `didSet(oldValueName)`) `didSet` 코드블록이 실행되지 않는다.

``` Swift
// [ 프로퍼티 감시자 ]

class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
}

let myAccount: Account = Account()
// 잔액이 0원에서 1000원으로 변경될 예정입니다.
myAccount.credit = 1000
// 잔액이 0원에서 1000원으로 변경되었습니다.
```

- 클래스를 상속받았다면 `기존의 연산 프로퍼티를 재정의`하여 프로퍼티 감시자를 구현할 수도 있다.
  - 재정의해도 기존의 연산 프로퍼티 기능은 동작한다.
``` Swift
// [ 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현 ]

class Account {
    var credit: Int = 0 { // 저장 프로퍼티
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double { // 연산 프로퍼티
        get {
            return Double(credit) / 1000.0
        }
        
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

class ForeignAccount: Account {
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        
        didSet {
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
        }
    }
}

let myAccount: ForeignAccount = ForeignAccount()
// 잔액이 0원에서 1000원으로 변경될 예정입니다.
myAccount.credit = 1000
// 잔액이 0원에서 1000원으로 변경되었습니다.

// 잔액이 1.0달러에서 2.0달러로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경될 예정입니다.
// 잔액이 1000원에서 2000원으로 변경되었습니다.

myAccount.dollarValue = 2 // 잔액을 2.0달러로 변경 중입니다.
// 잔액이 1.0달러에서 2.0달러로 변경되었습니다.
```
---

### `전역변수와 지역변수`
- `연산 프로퍼티`와 `프로퍼티 감시자`는 프로퍼티에 한정하지 않고, `전역변수`/`지역변수`에도 사용할 수 있다.
- 변수라고 통칭한 전역변수 또는 지역변수는 **`저장변수`** 라고 할 수 있다.
  - 저장 프로퍼티처럼 값을 저장하는 역할
  - `연산변수`로 구현할 수도 있음
  - `프로퍼티 감시자`도 구현할 수 있음
> `전역변수/전역상수`는 지연 저장 프로퍼티처럼 처음 접근할 때 최초로 연산이 이루어지기 때문에 `lazy`키워드를 사용할 필요가 없다.

> 반대로 `지역변수 및 지역상수`는 절대로 지연 연산되지 않는다.

``` Swift
// [ 저장변수의 감시자와 연산변수 ]

var wonInPocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double {
    get {
        return Double(wonInPocket) / 1000.0
    }
    
    set {
        wonInPocket = Int(newValue * 1000.0)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

// 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
// 주머니의 돈이 2000원에서 3500원으로 변경되었습니다.
dollarInPocket = 3.5 // 주머니의 달러를 3.5달러로 변경 중입니다.
```
---

### `타입 프로퍼티`
- `인스턴스 프로퍼티`는 인스턴스를 새로 생성할 때마다 초깃값에 해당하는 값이 프로퍼티의 값이 되고, 인스턴스마다 다른 값을 지닐 수 있다.
- 각각의 인스턴스가 아닌 타입 자체에 속하는 프로퍼티를 **`타입 프로퍼티`** 라고 한다.
  - 인스턴스의 생성 여부와 상관없이 `타입 프로퍼티의 값은 하나`이다.
  - `저장 타입 프로퍼티`는 `변수` or `상수`로 선언할 수 있다.
    - 반드시 초깃값을 설정해야 하며 지연 연산된다.
    - 지연 저장 프로퍼티와는 다르게 `다중 스레드 환경`에서도 `단 한 번만 초기화되도록 보장`된다.
  - `연산 타입 프로퍼티`는 `변수`로만 선언할 수 있다.
  - 타입 프로퍼티는 인스턴스를 생성하지 않고도 사용할 수 있다.

``` Swift
// [ 타입 프로퍼티와 인스턴스 프로퍼티 ]

class AClass {
    
    // 저장 타입 프로퍼티
    static var typeProperty: Int = 0
    
    // 저장 인스턴스 프로퍼티
    var instanceProperty: Int = 0 {
        didSet {
            // AClass.typeProperty와 같은 표현
            Self.typeProperty = instanceProperty + 100
        }
    }
    
    // 연산 타입 프로퍼티
    static var typeComputedProperty: Int {
        get {
            return typeProperty
        }
        
        set {
            typeProperty = newValue
        }
    }
}

AClass.typeProperty = 123

let classInstance: AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty) // 200
print(AClass.typeComputedProperty) // 200
```
---

### `키 경로`
- 스위프트에서 함수는 일급시민으로서 상수나 변수에 `참조를 할당 가능`하다.
    ``` Swift
    func someFunction(paramA: Any, paramB: Any) {
        print("someFunction called...")
    }

    var functionReference = someFunction(paramA:paramB:)

    ...
    functionReference("A", "B") // someFunction called...
    functionReference = anotherFunction(paramA:paramB:)
    ```
---
> **`키 경로(keyPath)`를 활용하면 프로퍼티도 이처럼 값을 바로 꺼내오는 것이 아니라 어떤 `프로퍼티의 위치`만 참조하도록 할 수 있다.**
- 키 경로 타입은 `AnyKeyPath`라는 클래스로부터 파생된다.
- 제일 많이 확장된 키 경로 타입
  - **`WritableKeyPath<Root, Value>`** : `값 타입`에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용
  - **`ReferenceWritableKeyPath<Root, Value>`** : `참조 타입(클래스)`에 키 경로 타입으로 읽고 쓸 수 있는 경우에 적용
- 키 경로는 `역슬래시(\)`와 `타입`, `마침표(.)` 경로로 구성됨
  ``` Swift
  \타입이름.경로.경로.경로
  ```
  > **💡 자신을 나타내는 키 경로인 `\.self`를 사용하면 인스턴스 그 자체를 표현하는 키 경로가 된다.**

``` Swift
// [ 키 경로 타입의 타입 확인 ]

class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

print(type(of: \Person.name))   // ReferenceWritableKeyPath<Person, String>
print(type(of: \Stuff.name))    // WritableKeyPath<Stuff, String>

// 키 경로는 기존의 키 경로에 하위 경로를 덧붙여 줄 수도 있다.
let keyPath = \Stuff.owner
let nameKeyPath = keyPath.appending(path: \.name)
```

- 각 인스턴스의 `keyPath 서브스크립트 메서드`에 키 경로를 전달하여 프로퍼티에 접근할 수 있다.
    ``` Swift
    // [ keyPath 서브스크립트와 키 경로 활용 ]

    class Person {
        let name: String
        init(name: String) {
            self.name = name
        }
    }

    struct Stuff {
        var name: String
        var owner: Person
    }

    let rei = Person(name: "rei")
    let steve = Person(name: "steve")
    let macbook = Stuff(name: "MacBook Pro", owner: rei)
    var iMac = Stuff(name: "iMac", owner: rei)
    let iPhone = Stuff(name: "iPhone", owner: steve)

    let stuffNameKeyPath = \Stuff.name
    let ownerKeyPath = \Stuff.owner

    // \Stuff.owner.name과 같은 표현
    let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)

    // 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져온다.
    print(macbook[keyPath: stuffNameKeyPath]) // MacBook Pro
    print(iMac[keyPath: stuffNameKeyPath]) // iMac
    print(iPhone[keyPath: stuffNameKeyPath]) // iPhone

    print(macbook[keyPath: ownerNameKeyPath]) // rei
    print(iMac[keyPath: ownerNameKeyPath]) // rei
    print(iPhone[keyPath: ownerNameKeyPath]) // steve

    // 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경
    iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
    iMac[keyPath: ownerKeyPath] = steve

    print(iMac[keyPath: stuffNameKeyPath])  // iMac Pro
    print(iMac[keyPath: ownerNameKeyPath])  // steve
    ```

> **💡 키 경로를 잘 활용하면 프로토콜과 마찬가지로 `타입 간의 의존성을 낮추는 데` 많은 도움을 줄 수 있다.**

> **💡 애플의 프레임워크는 키-값 코딩 등 많은 곳에서 키 경로를 활용하고 있기 때문에 애플 프레임워크 기반의 앱 개발 시 유용하다.**

- **💡 스위프트 5.2 버전부터 `(SomeType) -> Value` 타입의 클로저를 `키 경로 표현으로 대체`하여 사용할 수 있다.**
  - 아래 코드의 `family` 배열은 `[Person]` 타입이며, 이 타입의 `map`은 `(Person) -> T`를, `compactMap`은 `(Person) -> T?`를, `filter`는 `(Person) -> Bool` 타입의 클로저를 매개변수를 통해 전달받는다.
  - 이에 따라 `\.name`표현은 `(Person) -> T`타입의 클로저를 대체하여 표현하였고, 이는 클로저 표현인 `{$0.name}`과 같다. `\.nickname`과 `\.isAdult` 표현도 동일

    ``` Swift
    // [ 클로저를 대체할 수 있는 키 경로 표현 ]

    struct Person {
        let name: String
        let nickname: String?
        let age: Int
        
        var isAdult: Bool {
            return age > 18
        }
    }

    let rei: Person = Person(name: "rei", nickname: "dudqls", age: 100)
    let bitna: Person = Person(name: "bitna", nickname: "bit", age: 100)
    let geumzzok: Person = Person(name: "geumzzok", nickname: nil, age: 3)

    let family: [Person] = [rei, bitna, geumzzok]
    let names: [String] = family.map(\.name)    // ["rei", "bitna", "geumzzok"]
    let nicknames: [String] = family.compactMap(\.nickname) // ["dudqls", "bit"]
    let adults: [String] = family.filter(\.isAdult).map(\.name) // ["rei", "bitna"]
    ```
---

## 메서드
- 메서드는 `특정 타입에 관련된 함수`를 뜻함
- `클래스`, `구조체`, `열거형` 등은 실행하는 기능을 캡슐화한 `인스턴스 메서드`를 정의할 수 있다.
- 타입 자체와 관련된 기능을 실행하는 `타입 메서드`를 정의할 수 있다.
- `구조체와 열거형이 메서드를 가질 수 있다는 것`은 기존 프로그래밍 언어와 비교했을 때 스위프트 언어의 큰 차이점이다.
---

### `인스턴스 메서드`
- 특정 타입의 인스턴스에 속한 함수
- 인스턴스와 관련된 기능을 실행

``` Swift
// [ 클래스의 인스턴스 메서드 ]

class LevelClass {
    // 현재 레벨을 저장하는 저장 프로퍼티
    var level: Int = 0 {
        // 프로퍼티 값이 변경되면 호출하는 프로퍼티 감시자
        didSet {
            print("Level \(level)")
        }
    }
    
    // 레벨이 올랐을 때 호출할 메서드
    func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    // 레벨이 감소했을 때 호출할 메서드
    func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    // 특정 레벨로 이동할 때 호출할 메서드
    func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    // 레벨을 초기화할 때 호출할 메서드
    func reset() {
        print("Reset!")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()
levelClassInstance.levelUp() // Level Up!
// Level 1
levelClassInstance.levelDown() // Level Down
// Level 0
levelClassInstance.levelDown() // Level Down
// Level -1
// Reset!
// Level 0
levelClassInstance.jumpLevel(to: 3) // Jump to 3
// Level 3
```
- 💡 `자신의 프로퍼티 값을 수정할 때` 클래스의 인스턴스 메서드는 크게 신경 쓸 필요가 없지만, **`구조체`나 `열거형` 등은 값 타입이므로 메서드 앞에 `mutating` 키워드를 붙여서 `해당 메서드가 인스턴스 내부의 값을 변경한다는 것을 명시`해야 한다.**
``` Swift
// [ mutating 키워드의 사용 ]
struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()   // Level Up!
// Level 1
levelStructInstance.levelDown() // Level Down
// Level 0
levelStructInstance.levelDown() // Level Down
// Level -1
// Reset!
// Level 0
levelStructInstance.jumpLevel(to: 3)    // Jump to 3
// Level 3
```

#### `self 프로퍼티`
- 모든 인스턴스는 암시적으로 생성된 `self`프로퍼티를 갖는다.
- `self`프로퍼티는 인스턴스 자기 자신을 가리키는 프로퍼티로, 인스턴스를 더 명확히 지칭하고 싶을 때 사용한다.
  - 스위프트의 인스턴스 메서드 내부에서 특정 변수가 사용될 때 변수를 찾는 순서는 다음과 같다.
    - 메서드 내부에 선언된 지역변수 👉 메서드 매개변수 👉 인스턴스 프로퍼티

  ``` Swift
  // [ self 프로퍼티의 사용 ]

  class LevelClass {
      var level: Int = 0

      func jumpLevel(to level: Int) {
          print("Jump to \(level)")
          // self.level 👉 매개변수 level이 아닌 인스턴스 프로퍼티 level을 지칭
          self.level = level
      }
  }
  ```

    - `self` 프로퍼티를 활용해서 `값 타입 인스턴스 자체의 값을 치환`할 수도 있다.
    - 클래스의 인스턴스는 참조 타입이라서 `self`프로퍼티에 다른 참조를 할당할 수X
    - 구조체나 열거형 등은 `self`프로퍼티를 사용해서 자신 자체를 치환할 수도 있다.

    ``` Swift
    // [ self 프로퍼티와 mutating 키워드 ]

    class LevelClass {
        var level: Int = 0
        
        func reset() {
            // 오류!! - self 프로퍼티 참조 변경 불가
            self = LevelClass()
        }
    }

    struct LevelStruct {
        var level: Int = 0
        
        mutating func levelUp() {
            print("Level Up!")
            level += 1
        }
        
        mutating func reset() {
            print("Reset!")
            self = LevelStruct()
        }
    }

    var levelStructInstance: LevelStruct = LevelStruct()
    levelStructInstance.levelUp()       // Level Up!
    print(levelStructInstance.level)    // 1

    levelStructInstance.reset()         // Reset!
    print(levelStructInstance.level)    // 0

    enum OnOffSwitch {
        case on, off
        mutating func nextState() {
            self = self == .on ? .off : .on
        }
    }

    var toggle: OnOffSwitch = OnOffSwitch.off
    toggle.nextState()
    print(toggle)   // on
    ```
---

#### `인스턴스를 함수처럼 호출하도록 하는 메서드`
- 인스턴스를 함수처럼 호출하여 사용하는 것을 `사용자 정의 명목 타입의 호출 가능한 값(Callable values of user-defined nominal types)`라고 한다.
- 인스턴스를 함수처럼 호출할 수 있도록 하려면 `callAsFunction`이라는 이름의 메서드를 구현하면 된다.
- 이 메서드는 `매개변수와 반환 타입만 다르다면 개수에 제한 없이` 원하는 만큼 만들 수 있다.
- `mutating`, `throws`, `rethrows`등도 모두 사용할 수 있다.

    ``` Swift
    // [ Puppy 구조체에 callAsFunction 메서드 구현 ]

    struct Puppy {
        var name: String = "멍멍이"
        
        func callAsFunction() {
            print("멍멍")
        }
        
        func callAsFunction(destination: String) {
            print("\(destination)(으)로 달려갑니다.")
        }
        
        func callAsFunction(something: String, times: Int) {
            print("\(something)(을)를 \(times)번 반복합니다.")
        }
        
        func callAsFunction(color: String) -> String {
            return "\(color) 응가"
        }
        
        mutating func callAsFunction(name: String) {
            self.name = name
        }
    }

    var doggy: Puppy = Puppy()

    doggy.callAsFunction() // 멍멍
    doggy() // 멍멍 - 위와 같은 표현

    doggy.callAsFunction(destination: "집") // 집(으)로 달려갑니다.
    doggy(destination: "뒷동산")   // 뒷동산(으)로 달려갑니다.

    doggy(something: "재주넘기", times: 3)  // 재주넘기(을)를 3번 반복합니다.
    print(doggy(color: "무지개색")) // 무지개색 응가
    doggy(name: "댕댕이")
    print(doggy.name)   // 댕댕이
    ```
---

### `타입 메서드`
- 메서드도 프로퍼티와 같이 `인스턴스 메서드`와 `타입 메서드`가 존재한다.
- **`타입 자체에 호출이 가능한 메서드`를 `타입 메서드`라고 한다.**
- 클래스의 타입 메서드는 **`static`** 키워드와 **`class`** 키워드를 사용할 수 있다.
  - `static`으로 정의하면 `상속 후 메서드 재정의 불가`
  - `class`로 정의하면 `상속 후 메서드 재정의 가능`

``` Swift
// [ 클래스의 타입 메서드 ]

class AClass {
    static func staticTypeMethod() {
        print("AClass staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass classTypeMethod")
    }
}

class BClass: AClass {
    /*
     // 오류 - 재정의 불가
     override static func staticTypeMethod() {
         
     }
     */
    override class func classTypeMethod() {
        print("BClass classTypeMethod")
    }
}

AClass.staticTypeMethod()   // AClass staticTypeMethod
AClass.classTypeMethod()    // AClass classTypeMethod
BClass.staticTypeMethod()   // AClass staticTypeMethod
BClass.classTypeMethod()    // BClass classTypeMethod
```

- 인스턴스 메서드의 `self`는 인스턴스를 가리키는 반면, **`타입 메서드`는 `self` 프로퍼티가 `타입 그 자체`를 가리킨다.**
  - 타입 메서드에서 `self`프로퍼티를 사용하면 `타입 프로퍼티 및 타입 메서드를 호출`할 수 있다.

    ``` Swift
    // [ 타입 프로퍼티와 타입 메서드의 사용 ]

    // 시스템 음량은 한 기기에서 유일한 값이어야 한다.
    struct SystemVolume {
        // 타입 프로퍼티를 사용하면 언제나 유일한 값이 됨
        static var volume: Int = 5
        
        // 타입 프로퍼티를 제어하기 위해 타입 메서드 사용
        static func mute() {
            // 타입 메서드에서 self는 타입 자체를 가리킨다.
            self.volume = 0 // SystemVolume.volume = 0 & Self.volume = 0 과 같은 표현
        }
    }

    // 내비게이션 역할은 여러 인스턴스가 수행할 수 있다.
    class Navigation {
        
        // 내비게이션 인스턴스마다 음량을 따로 설정할 수 있다.
        var volume: Int = 5
        
        // 길 안내 음성 재생
        func guideWay() {
            // 내비게이션 외 다른 재생원 음소거
            SystemVolume.mute()
        }
        
        // 길 안내 음성 종료
        func finishGuideWay() {
            // 기존 재생원 음량 복구
            SystemVolume.volume = self.volume
        }
    }

    SystemVolume.volume = 10

    let myNavi: Navigation = Navigation()

    myNavi.guideWay()
    print(SystemVolume.volume) // 0

    myNavi.finishGuideWay()
    print(SystemVolume.volume) // 5
    ```