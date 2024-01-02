# **Chapter 16. 모나드**
- 함수형 프로그래밍에서의 **`모나드(Monad)`** 는 `순서가 있는 연산을 처리할 때 자주 활용하는 디자인 패턴`이라고 할 수 있다.

- 프로그래밍에서 모나드가 갖춰야 하는 조건
  1. **✔️ 타입을 인자로 받는 타입(특정 타입의 값을 포장)**
  2. **✔️ 특정 타입의 값을 포장한 것을 반환하는 함수(메서드)가 존재**
  3. **✔️ 포장된 값을 반환하여 같은 형태로 포장하는 함수(메서드)가 존재**

- `값을 어딘가에 포장하는 개념`
  - 👉 스위프트에서 모나드를 사용한 예 중 하나가 `옵셔널` (값이 있을지 없을지 모르는 상태를 포장)

- `함수객체(Functor)`와 `모나드`는 특정 기능이 아닌 **`디자인 패턴 혹은 자료구조`** 라고 할 수 있다.

---

## 컨텍스트 (Context)
- `컨텍스트(Context)`는 '`콘텐츠(Contents)를 담은 그 무엇인가'`를 뜻한다.
  - ex) `Optional(2)` : 컨텍스트는 2라는 값(콘텐츠)를 가지고 있다.
  - ex) `Optional(nil)` : 컨텍스트는 존재하지만 내부에 값이 없다.

- `Optional`은 `Wrapped` 타입을 인자로 받는 (제네릭)타입
  - 👉 모나드의 첫 번째 조건을 만족
- `Optional` 타입은 `Optional<Int>`, `init(2)`처럼 다른 타입의 값을 갖는 상태의 컨텍스트를 생성할 수 있음
  - 👉 모나드의 두 번째 조건을 만족

- 함수의 전달인자로 다른 컨텍스트의 값을 전달하면 오류가 발생한다.
``` Swift
func addThree(_ num: Int) -> Int {
    return num + 3
}

// 매개변수로 일반 Int 타입의 값을 받기 때문에 정상적으로 실행
addThree(2) // 5

// 순수한 값이 아닌 옵셔널이라는 컨텍스트로 둘러싸여 전달되면 오류
addThree(Optional(2))   // 오류 발생
```
---

## 함수객체(Functor)
- **💡 `함수객체(Functor)`란 `맵(map)을 적용할 수 있는 컨테이너 타입`이라고 할 수 있다.**
  - `Array`, `Dictionary`, `Set` 등 스위프트의 많은 컬렉션 타입이 함수객체

- `map()`함수는 컨테이너의 값을 변형시킬 수 있는 고차함수
  - 컨테이너는 다른 타입의 값을 담을 수 있으므로 컨텍스트의 역할을 수행할 수 있다.
- 옵셔널은 컨테이너와 값을 갖기 때문에 `map()` 함수를 사용할 수 있다.
``` Swift
// [ 맵 메서드를 사용하여 옵셔널을 연산할 수 있는 addThree(_:) 함수 ]
Optional(2).map(addThree)   // Optional(5)
```
``` Swift
// [ 옵셔널에 맵 메서드와 클로저의 사용 ]
var value: Int? = 2
value.map{ $0 + 3 } // Optional(5)
value = nil
value.map{ $0 + 3 } // nil(== Optional<Int>.none)
```

- 옵셔널의 `map(_:)` 메서드를 호출하면 옵셔널 스스로 값이 있는지 없는지 switch 구문을 통해 판단
  - 값이 있다면 전달받은 함수에 자신의 값을 적용한 결괏값을 다시 컨텍스트에 넣어 반환
  - 값이 없다면 함수를 실행하지 않고 빈 컨텍스트를 반환
``` Swift
// [ 옵셔널의 map 메서드 구현 ]
extension Optional {
    func map<U>(f: (Wrapped) -> U) -> U? {
        switch self {
            case .some(let x): return f(x)
            case .none: return .none
        }
    }
}
```
---

## 모나드(Monad)
- 자신의 컨텍스트와 같은 컨텍스트의 형태로 맵핑할 수 있는 함수객체를 `닫힌 함수객체(Endofunctor)`라고 한다.
- `모나드(Monad)`는 닫힌 함수객체
  - 모나드는 함수객체이기 때문에 `컨텍스트에 포장된 값을 처리하여 포장된 값을 컨텍스트에 담아 다시 반환하는 함수(맵)를 적용할 수 있다.`

### `플랫맵(flatMap)`
- `map()`과 같이 함수를 매개변수로 받는다.
    ``` Swift
    // 짝수면 2를 곱해서 반환하고, 짝수가 아니라면 nil을 반환하는 함수
    func doubledEven(_ num: Int) -> Int? {
        if num.isMultiple(of: 2) {
            return num * 2
        }
        return nil
    }

    Optional(2).flatMap(doubledEven)    // 4
    Optional(3).flatMap(doubledEven)    // nil
    ```

- **💡 `flatMap()`은 `map()`과 다르게 컨텍스트 내부의 컨텍스트를 모두 같은 위상으로 평평하게 펼쳐준다는 차이가 있다.**

### `컴팩트맵(compactMap)`
- `Optional` 타입에 사용했던 `flatMap(_:)`메서드를 `Sequence`타입이 `Optional` 타입의 `Element`를 포장한 경우에 **`compactMap(_:)`** 이라는 이름으로 사용한다.
  - 이를 제외한 다른 경우에는 그대로 `flatMap(_:)` 이름을 사용
  - `compact(_:)`의 사용 방법은 `flatMap`과 같지만, 좀 더 분명한 뜻을 나타내기 위해 다른 이름을 사용

    ``` Swift
    // [ 맵과 컴팩트의 차이 ]

    let optionals: [Int?] = [1, 2, nil, 5]

    let mapped: [Int?] = optionals.map { $0 }
    let compactMapped: [Int] = optionals.compactMap{ $0 }

    print(mapped)           // [Optional(1), Optional(2), nil, Optional(5)]
    print(compactMapped)    // [1, 2, 5]
    ```
- 위 코드의 `optionals`는 이중 컨테이너의 형태를 띄고 있음 (`Array` 컨테이너 내부에 `Optional` 형태의 컨테이너들이 어려개)
  - `맵` 메서드 사용 결과는 `Array` 내부에 값이 있으면 그 값을 그저 클로저의 코드에서만 실행하고 결과를 다시 `Array` 컨테이너에 담기만 한다.
  - **💡 `플랫맵(콤팩트맵)` 사용 시에는 알아서 내부 컨테이너까지 값을 추출한다.**

- 삼중 컨테이너에 중첩된 맵과 플랫맵(콤팩트맵)의 차이 확인 코드
  > **💡 옵셔널에 관련된 여러 컨테이너의 값을 연달아 처리할 때, 바인딩을 통해 체인 형식으로 사용할 수 있기 때문에 플랫맵이 유용하게 쓰일 수 있다.**
``` Swift
// [ 중첩된 컨테이너에서 맵과 플랫맵(콤팩트맵)의 차이 ]

let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }

print(mappedMultipleContainer)  // [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]
print(flatmappedMultipleContainer)  // [1, 2, 3, 4, 5]
```

- Int → String → Int 변환 과정을 체인 형식으로 구현한 코드
  - **💡 `flatMap`은 함수의 결괏값에 값이 있다면 추출해서 평평하게 만드는 과정을 내포하고 있기 때문에 항상 같은 컨텍스트를 유지할 수 있다.**
    ``` Swift
    // [ 플랫맵의 활용 ]

    func stringToInteger(_ string: String) -> Int? {
        return Int(string)
    }

    func integerToString(_ integer: Int) -> String? {
        return "\(integer)"
    }

    var optionalString: String? = "2"

    let flattenResult = optionalString.flatMap(stringToInteger)
        .flatMap(integerToString)
        .flatMap(stringToInteger)

    print(flattenResult)    // Optional(2)

    let mappedResult = optionalString.map(stringToInteger)  // 더 이상 체인 연결 불가
    print(mappedResult) // Optional(Optional(2))
    ```

- 옵셔널의 맵과 플랫맵의 정의
  - 위 예시 코드의 `stringToInterger`는 `Int?` 타입을 반환한다. 이를 `map`의 `U`에, `flapMap`의 `U?`에 대입해보면
    - `map` 👉 `U == Int?` 👉👉 (최종 반환 타입) `U? == Int??`
    - `flatMap` 👉 `U == Int` 👉👉 (최종 반환 타입) `U? == Int?`
    ``` Swift
    func map<U>(_ transform: (Wrapped) throws -> U) rethrows -> U?
    func flatMap<U>(_ transform: (Wrapped) throws -> U?) rethrows -> U?
    ```

- 💡 플랫맵은 체이닝 중간에 연산에 실패하거나 `nil`이 되는 경우에는 `별도의 예외 처리없이 빈 컨테이너를 반환`한다.
    ``` Swift
    // [ 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과 ]

    func integerToNil(param: Int) -> String? {
        return nil
    }

    optionalString = "2"

    let result = optionalString.flatMap(stringToInteger)
        .flatMap(integerToNil) // 이 부분에서 nil을 반환받기 때문에 이후 호출되는 메서드는 무시
        .flatMap(stringToInteger)

    print(result)   // nil
    ```
- 옵셔널 체이닝과 완전히 같은 동작 👉 옵셔널이 모나드이기 때문에 가능