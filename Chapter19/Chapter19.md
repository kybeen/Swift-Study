# **Chapter 19. 타입캐스팅**
- 스위프트는 엄격한 타입 제한 때문에 다른 프로그래밍 언어에서 대부분 지원하는 `암시적 데이터 타입 변환(Implicit Type Conversion)`은 지원하지 않는다.
---

## 기존 언어의 타입 변환과 스위프트의 타입 변환
- 아래 스위프트 코드에서 `Int(value)` 형태로 데이터 타입의 형태를 변경해주는 것은 타입캐스팅이 아니라 `이니셜라이저`를 통해 `새로운 Int 구조체의 인스턴스`를 생성해주는 것이다.
``` Swift
// C 언어
double value = 3.3
int convertedValue = (int)value
convertedValue = 5.5        // double -> int 암시적 데이터 타입 변환

// 스위프트
var value: Double = 3.3
var convertedValue: Int = Int(value)
convertedValue = 5.5        // 오류!!
```

- `Int`의 이니셜라이저는 대부분 실패하지 않는 이니셜라이저로 정의되어 있는데, 실패 가능한 이니셜라이저도 몇 가지 존재한다.
  - ex) `StringProtocol` 타입을 매개변수로 받는 `Int` 이니셜라이저
    ``` Swift
    // [ 실패 가능한 이니셜라이저 ]

    var stringValue: String = "123"
    var integerValue: Int? = Int(stringValue)

    print(integerValue) // Optional(123)

    stringValue = "A123"
    integerValue = Int(stringValue)

    print(integerValue) // nil
    ```
---

## 스위프트 타입캐스팅
- 스위프트에서는 다른 언어의 타입 변환/타입캐스팅을 `이니셜라이저`로 단순화했다.
- **‼️ 하지만 스위프트에도 `타입캐스팅`은 있으며, 다른 언어와는 조금 다른 의미로 사용된다.**
  > **👉 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하거나 자신을 다른 타입의 인스턴스인양 행세할 수 있는 방법으로 사용할 수 있다.**

- 스위프트의 타입 캐스팅은 `is`와 `as` 연산자로 구현
  - `값의 타입을 확인`하거나 `다른 타입으로 전환(Cast)`할 수 있다.
  - `프로토콜을 준수`하는지도 확인할 수 있다.
- 스위프트의 타입 캐스팅은 `참조 타입`에서 주로 사용된다.

- 🔩 아래 예시 코드를 보면 `Latte와` `Americano` 클래스는 `Coffee` 클래스가 갖는 특성들을 모두 포함하고 있다.
  - **그렇기 때문에 👉 `Latte와` `Americano` 클래스는 `Coffee`인 척 할 수 있다.**
    ``` Swift
    // [ Coffee 클래스와 Coffee 클래스를 상속받은 Latte와 Americano 클래스 ]

    class Coffee {
        let name: String
        let shot: Int
        
        var description: String {
            return "\(shot) shot(s) \(name)"
        }
        
        init(shot: Int) {
            self.shot = shot
            self.name = "coffee"
        }
    }

    class Latte: Coffee {
        var flavor: String
        
        override var description: String {
            return "\(shot) shot(s) \(flavor) latte"
        }
        
        init(flavor: String, shot: Int) {
            self.flavor = flavor
            super.init(shot: shot)
        }
    }

    class Americano: Coffee {
        let iced: Bool
        
        override var description: String {
            return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
        }
        
        init(shot: Int, iced: Bool) {
            self.iced = iced
            super.init(shot: shot)
        }
    }
    ```
---

## 데이터 타입 확인
- 타입 확인 연산자 `is`를 사용하면 인스턴스가 어떤 클래스(혹은 어떤 클래스의 자식클래스)의 인스턴스인지 타입을 확인해볼 수 있다.
  - 해당 클래스나 그 자식클래스의 인스턴스라면 `true`를 반환, 그렇지 않다면 `false`
  - 클래스의 인스턴스 뿐만 아니라 모든 데이터 타입에 사용 가능

``` Swift
// [ 데이터 타입 확인 ]

let coffee: Coffee = Coffee(shot: 1)
print(coffee.description)       // 1 shot(s) coffee

let myCoffee: Americano = Americano(shot: 2, iced: false)
print(myCoffee.description)     // 2 shot(s) hot americano

let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
print(yourCoffee.description)   // 3 shot(s) green tea latte

print(coffee is Coffee)     // true
print(coffee is Americano)  // false
print(coffee is Latte)      // false

print(myCoffee is Coffee)   // true
print(yourCoffee is Coffee) // true

print(myCoffee is Latte)    // false
print(yourCoffee is Latte)  // true
```

- `is` 연산자 외에도 **`메타 타입(Meta Type) 타입`** 을 이용해서 타입을 확인할 수 있다.
  - `타입의 타입`을 뜻함 👉 타입 자체가 하나의 타입으로 또 표현됨
  - 타입의 이름 뒤에 **`.Type`** 을 붙이면 메타 타입을 나타낸다.
    - ex) `SomeClass.Type`
  - 프로토콜 타입의 메타 타입은 **`.Protocol`** 을 붙여준다.
    - ex) `SomeProtocol.Protocol`

- `self`를 사용해서 값처럼 표현할 수 있다.
  - ex) `SomeClass.self` 👉 `SomeClass`의 인스턴스가 아니라 `SomeClass` 타입을 값으로 표현한 값을 반환
  - ex) `SomeProtocol.self` 👉 `SomeProtocol`을 준수하는 타입의 인스턴스가 아니라 `SomeProtocol`프로토콜을 값으로 표현한 값을 반환

    ``` Swift
    // [ 메타 타입 ]

    protocol SomeProtocol { }
    class SomeClass: SomeProtocol { }

    let intType: Int.Type = Int.self
    let stringType: String.Type = String.self
    let classType: SomeClass.Type = SomeClass.self
    let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self

    var someType: Any.Type

    someType = intType
    print(someType) // Int

    someType = stringType
    print(someType) // String

    someType = classType
    print(someType) // SomeClass

    someType = protocolProtocol
    print(someType) // SomeProtocol
    ```

- 프로그램 실행 중에 `인스턴스의 타입을 표현한 값`을 알아보고자 한다면 `type(of:)` 함수를 사용한다.
    ``` Swift
    // [ type(of:) 함수와 .self의 사용 ]

    print(type(of: coffee) == Coffee.self)          // true
    print(type(of: coffee) == Americano.self)       // false
    print(type(of: coffee) == Latte.self)           // false

    print(type(of: coffee) == Americano.self)       // false
    print(type(of: myCoffee) == Americano.self)     // true
    print(type(of: yourCoffee) == Americano.self)   // false

    print(type(of: coffee) == Latte.self)           // false
    print(type(of: myCoffee) == Latte.self)         // false
    print(type(of: yourCoffee) == Latte.self)       // true
    ```
---

## 다운캐스팅
- 어떤 클래스 타입의 변수 또는 상수가 정말 해당 클래스의 인스턴스를 참조하는게 아닐 수도 있다.
  - 아래 코드의 `actingConstant` 상수는 `Coffee` 인스턴스를 참조하도록 선언했지만, 실제로는 `Latte` 타입의 인스턴스를 참조하고 있다.
    ``` Swift
    // [ Latte 타입의 인스턴스를 참조하는 Coffee 타입 actingConstant 상수 ]

    let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
    print(actingConstant.description)   // 2 shot(s) vanilla latte
    ```
- 💡 이런 경우 만약 `Latte` 타입에 정의되어 있는 메서드를 사용하거나 프로퍼티에 접근해야 한다면 `actingConstant`가 잠조하는 인스턴스를 `Latte` 타입으로 변환해주어야 하는데, 이를 **`다운캐스팅(Down Casting)`** 이라고 한다. (부모클래스 타입 → 자식클래스 타입)

- `타입캐스트 연산자(Type Cast Operator)`에는 `as?`와 `as!` 두 가지가 있다. 해당 연산자를 사용하면 자식클래스 타입으로 다운캐스팅이 가능하다.
  - `as?` : 다운캐스팅 실패 시 `nil`을 반환. (반환 타입 옵셔널)
  - `as!` : 다운캐스팅 실패 시 런타임 오류. (반환 타입 옵셔널x)

    ``` Swift
    // [ 다운캐스팅 ]

    // == 만약 coffee가 참조하는 인스턴스가 Americano 타입의 인스턴스라면 actingOne이라는 임시 상수에 할당하라
    if let actingOne: Americano = coffee as? Americano {
        print("This is Americano")
    } else {
        print(coffee.description)
    }
    // 1 shot(s) coffee

    if let actingOne: Latte = coffee as? Latte {
        print("This is Latte")
    } else {
        print(coffee.description)
    }
    // 1 shot(s) coffee

    if let actingOne: Coffee = coffee as? Coffee {
        print("This is Just Coffee")
    } else {
        print(coffee.description)
    }
    // This is Just Coffee

    if let actingOne: Americano = myCoffee as? Americano {
        print("This is Americano")
    } else {
        print(coffee.description)
    }
    // This is Americano

    if let actingOne: Latte = myCoffee as? Latte {
        print("This is Latte")
    } else {
        print(coffee.description)
    }
    // 1 shot(s) coffee

    if let actingOne: Coffee = myCoffee as? Coffee {
        print("This is Just Coffee")
    } else {
        print(coffee.description)
    }
    // This is Just Coffee

    // Success
    let castedCoffee: Coffee = yourCoffee as! Coffee

    // 런타임 오류!!! 강제 다운캐스팅 실패!
    let castedAmericano: Americano = coffee as! Americano
    ```

- 컴파일러가 다운캐스팅을 확신할 수 있는 경우에는 그냥 `as`를 사용할 수 도 있다.
  - 캐스팅하려는 타입이 같은 타입이거나 부모클래스 타입이라는 것을 알 때
    ``` Swift
    // [ 항상 성공하는 다운캐스팅 ]
    let castedCoffee: Coffee = yourCoffee as Coffee
    ```

```
💡 캐스팅은 실제로 인스턴스를 수정하거나 값을 변경하는 작업이 아니다. 인스턴스는 메모리에 똑같이 남아 있음
👉 인스턴스를 사용할 때 어떤 타입으로 다루고 어떤 타입으로 접근해야 할 지 컴퓨터가 판단할 수 있도록 해주는 것임
```
---

## Any, AnyObject의 타입캐스팅
- 스위프트에는 특정 타입을 지정하지 않고 여러 타입의 값을 할당할 수 있는 타입이 있다.
  - `Any` : 함수 타입을 포함한 모든 타입
  - `AnyObject` : 클래스 타입만을 뜻함

- 만약 반환받는 타입이 `Any`나 `AnyObject`라면 전달받은 데이터가 `어떤 타입인지 확인하고 사용`해야 한다. (스위프트는 암시적 타입 변환을 허용하지 않기 때문)
    ``` Swift
    // [ AnyObject의 타입 확인 ]

    func checkType(of item: AnyObject) {
        if item is Latte {
            print("item is Latte")
        } else if item is Americano {
            print("item is Americano")
        } else if item is Coffee {
            print("item is Coffee")
        } else {
            print("Unknown Type")
        }
    }

    checkType(of: coffee)           // item is Coffee
    checkType(of: myCoffee)         // item is Americano
    checkType(of: yourCoffee)       // item is Latte
    checkType(of: actingConstant)   // item is Latte
    ```
- `item`이 어떤 타입인지 판단하는 동시에 `실질적으로 해당 타입의 인스턴스로 사용할 수 있도록 캐스팅`하려면 아래 코드처럼 사용할 수 있다.
    ``` Swift
    // [ AnyObject의 타입캐스팅 ]

    func castTypeToAppropriate(item: AnyObject) {
        if let castedItem: Latte = item as? Latte {
            print(castedItem.description)
        } else if let castedItem: Americano = item as? Americano {
            print(castedItem.description)
        } else if let castedItem: Coffee = item as? Coffee {
            print(castedItem.description)
        } else {
            print("Unknown Type")
        }
    }

    castTypeToAppropriate(item: coffee)         // 1 shot(s) coffee
    castTypeToAppropriate(item: myCoffee)       // 2 shot(s) hot americano
    castTypeToAppropriate(item: yourCoffee)     // 3 shot(s) green tea latte
    castTypeToAppropriate(item: actingConstant) // 2 shot(s) vanilla latte
    ```

- 클래스의 인스턴스만 취할 수 있는 `AnyObject`와 다르게, **`Any`** 는 `모든 타입의 인스턴스`를 취할 수 있다.
    ``` Swift
    // [ Any의 타입캐스팅 ]

    func checkAnyType(of item: Any) {
        switch item {
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
        case let latte as Latte:
            print(latte.description)
        case let stringConverter as (String) -> String:
            print(stringConverter("rei"))
        default:
            print("something else : \(type(of: item))")
        }
    }

    checkAnyType(of: 0)             // zero as an Int
    checkAnyType(of: 0.0)           // zero as a Double
    checkAnyType(of: 42)            // an integer value of 42
    checkAnyType(of: 3.14159)       // a positive double value of 3.14159
    checkAnyType(of: -0.25)         // some other double value that I don't want to print
    checkAnyType(of: "hello")       // a string value of "hello"
    checkAnyType(of: (3.0, 5.0))    // an (x, y) point at 3.0, 5.0
    checkAnyType(of: yourCoffee)    // 3 shot(s) green tea latte
    checkAnyType(of: coffee)        // something else : Coffee
    checkAnyType(of: { (name: String) -> String in "Hello, \(name)" })  // Hello, rei
    ```

> 💡 `Any` 타입은 모든 값 타입을 표현한다. 옵셔널 타입도 표현할 수 있다. 하지만 **`Any` 타입의 값이 들어와야 할 자리에 옵셔널 타입의 값이 위치한다면 스위프트 컴파일러는 경고**를 한다.
>
> 의도적으로 옵셔널 값을 `Any` 타입의 값으로 사용하고자 한다면 `as` 연산자를 사용하여 명시적 타입 캐스팅을 해주면 된다.
> ``` Swift
> // print() 예시
> let optionalValue: Int? = 100
> print(optionalValue)  // 컴파일러 경고 발생
> print(optionalValue as Any)   // 경고 없음
> ```