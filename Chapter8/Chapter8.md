# **Chapter 8. 옵셔널**
- `옵셔널`은 변수 또는 상수의 값이 `nil`일 수도 있다는 것을 의미한다.

## 옵셔널 사용
- 값이 없는 옵셔널 변수 또는 상수에 (강제로) 접근하려면 런타임 오류가 발생함
- `nil`은 옵셔널로 선언된 곳에서만 사용될 수 있다.
- 옵셔널 변수 또는 상수 등은 데이터 타입 뒤에 `?`를 붙여 표현

``` Swift
// [ 옵셔널 변수의 선언 및 nil 할당 ]

var myName: String? = "kybeen"
print(myName) // Optional("kybeen")
// 옵셔널 타입의 값을 print함수의 매개변수로 전달하면 컴파일러 경고가 발생할 수 있다.

myName = nil
print(myName) // nil
```
- 옵셔널은 `제네릭`이 적용된 `열거형`으로 구현되어 있다.
  - 값을 갖는 케이스와 그렇지 못한 케이스 2가지로 정의되어 있음
    - `nil`일 때는 `none` 케이스
    - 값이 있는 경우는 `some` 케이스 👉 연관 값으로 있는 `Wrapped`에 값이 할당된다.
    ``` Swift
    // [ 옵셔널 열거형의 정의 ]

    public enum Optional<Wrapped> : ExpressibleByNilLiteral {
        case none
        case some(Wrapped)
        public init(_ some: Wrapped)
        /// 중략...
    }
    ```
- 옵셔널 자체가 열거형이기 때문에 옵셔널 변수는 `switch` 구문을 통해 값이 있고 없음을 확인할 수 있음
    ``` Swift
    // [ switch를 통한 옵셔널 값의 확인 ]

    func checkOptionalValue(value optionalValue: Any?) {
        switch optionalValue {
        case .none:
            print("This Optional variable is nil")
        case .some(let value):
            print("Value is \(value)")
        }
    }

    var myName: String? = "rei"
    checkOptionalValue(value: myName) // Value is rei

    myName = nil
    checkOptionalValue(value: myName) // This Optional variable is nil
    ```
---

## 옵셔널 추출
- 열거형의 `some` 케이스로 숨겨진 옵셔널의 값을 옵셔널이 아닌 값으로 추출하는 것을 `옵셔널 추출(Optional Unwrapping)`이라고 한다.

### `강제 추출`
- 옵셔널의 값을 추출하는 `가장 간단하지만 위험한 방법`임
- 강제 추출 시 옵셔널에 값이 없다면, `런타임 에러` 발생
``` Swift
// [ 옵셔널 값의 강제 추출 ]

var myName: String? = "rei"

// 옵셔널이 아닌 변수에는 옵셔널 값이 들어갈 수 없기 때문에 언래핑을 해줘야 한다.
var rei: String = myName!
```
---

### `옵셔널 바인딩`
- 스위프트에서는 안전한 방식으로 옵셔널 값을 추출할 수 있는 `옵셔널 바인딩(Optional Binding)`을 제공한다.
- 옵셔널 바인딩에서는 옵셔널에 값이 있을 경우 옵셔널에서 추출한 값을 일정 블록 안에서 사용할 수 있는 상수나 변수로 할당해서 옵셔널이 아닌 형태로 사용할 수 있도록 해준다.

``` Swift
// [ 옵셔널 바인딩을 사용한 옵셔널 값의 추출 ]

var myName: String? = "rei"

// 옵셔널 바인딩을 통한 임시 상수 할당
if let name = myName {
    // 상수 name은 여기 있는 if 블록 내부에서만 사용할 수 있다.
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// My name is rei

// 옵셔널 바인딩을 통한 임시 변수 할당
if var name = myName {
    // 변수 name은 여기 있는 if 블록 내부에서만 사용할 수 있다.
    name = "kybeen" // 변수이므로 내부에서 변경 가능
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// My name is name
```

- 옵셔널 바인딩을 통해 `한 번에 여러 옵셔널의 값을 추출`할 수도 있다.
  - 이 때, 바인딩하려는 옵셔널 중 하나라도 값이 없다면 해당 블록 내부 코드는 실행되지 X

``` Swift
// [ 옵셔널 바인딩을 사용한 여러 개의 옵셔널 값의 추출 ]

var myName: String? = "rei"
var yourName: String? = nil

// friend에 바인딩이 되지 않으므로 실행되지 않는다.
if let name = myName, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}
```

### `암시적 추출 옵셔널`
- `nil`을 할당하고 싶지만 옵셔널 바인딩으로 매번 값을 추출하기 귀찮거나
- 로직상 `nil`때문에 런타임 오류가 발생하지 않을 것 같다는 확신이 있는 등의 경우에
- `nil`을 할당해줄 수 있는 옵셔널이 아닌 변수나 상수가 있으면 좋을 것이다.
- 👉 이럴 때 사용하는 것이 `암시적 추출 옵셔널(Implicitly Unwrapped Optionals)`
  - 암시적 추추 옵셔널을 사용하려면 타입 뒤에 `!`를 붙여준다.
  - 암시적 추출 옵셔널로 지정된 타입은 일반 값처럼 사용할 수 있다.
  - `nil`도 할당 가능.
    - 하지만 `nil`일 때 접근하면 런타임 오류 발생

``` Swift
// [ 암시적 추출 옵셔널의 사용 ]

var myName: String! = "rei"
print(myName) // rei
myName = nil

// 암시적 추출 옵셔널도 옵셔널이므로 바인딩을 사용할 수 있다.
if let name = myName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// myName == nil

myName.isEmpty // nil값일 때 접근하면 오류 발생
```


🚧 옵셔널을 사용할 때 `강제 추출 & 암시적 추출 옵셔널` 을 사용하기보다는 `옵셔널 바인딩 & nil 병합 연산자 & 옵셔널 체이닝` 등의 방법을 사용하는 편이 훨씬 안전하고 스위프트의 지향점에 부합한다.