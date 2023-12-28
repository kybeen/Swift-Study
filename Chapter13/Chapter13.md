# **Chapter 13. 클로저**
- `클로저`를 잘 이해해야 스위프트의 함수형 프로그래밍 패러다임 스타일을 좀 더 명확하게 이해할 수 있다.
- **`클로저`는 `일정 기능을 하는 코드를 하나의 블록으로 모아놓은 것`을 말한다.**
  - 함수도 클로저의 한 형태라고 볼 수 있다.
- 클로저는 변수나 상수가 선언된 위치에서 `참조(Reference)`를 `획득(Capture)`하고 저장할 수 있다.

- **`클로저에는 3 가지 형태`가 있다.**
  - ✔️ 이름이 있으면서 어떤 값도 획득하지 않는 전역함수의 형태
  - ✔️ 이름이 있으면서 다른 함수 내부의 값을 획득할 수 있는 중첩된 함수의 형태
  - ✔️ 이름이 없고 주변 문맥에 따라 값을 획득할 수 있는 축약 문법으로 작성한 형태

- **`클로저 사용 시 특징`**
  - 💡 클로저는 매개변수와 반환 값의 타입을 문맥을 통해 유추할 수 있기 때문에 `매개변수와 반환 값의 타입을 생략`할 수 있다.
  - 💡 클로저에 `단 한 줄의 표현`만 들어있다면 `암시적으로 이를 반환 값으로 취급`한다.
  - 💡 `축약된 전달인자 이름`을 사용할 수 있다.
  - 💡 `후행 클로저 문법`을 사용할 수 있다.

- **`클로저 표현 방법`**
  - 클로저가 함수의 모습이 아닌 하나의 블록의 모습으로 표현될 수 있는 방법을 의미한다.
  - 클로저의 위치를 기준으로
    - **👉 `기본 클로저 표현`**
    - **👉 `후행 클로저 표현`**
  - 각 표현 내에서 가독성을 해치지 않는 선에서 표현을 생략하거나 축약할 수 있다.
---

## 기본 클로저
- 스위프트 표준 라이브러리의 `sorted(by:)` 메서드는 배열의 값을 정렬해준다.
  - 이 메서드는 클로저를 통해 어떻게 정렬할 것인가에 대한 정보를 받아 처리하고 결괏값을 배열로 돌려준다.
  - 정렬된 배열을 새로 생성하여 반환해준다.

- 스위프트 표준 라이브러리의 `sorted(by:)` 메서드 정의
  ``` Swift
  public func sorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element]
  ```
- `sorted(by:)` 메서드는 (배열의 타입과 같은 두 개의 매개변수를 가지며 `Bool` 타입을 반환하는)클로저를 전달인자로 받을 수 있다.
  - 반환하는 `Bool`값은 첫 번째 전달인자 값이 새로 생성되는 배열에서 두 번째 전달인자 값보다 먼저 배치되어야 하는지에 대한 결괏값이다. (`true`를 반환하면 첫 번째 전달인자가 두 번째 전달인자보다 앞에 온다.)

- `sorted(by:)`의 매개변수로 전달해줄 함수를 직접 구현해보자
  - 매개변수로 `String`타입 두 개를 가지며, `Bool`타입을 반환
    ``` Swift
    // 정렬에 사용될 이름 배열
    let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

    // 정렬을 위한 함수 전달
    func backwards(first: String, second: String) -> Bool {
        print("\(first) \(second) 비교중")
        return first > second
    }

    let reversed: [String] = names.sorted(by: backwards)
    print(reversed) // ["yagom", "wizplan", "jenny", "eric"]
    ```
- 💡 위 방법은 `first > second` 라는 반환 값을 받기 위해 너무 많은 표현이 사용되는데, **이를 `클로저 표현` 을 사용함으로써 `더 간결하게 표현`해줄 수 있다.**
  - 클로저 표현은 통상 아래의 형식을 따른다.
  ``` Swift
  { (매개변수들) -> 반환타입 in
      실행코드
  }
  ```
    ``` Swift
    // [ sorted(by:) 메서드에 클로저 전달 ]

    // backwards(first:second:) 함수 대신에 sorted(by:) 메서드의 전달인자로 클로저를 직접 전달
    let reversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
        return first > second
    })
    print(reversed) // ["yagom", "wizplan", "jenny", "eric"]
    ```
---

## 후행 클로저
- `함수나 메서드의 마지막 전달인자로 위치하는 클로저`는 함수나 메서드의 소괄호를 닫은 후 작성할 수 있는데, 이를 **`후행 클로저`** 라고 한다.
  - `sorted(by:)` 처럼 `단 하나의 클로저만 전달인자`로 전달하는 경우에는 `소괄호 생략`도 가능
  - `매개변수에 클로저가 여러 개 있는 경우`, `다중 후행 클로저 문법`을 사용할 수 있다.
    - 중괄호를 열고 닫음으로써 클로저를 표현하며, 첫 번째 클로저의 전달인자 레이블은 생략한다.

``` Swift
// [ 후행 클로저 표현 ]

// 후행 클로저의 사용
let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
    return first > second
}

// sorted(by:) 메서드의 소괄호까지 생략 가능
let reversed: [String] = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}

func doSomething(do: (String) -> Void,
                 onSuccess: (Any) -> Void,
                 onFailure: (Error) -> Void) {
    // do something...
}

// 다중 후행 클로저의 사용
doSomething { (something: String) in
    // do closure
} onSuccess: { (result: Any) in
    // success closure
} onFailure: { (error: Error) in
    // failure closure
}
```
---

## 클로저 표현 간소화

### ✔️ `문맥을 이용한 타입 유추`
- 전달인자로 전달할 클로저는 이미 적합한 타입을 준수하고 있다고 문맥에 따라 유추가 가능하기 때문에, `전달인자로 전달하는 클로저를 구현할 때는 매개변수의 타입이나 반환 값의 타입을 굳이 표현해주지 않고 생략하더라도 문제가 없다.`

    ``` Swift
    // [ 클로저의 타입 유추 ]
    let reversed: [String] = names.sorted { (first, second) in
        return first > second
    }
    ```

### ✔️ `단축 인자 이름`
- `단축 인자 이름` 사용하면 클로저의 매개변수들 이름을 따로 적지 않아도 된다.
- 단축 인자 이름은 첫 번째 전달인자부터 `$0, $1, $2, $3, ...` 순서로 `$`와 숫자의 조합으로 표현한다.
- 단축 인자 표현을 사용하게 되면 `in` 키워드를 사용할 필요도 없다.

    ``` Swift
    // [ 단축 인자 이름 사용 ]
    let reversed: [String] = names.sorted {
        return $0 > $1
    }
    ```

### ✔️ `암시적 반환 표현`
- 만약 `클로저가 반환 값을 갖고`, `클로저 내부의 실행문이 단 한 줄`이라면, 암시적으로 그 실행문을 반환 값으로 사용함으로써 `return` 키워드도 생략할 수 있다.

    ``` Swift
    // [ 암시적 반환 표현의 사용 ]
    let reversed: [String] = names.sorted { $0 > $1 }
    ```

### ✔️ `연산자 함수`
- Chapter 5.에서 공부했던 `비교 연산자`는 두 개의 피연산자를 통해 `Bool` 타입의 반환을 준다.
  ``` Swift
  // > 연산자 정의
  public func ><T : Comparable>(lhs: T, rhs: T) -> Bool
  ```
  - 이는 `sorted(by:)` 메서드에 전달한 클로저와 동일한 조건이다.
  - `클로저는 매개변수의 타입과 반환 타입이 연산자를 구현한 함수의 모양과 동일하다면 연산자만 표기하더라도 알아서 연산하고 반환해준다.`

    ``` Swift
    // [ 클로저로서의 연산자 함수 사용 ]
    let reversed: [String] = names.sorted(by: >)
    ```
---

## 값 획득
- 클로저는 자신이 정의된 위치의 주변 문맥을 통해 상수/변수를 `획득(Capture)`할 수 있다.
- 값 획득을 통해 클로저는 주변에 정의한 상수/변수가 더 이상 존재하지 않더라도 해당 상수/변수의 값을 자신 내부에서 참조하거나 수정할 수 있다.
- **💡 클로저를 통해 `비동기 콜백`을 작성하는 경우, 현재 상태를 미리 획득해두지 않으면, `실제로 클로저의 기능을 실행하는 순간에는 주변의 상수나 변수가 이미 메모리에 존재하지 않는 경우가 발생`할 수 있기 때문에 값 획득이 필요하다.**

- 👉 `중첩 함수`도 하나의 클로저 형태인데, 이 중첩 함수 주변의 변수/상수를 `획득`할 수 있다.
  - 아래 코드의 `makeIncrementer` 함수는 `incrementer`라는 함수를 중첩 함수로 포함한다.
  - `makeIncrementer`함수의 반환 타입은 `() -> Int`임 (`함수객체`를 반환)
  - 중첩 함수인 `incrementer()`는 주변에 있는 `runningTotal`, `amount` 두 값을 획득한다.
  - 두 값을 획득한 후 `incrementer`는 클로저로서 `makeIncrementer` 함수에 의해 반환된다.
    ``` Swift
    // [ makeIncrementer(forIncrement:) 함수 ]
    func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    ```
- 위 코드에서 `incrementer()` 함수를 `makeIncrementer(forIncrement:)` 함수 외부에 독립적으로 떨어뜨려 놓으면 동작할 수 없는 함수가 된다.
- 💡 `incrementer()` 함수가 두 변수 `runningTotal`과 `amount`의 참조를 획득하고 나면 `runningTotal`과 `amount`는 `makeIncrementer` 함수의 실행이 끝나도 사라지지 않을 뿐만 아니라, `incrementer`가 호출될 때마다 계속해서 사용할 수 있다.
    ``` Swift
    // [ incrementByTwo 상수에 함수 할당 ]
    /*
    incrementByTwo라는 이름의 상수에 increment 함수를 할당 후, incrementByTwo를 호출할 때마다 runningTotal은 값이 2씩 증가한다.
    */

    let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

    let first: Int = incrementByTwo()   // 2
    let second: Int = incrementByTwo()  // 4
    let third: Int = incrementByTwo()   // 6
    ```

- 💡 각각의 incrementer 함수는 `언제 호출이 되더라도 자신만의 변수를 갖고 카운트하게 되기 때문에 다른 함수의 영향을 받지 않는다.`
  - 각각 자신만의 `runningTotal` 참조를 획득했기 때문
    ``` Swift
    // [ 각각의 incrementer의 동작 ]

    let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
    let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)
    let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)

    let first: Int = incrementByTwo()       // 2
    let second: Int = incrementByTwo()      // 4
    let third: Int = incrementByTwo()       // 6

    let first2: Int = incrementByTwo2()     // 2
    let second2: Int = incrementByTwo2()    // 4
    let third2: Int = incrementByTwo2()     // 6

    let ten: Int = incrementByTen()         // 10
    let twenty: Int = incrementByTen()      // 20
    let thirty: Int = incrementByTen()      // 30
    ```

> #### 🚧 클래스 인스턴스 프로퍼티로서의 클로저
> `클래스 인스턴스의 프로퍼티로 클로저를 할당`한다면 클로저는 해당 인스턴스 또는 인스턴스 멤버의 참조를 획득할 수 있지만, `클로저-인스턴스` 사이에 `강한참조 순환 문제`가 발생할 수 있다. (27.2절 - [ARC의 강한참조 순환 문제] 참고)
---

## 클로저는 참조 타입
- **함수나 클로저를 상수/변수에 할당할 때마다 상수/변수에 함수나 `클로저의 참조`를 설정하게 된다.**
  - 위의 예시 코드에서 `incrementByTwo`라는 상수에 클로저를 할당하는 것은 `클로저의 내용이 아니라 해당 클로저의 참조`를 할당했던 것임

``` Swift
// [ 참조 타입인 클로저 ]
/*
두 상수는 같은 클로저를 참조하기 때문에 동일한 클로저가 동작하는 것을 볼 수 있다.
*/

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
let sameWithIncrementByTwo: (() -> Int) = incrementByTwo

let first: Int = incrementByTwo()           // 2
let second: Int = sameWithIncrementByTwo()  // 4
```
---

## 탈출 클로저
- **함수 전달인자로 전달한 클로저가 `함수 종료 후 호출`되는 것을 클로저가 함수를 `탈출(Escape)`한다고 표현한다.**
- 함수 매개변수 이름의 콜론(:) 뒤에 `@escaping` 키워드를 사용하면 `클로저가 탈출하는 것을 허용`한다고 명시해줄 수 있다.
- 👉 비동기 작업을 실행하는 함수들은 클로저를 `컴플리션 핸들러(Completion handler)` 전달인자로 받아온다. **비동기 작업으로 함수가 종료된 후 클로저를 호출하는 경우 `탈출 클로저(Escaping Closure)`가 필요하다.**
  - `@escaping` 키워드를 따로 명시하지 않는다면 매개변수로 사용되는 클로저는 기본으로 `비탈출 클로저(Nonescape Closure)`이다.
- 클로저가 함수를 탈출할 수 있는 경우 중 하나는 `함수 외부에 정의된 변수나 상수에 저장되어 함수가 종료된 후에 사용`할 경우이다.

``` Swift
// [ 탈출 클로저를 매개변수로 갖는 함수 ]

var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

``` Swift
// [ 함수를 탈출하는 클로저의 예 ]

typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
    print("ClosureA")
}
let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저임
func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
    // 전달인자로 전달받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저임
    return shouldReturnFirstClosure ? first : second
}

// 함수에서 반환한 클로저가 함수 외부의 상수에 저장됨
let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnedClosure()   // Closure A

var closures: [VoidVoidClosure] = []

// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저임
func appendClosure(closure: @escaping VoidVoidClosure) {
    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출
    closures.append(closure)
}
```

- **💡 타입 내부 메서드의 매개변수 클로저에 `@escaping` 키워드를 사용하여 탈출 클로저임을 명시한 경우, 클로저 내부에서 해당 타입의 프로퍼티나 메서드, 서브스크립트 등에 접근하려면 `self`키워드를 명시적으로 사용해야 한다.**
  - 비탈출 클로저의 경우 `self` 키워드의 사용은 선택 사항임

``` Swift
// [ 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저 ]

typealias VoidVoidClosure = () -> Void

func functionWithNoescapeClosure(closure: VoidVoidClosure) {
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass {
    var x = 10
    
    func runNoescapeClosure() {
        // 비탈출 클로저에서 self 키워드 사용은 선택 사항
        functionWithNoescapeClosure {
            x = 200
        }
    }
    
    func runEscapingClosure() -> VoidVoidClosure {
        // 탈출 클로저에는 명시적으로 self를 사용해야 한다.
        return functionWithEscapingClosure {
            self.x = 100
        }
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x)   // 200

let returnredClosure: VoidVoidClosure = instance.runEscapingClosure()
returnredClosure()
print(instance.x)   // 100
```

### `withoutActuallyEscaping`
- 실제로는 탈출하지 않는데 다른 함수에서 탈출 클로저를 요구하는 상황이 있음
- 아래의 `hasElements(in:match:)` 함수는 `@escaping` 키워드가 없으므로 비탈출 클로저를 전달받게 된다.
  - 내부에서 배열의 `lazy` 컬렉션에 있는 `filter` 메서드의 매개변수로 비탈출 클로저를 전달한다.
  - `lazy` 컬렉션은 비동기 작업을 할 때 사용하기 때문에 `filter` 메서드가 요구하는 클로저는 탈출 클로저이다.
  - 그렇기 때문에 탈출 클로저 자리에 비탈출 클로저를 전달할 수 없다는 오류가 나오게 된다.
    ``` Swift
    // [ 오류가 발생하는 hasElements 함수 ]
    func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
        return (array.lazy.filter { predicate($0) }.isEmpty == false )
    }
    ```
- 하지만 함수 전체를 봤을 때는 `match` 클로저가 탈출할 필요가 없다.
  - 이럴 때 해당 클로저를 탈출 클로저인 것처럼 사용할 수 있게 돕는 `withoutActuallyEscaping(_:do:)` 함수를 사용할 수 있다.
    - `withoutActuallyEscaping(_:do:)` 함수의 첫 번째 전달인자로 탈출 클로저인 척해야 하는 클로저를 전달하고, `do` 전달인자에는 첫 번째 전달인자로 전달한 클로저를 매개변수로 전달받아 실제로 작업을 실행할 탈출 클로저를 전달해준다.
    ``` Swift
    // [ withoutActuallyEscaping(_:do:) 함수의 활용 ]

    let numbers: [Int] = [2, 4, 6, 8]

    let evenNumberPredicate = { (number: Int) -> Bool in
        return number % 2 == 0
    }

    let oddNumberPredicate = { (number: Int) -> Bool in
        return number % 2 == 1
    }

    func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
        return withoutActuallyEscaping(predicate, do: { escapablePredicate in
            return (array.lazy.filter { escapablePredicate($0) }.isEmpty == false)
        })
    }

    let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
    let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

    print(hasEvenNumber)    // true
    print(hasOddNumber)     // false
    ```
---

## 자동 클로저
- 함수의 전달인자로 전달하는 표현을 자동으로 변환해주는 클로저를 `자동 클로저(Auto Closure)`라고 한다.
  - **`자동 클로저는 전달인자를 갖지 않는다.`**
  - 호출되었을 떄 자신이 감싸고 있는 코드의 결괏값을 반환
- `스위프트 표준 라이브러리`에는 자동 클로저를 호출하는 함수가 몇개 구현되어 있다.
  - ex) `assert(condition:message:file:line:)` 함수의 `condition`과 `message`
  - 💡 자동 클로저는 클로저가 호출되기 전까지 클로저 내부의 코드가 동작하지 않기 때문에 연산을 지연시킬 수 있다.

- 아래 코드에서는 실제 클로저가 호출되기 전까지 `removeFirst()` 함수가 실행되지 않는다.
    ``` Swift
    // [ 클로저를 이용한 연산 지연 ]

    // 대기 중인 손님들
    var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]
    print(customersInLine.count)    // 4

    // 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있는다.
    let customerProvider: () -> String = {
        return customersInLine.removeFirst()
    }
    print(customersInLine.count)    // 4

    // 실제로 실행
    print("Now serving \(customerProvider())!") // "Now serving Messi!"
    print(customersInLine.count)    // 3
    ```

- 만약 위의 코드와 같은 조건의 클로저를 함수의 전달인자로 전달한다면 아래와 같이 작성할 수 있다.
    ``` Swift
    // [ 함수의 전달인자로 전달하는 클로저 ]

    var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]

    func serveCustomer(_ customerProvider: () -> String) {
        print("Now serving \(customerProvider())!") // 암시적 반환 표현으로 return 생략
    }

    serveCustomer( { customersInLine.removeFirst() } )  // "Now serving Messi!"
    ```

- **위의 코드를 `자동 클로저`를 사용해서 표현하면 아래와 같다.**
  - 클로저 매개변수에 `@autoclosure` 속성을 주면 자동 클로저 기능을 사용할 수 있다.
  - 자동 클로저 속성을 부여한 매개변수는 클로저 대신 `customersInLine.removeFirst()` 코드의 실행 결과인 `String` 타입의 문자열을 전달인자로 받게 된다.
  - `String` 타입의 값이 자동 클로저 매개변수에 전달되면, `String` 값을 👉 `매개변수가 없는, String 값을 반환하는 클로저`로 변환해준다.
  - 자동 클로저는 전달인자를 갖지 않기 때문에 반환 타입의 값이 자동 클로저의 매개변수로 전달되면 이를 클로저로 바꿔줄 수 있다.
    ``` Swift
    // [ 자동 클로저의 사용 ]

    var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]

    func serveCustomer(_ customerProvider: @autoclosure () -> String) {
        print("Now serving \(customerProvider())!")
    }

    serveCustomer(customersInLine.removeFirst())    // "Now serving Messi!"
    ```

> 🚧 자동 클로저의 과도한 사용은 코드를 이해하기 어렵게 만들 가능성이 크기 때문에 굳이 추천하지는 X

- 기본적으로 `@autoclosure` 속성은 `@noescape` 속성을 포함한다.
  - 자동 클로저를 탈출하는 클로저로 사용하려면 `@autoclosure` 뒤에 `@escaping`을 덧붙여준다.

    ``` Swift
    // [ 자동 클로저의 탈출 ]

    var customersInLine: [String] = ["Gerrard", "Torress", "Suarez"]

    func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
        return customerProvider
    }
    let customerProvider: () -> String = returnProvider(customersInLine.removeFirst())
    print("Now serving \(customerProvider())!") // "Now serving Gerrard!"
    ```

> #### 💡 클로저는 생략할 수 있는 부분이 많기 때문에 다양한 클로저 표현 방법을 알아두고 익혀놓는 것이 좋다.
> - 타입 유추, 암시적 반환 표현, 단축 인자 이름 등등...