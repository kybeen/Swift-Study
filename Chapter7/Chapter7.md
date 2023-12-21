# **Chapter 7. 함수**
- 스위프트에서 함수는 일급 객체이기 때문에 하나의 값으로도 사용할 수 있다.

## 함수의 정의와 호출

``` Swift
// [ 기본 형태의 함수 정의와 사용 ]
func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny) // Hello Jenny!
```

### `매개변수 이름과 전달인자 레이블`
- 함수를 정의할 때 `전달인자 레이블`을 별도로 지정하면 함수 외부에서 매개변수의 역할을 좀 더 명확히 할 수 있다.

    ``` Swift
    // [ 매개변수 이름과 전달인자 레이블을 가지는 함수 정의와 사용 ]

    // from, to 👉 전달인자 레이블
    // myName, name 👉 매개변수 이름
    func sayHello(from myName: String, to name: String) -> String {
        return "Hello \(name)! I'm \(myName)"
    }

    print(sayHello(from: "rei", to: "Son")) // Hello Son! I'm rei
    ```

    ``` Swift
    // [ 전달인자 레이블이 없는 함수 정의와 사용 ]

    func sayHello(_ name: String, _ times: Int) -> String {
        var result: String = ""

        for _ in 0..<times {
            result += "Hello \(name)!" + " "
        }

        return result
    }

    print(sayHello("rei", 2))
    // Hello rei! Hello rei!
    ```

- 전달인자 레이블만 다르게 변경함으로써 함수의 중복 정의(오버로드)로도 동작하도록 할 수 있다.
    ``` Swift
    // [ 전달인자 레이블 변경을 통한 함수 중복 정의 ]

    func sayHello(to name: String, _ times: Int) -> String {
        var result: String = ""

        for _ in 0..<times {
            result += "Hello \(name)!" + " "
        }

        return result
    }

    func sayHello(to name: String, repeatCount times: Int) -> String {
        var result: String = ""

        for _ in 0..<times {
            result += "Hello \(name)!" + " "
        }

        return result
    }

    print(sayHello(to: "rei", 2))
    print(sayHello(to: "rei", repeatCount: 2))
    ```

- 매개변수에 기본값을 지정할 수 있다.
---

### `가변 매개변수와 입출력 매개변수`
- `가변 매개변수`는 0개 이상의 값을 받아올 수 있으며, 배열처럼 사용할 수 있다.
- 함수마다 가변 매개변수는 하나만 가질 수있다.

``` Swift
// [ 가변 매개변수를 가지는 함수의 정의와 사용 ]

func sayHelloToFriends(me: String, friends names: String...) -> String {
    var result: String = ""

    for friend in names {
        result += "Hello \(friend)!" + " "
    }

    result += "I'm " + me + "!"
    return result
}

print(sayHelloToFriends(me: "kybeen", friends: "Son", "Kim", "Hwang"))
// Hello Son! Hello Kim! Hello Hwang! I'm kybeen!

print(sayHelloToFriends(me: "kybeen"))
// I'm kybeen!
```

- 함수의 전달인자로 값을 전달할 때는 보통 `값을 복사해서 전달`한다.
- 값이 아닌 `참조`를 전달하려면 `입출력 매개변수`를 사용한다.
- 입출력 매개변수의 전달 순서
    1. 함수를 호출할 때, 전달인자의 값을 복사
    2. 해당 전달인자의 값을 변경하면 1에서 복사한 것을 함수 내부에서 변경
    3. 함수를 반환하는 시점에 2에서 변경된 값을 원래의 매개변수에 할당
- `연산 프로퍼티` 또는 `감시자가 있는 프로퍼티`가 입출력 매개변수로 전달되면, 함수 호출 시점에 그 프로퍼티의 `접근자가 호출`되고 함수의 반환 시점에 `프로퍼티의 설정자`가 호출된다.
- 참조는 `inout` 매개변수로 전달될 변수 또는 상수 앞에 `&`를 붙여서 표현
``` Swift
// [ inout 매개변수의 활용 ]

var numbers: [Int] = [1, 2, 3]

func nonReferenceParameter(_ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1]) // 2

referenceParameter(&numbers) // 참조를 표현하기 위해 &를 붙여준다.
print(numbers[1]) // 1
```
- 입출력 매개변수는 매개변수 기본값을 가질 수 없다.
- 입출력 매개변수는 가변 매개변수로 사용될 수 없다.
- 입출력 매개변수의 전달인자로 상수는 사용될 수 없다. (변경할 수 없기 때문)

```
🚧 입출력 매개변수는 잘못 사용하면 메모리 안전(memory safety)을 위협하기도 하기 때문에 사용에 제약이 있다. (자세한 내용은 Chapter 29. 메모리 안전 참고)
```
---

### `반환이 없는 함수`
- 값의 반환이 필요하지 않은 함수라면 반환 타입으로 반환 타입이 `'없음'`을 의미하는 `Void`를 설정하거나 `반환 타입 표현을 생략`해줄 수 있다.
``` Swift
// [ 반환 값이 없는 함수의 정의와 사용 ]

func sayHelloWorld() {
    print("Hello, world!")
}

func sayGoodbye() -> {
    print("Good bye")
}
```
---

### `데이터 타입으로서의 함수`

- 스위프트의 함수는 일급 객체이므로 하나의 데이터 타입으로 사용할 수 있다.
  - 함수는 `매개변수 타입과 반환 타입으로 구성된 하나의 타입으로 사용(정의) 가능`하다.
- 함수를 하나의 데이터 타입으로 나타내는 방법
    ``` Swift
    (매개변수 타입의 나열) -> 반환 타입

    func sayHello(name: String, times: Int) -> String {
        ...
    }
    // sayHello 함수의 타입은 (String, Int) -> String
    ```

``` Swift
// [ 함수 타입의 사용 ]

// (Int, Int) -> Int 라는 함수 타입에 별칭 부여
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2, 5)) // 7

mathFunction = multiplyTwoInts
print(mathFunction(2, 5)) // 10
```

``` Swift
// [ 전달인자로 함수를 전달받는 함수 ]

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(addTwoInts, 3, 5) // Result: 8
```

``` Swift
// [ 특정 조건에 따라 적절한 함수를 반환해주는 함수 ]

func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}

printMathResult(chooseMathFunction(true), 3, 5) // Result: 8
```
---

## 중첩 함수
- 스위프트는 `데이터 타입의 중첩`이 자유롭다.
- 함수 안의 함수로 구현된 `중첩 함수`는 상위 함수의 몸통 블록 내부에서만 함수를 사용할 수 있다.

``` Swift
// [ 중첩 함수의 사용 ]

typealias MoveFunc = (Int) -> Int

func functionForMore(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }

    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }

    return shouldGoLeft ? goLeft : goRight
}

var position: Int = -4 // 현 위치

// 현 위치가 0보다 작으므로 전달되는 인자값은 false -> goRight(_:) 함수가 할당
let moveToZero: MoveFunc = functionForMore(position > 0)

// 원점에 도착하면 반복문 종료
while position != 0 {
    print("\(position)...")
    position = moveToZero(position)
}
print("원점 도착")
// -4...
// -3...
// -2...
// -1...
// 원점 도착
```
---

## 종료되지 않는 함수
- 종료(return)되지 않는 함수는 `비반환 함수` 또는 `비반환 메서드`라고 한다.
- 비반환 함수 안에서는 `오류를 던지거나`, `중대한 시스템 오류를 보고`하는 등의 일을 하고 `프로세스를 종료`해 버린다.
- 비반환 함수(메서드)는 반환 타입을 `Never`라고 명시해준다.
  - `Never` 타입이 스위프트 표준 라이브러리에서 사용되는 대표적인 예로는 **`fatalError`** 함수가 있다.

``` Swift
// [ 비반환 함수의 정의와 사용 ]

func crashAndBurn() -> Never {
    fatalError("Something very, very bad happened")
}

crashAndBurn() // 프로세스 종료 후 오류 보고

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다!")
        crashAndBurn()
    }
    print("All is well")
}

someFunction(isAllIsWell: true)     // All is well
someFunction(isAllIsWell: false)    // 마을에 도둑이 들었습니다!
// 프로세스 종료 후 오류 보고
```

## 반환 값을 무시할 수 있는 함수
- 의도적으로 함수의 반환 값을 사용하지 않을 경우 컴파일러가 함수의 결과값을 사용하지 않았다며 경고를 표시할 수 있다.
  - 이런 경우 **`@discardableResult`** 선언 속성을 사용하면 함수의 반환 값을 무시할 수 있다.

``` Swift
// [ @discardableResult 선언 속성 사용 ]

func say(_ something: String) -> String {
    print(something)
    return something
}

@discardableResult func discardableResultSay(_ something: String) -> String {
    print(something)
    return something
}

// 반환 값을 사용하지 않았으므로 컴파일러가 경고를 표시할 수 있다.
say("hello") // hello

// 반환 값을 사용하지 않아도 경고하지 않음
discardableResultSay("hello") // hello
```