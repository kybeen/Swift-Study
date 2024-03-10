# **Chapter 5. 연산자**

### 연산자의 분류

|분류|설명|예|
|:---|:---|:---|
| 단항 연산자 | 피연산자가 한 개인 연산자 | `!A` |
| 이항 연산자 | 피연산자가 두 개인 연산자 | `A + B` |
| 삼항 연산자 | 피연산자가 세 개인 연산자 | `A ? B : C` |
| 전위 연산자 | 연산자가 피연산자 앞에 위치하는 연산자 | `!A` |
| 중위 연산자 | 연산자가 피연산자 사이에 위치하는 연산자 | `A + B` |
| 후위 연산자 | 연산자가 피연산자 뒤에 위치하는 연산자 | `A!` |
---

## 💡 연산자의 종류

### `할당 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 할당(대입) 연산자 | `A = B` | A에 B의 값을 할당 |
----

### `산술 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 더하기 연산자 | `A + B` | A와 B를 더한 값을 반환 |
| 빼기 연산자 | `A - B` | A에서 B를 뺀 값을 반환 |
| 곱하기 연산자 | `A * B` | A에서 B를 곱한 값을 반환 |
| 나누기 연산자 | `A / B` | A에서 B를 나눈 값을 반환 |
| 나머지 연산자 | `A % B` | A에서 B를 나눈 나머지를 반환 |

- 💡스위프트에서는 부동소수점 타입의 나머지 연산도 지원한다.
    ``` Swift
    let number: Double = 5.0
    var result: Double = number.truncatingRemainder(dividingBy: 1.5) // 0.5

    // 기본 나누기 연산은 나머지나 소수점을 제외한 정수만 결과값으로 반환
    var result: Int = 5 / 3     // 1
    result = 10 / 3             // 3
    ```
- 스위프트에서는 서로 다른 자료형끼리 연산을 수행하려면 반드시 `같은 타입으로 변환 후 연산`해주어야 한다.
---

### `비교 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 값이 같다. | `A == B` | A와 B가 같은 값인지 |
| 값이 크거나 같다. | `A >= B` | A가 B보다 크거나 같은 값인지 |
| 값이 작거나 같다. | `A <= B` | A가 B보다 작거나 같은 값인지 |
| 값이 크다. | `A > B` | A가 B보다 큰 값인지 |
| 값이 작다. | `A < B` | A가 B보다 작은 값인지 |
| 값이 같지 않다. | `A != B` | A와 B가 다른 값인지 |
| 참조가 같다. | `A === B` | A와 B가 참조(레퍼런스) 타입일 때 A와 B가 같은 인스턴스를 가리키는지 |
| 참조가 같지 않다. | `A !== B` | A와 B가 참조(레퍼런스) 타입일 때 A와 B가 같지 않은 인스턴스를 가리키는지 |
| 패턴 매치 | `A ~= B` | A와 B의 패턴이 매치되는지 |
---

### `삼항 조건 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 삼항 조건 연산자 | `Q ? A : B` | Q(Bool타입) 값이 true면 A를, false면 B를 반환 |
---

### `범위 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 폐쇄 범위 연산자 | `A...B` | A부터 B까지의 수 |
| 반폐쇄 범위 연산자 | `A..<B` | A부터 B 미만까지의 수 |
| 단방향 범위 연산자 | `A...` | A 이상의 수 |
|  | `...A` | A 이하의 수 |
|  | `..<A` | A 미만의 수 |
---

### `부울 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| NOT 연산자 | `!B` | B(Bool값)의 참, 거짓을 반전 |
| AND 연산자 | `A && B` | A와 B의 불리언 AND 논리 연산 수행 |
| OR 연산자 | `A \|\| B` | A와 B의 불리언 OR 논리 연산 수행 |
---

### `비트 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| NOT 비트 연산자 | `~A` | A의 비트를 반전 |
| AND 비트 연산자 | `A & B` | A와 B의 비트 AND 논리 연산 수행 |
| OR 비트 연산자 | `A \| B` | A와 B의 비트 OR 논리 연산 수행 |
| XOR 비트 연산자 | `A ^ B` | A와 B의 비트 XOR 논리 연산 수행 |
| 비트 이동 연산자(시프트 연산자) | `A >> B` | A의 비트를 B만큼 오른쪽 시프트(이동) |
|  | `A << B` | A의 비트를 B만큼 왼쪽 시프트(이동) |
---

### `복합 할당 연산자`
| 표현 | 설명 | 같은 표현 |
| :--- | :--- | :--- |
| `A += B` | A와 B의 합을 A에 할당 | `A = A + B` |
| `A -= B` | A와 B의 차를 A에 할당 | `A = A - B` |
| `A *= B` | A와 B의 곱을 A에 할당 | `A = A * B` |
| `A /= B` | A를 B로 나눈 값을 A에 할당 | `A = A / B` |
| `A %= B` | A를 B로 나눈 나머지를 A에 할당 | `A = A % B` |
| `A <<= N` | A를 N만큼 왼쪽 비트 시프트 한 값을 A에 할당 | `A = A << N` |
| `A >>= N` | A를 N만큼 오른쪽 비트 시프트 한 값을 A에 할당 | `A = A >> N` |
| `A &= B` | A와 B의 비트 AND 연산 결과를 A에 할당 | `A = A & B` |
| `A \|= B` | A와 B의 비트 OR 연산 결과를 A에 할당 | `A = A \| B` |
| `A ^= B` | A와 B의 비트 XOR 연산 결과를 A에 할당 | `A = A ^ B` |
---

### `오버플로 연산자`
- 오버플로 연산자를 사용하면 오버플로를 자동으로 처리해준다.

| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| 오버플로 더하기 연산 | `&+` | 오버플로에 대비한 덧셈 연산 수행 |
| 오버플로 빼기 연산 | `&-` | 오버플로에 대비한 뺄셈 연산 수행 |
| 오버플로 곱하기 연산 | `&*` | 오버플로에 대비한 곱셈 연산 수행 |

``` Swift
var unsignedInteger: UInt8 = 0
let errorUnderflowResult: UInt8 = unsignedInteger - 1 // 런타임 오류
let underflowedValue: UInt8 = unsignedInteger &- 1 // 255

var unsignedInteger = UInt8.max // 255
let errorOverflowResult: UInt8 = unsignedInteger + 1 // 런타임 오류
let underflowedValue: UInt8 = unsignedInteger &+ 1 // 0
```
---

### `기타 연산자`
| 연산자 | 부호 | 설명 |
| :--- | :--- | :--- |
| nil 병합 연산자 | `A ?? B` | A가 nil이 아니면 A를 반환하고, A가 nil이면 B를 반환 |
| 부호변경 연산자 | `-A` | A(수)의 부호를 변경 |
| 옵셔널 강제 추출 연산자 | `O!` | O(옵셔널)의 값을 강제로 추출 |
| 옵셔널 연산자 | `O?` | O(옵셔널)의 값을 안전하게 추출하거나, O가 옵셔널임을 표현 |
---

## 💡 연산자 우선순위와 결합방향
- 스위프트 표준 라이브러리에는 다양한 우선순위 그룹이 존재한다.
- 스위프트의 연산자 정의를 보면 `연산자 우선순위 그룹(precedencegroup)`이 지정되어 있다.
- 스위프트의 연산자 우선순위는 절대치가 아닌 상대적인 수치이다.
- 연산자 우선순위가 높을수록 같은 라인의 연산자 중 먼저 처리된다.
---
- **스위프트 표준 라이브러리의 연산자 우선순위 그룹 우선순위별 정렬(우선순위 높은 순)**
    | 연산자 우선순위 그룹 이름 | 결합 방향 | 할당 방향 사용 |
    | :--- | :--- | :--- |
    | `DefaultPrecedence` | none | false |
    | `BitwiseShiftPrecedence` | none | false |
    | `MultiplicationPrecedence` | left | false |
    | `AdditionPrecedence` | left | false |
    | `RangeFormationPrecedence` | none | false |
    | `CastingPrecedence` | none | false |
    | `NilCoalescingPrecedence` | right | false |
    | `ComparisonPrecedence` | none | false |
    | `LogicalConjunctionPrecedence` | left | false |
    | `LogicalDisjunctionPrecedence` | left | false |
    | `TernaryPrecedence` | right | false |
    | `AssignmentPrecedence` | right | true |
    | `FunctionArrowPrecedence` | right | false |

``` Swift
// [ 연산자 우선순위에 따른 처리순서 ]
/*
연산자 우선순위 그룹
- << : BitwiseShiftPrecedence
- + : AdditionPrecedence
- * : MultiplicationPrecedence
*/
let intValue: Int = 1
let resultValue1: Int = intValue << 3 + 5 // 8 + 5 => 13
let resultValue2: Int = 1 * 3 + 5 // 3 + 5 => 8
```
---

## 💡 사용자 정의 연산자
- 스위프트에서는 사용자가 원하는대로 연산자 역할을 부여할 수 있음
- 기존에 존재하지 않던 연산자 기호를 만들어 추가할 수도 있다.
- 토큰으로 사용되는 기호( `=`, `->`, `//` 등... )와 전위 연산자 `<`, `&`, `?`, 중위 연산자 `?`, 후위 연산자 `>`, `!`, `?` 등은 이미 스위프트에서 예약한 상태이기 때문에 재정의할 수 없고, 사용자 정의 연산자로 사용할 수도 없다.

### 연산자 관련 키워드
- 연산자 종류 키워드
  - `prefix` : 전위 연산자
  - `infix` : 중위 연산자
  - `postfix` : 후위 연산자

- `operator` : 연산자임을 뜻함
- `associativity` : 연산자 결합방향
- `precedence` : 우선순위
---

### `전위 연산자 정의와 구현`

- ex) `Int`타입의 제곱을 구하는 전위 연산자 `**` 정의
    ``` Swift
    // [ 전위 연산자 구현과 사용 ]

    prefix operator **

    prefix func ** (value: Int) -> Int {
        return value * value
    }

    let minusFive: Int = -5
    let sqrtMinusFive: Int = **minusFive
    print(sqrtMinusFive) // 25
    ```

- ex) 문자열이 비어있는지 확인하는 전위 연산자 `!` 중복 정의
  - 전위 연산자 중 정수에 사용되는 느낌표(`!`)를 문자열에도 사용해준다.

  ``` Swift
  // [ 전위 연산자 함수 중복 정의와 사용 ]

  prefix func ! (value: String) -> Bool {
      return value.isEmpty
  }

  var stringValue: String = "kybeen"
  var isEmptyString: Bool = !stringValue
  print(isEmptyString) // false

  stringValue = ""
  isEmptyString = !stringValue
  print(isEmptyString) // true
  ```
---

### `후위 연산자 정의와 구현`

- ex) `Int`타입의 값 뒤에 `**`를 붙이면 10을 더해주는 연산
    ``` Swift
    // [ 사용자 정의 후위 연산자 정의와 함수 구현 ]
    postfix operator **

    postfix func ** (value: Int) -> Int {
        return value + 10
    }

    let five: Int = 5
    let fivePlusTen: Int = five**
    print(fivePlusTen) // 15
    ```

- **💡 하나의 피연산자에 전위 연산과 후위 연산을 한 줄에 사용하게 되면 후위 연산을 먼저 수행한다.**
---

### `중위 연산자 정의와 구현`
- 전위/후위 연산자 정의와 크게 다르지 않다.
- 다만 중위 연산자는 `우선순위 그룹`을 명시해줄 수 있다.
  - 연산자 우선순위 그룹은 `precedencegroup` 뒤에 그룹 이름을 써주어 정의할 수 있다. (기본값은 가장 높은 `DefaultPrecedence` 그룹)
  - `associativity` 기본값은 `none`임. 결합방향을 지정해 주지 않으면 연달아 사용할 수 없다.
  - `assignment`는 연산자가 옵셔널 체이닝을 포함한 연산에 포함되어 있을 경우 연산자의 우선순위를 지정한다.
    - `true`: 표준 라이브러리의 할당 연산자와 동일할 결합방향 규칙을 사용 (오른쪽 - 스위프트 기준)
  ``` Swift
  precedencegroup 우선순위 그룹 이름 {
    higherThan: 더 낮은 우선순위 그룹 이름
    lowerThan: 더 높은 우선순위 그룹 이름
    associativity: 결합방향 (left / right / none)
    assignment: 할당방향 사용 (true / false)
  }
  ```

- ex) 문자열과 문자열 사이에 `**` 연산자를 사용하면 뒤에 오는 문자열이 앞의 문자열 안에 속해 있는지 확인하는 연산
    ``` Swift
    // [ 중위 연산자의 정의/구현/사용 ]

    // String 타입의 contains(_:) 메서드를 사용하기 위해 임포트함
    import Foundation

    infix operator ** : MultiplicationPrecedence

    func ** (lhs: String, rhs: String) -> Bool {
        return lhs.contains(rhs)
    }

    let helloKybeen: String = "Hello kybeen"
    let kybeen: String = "kybeen"
    let isContainsKybeen: Bool = helloKybeen ** kybeen // true
    ```

- 💡 사용자가 직접 정의한 데이터 타입(클래스, 구조체 등)에서 유용하게 사용할 수 있는 연산자도 새로 정의하거나 중복 정의할 수 있다.
    ``` Swift
    // [ 클래스 및 구조체의 비교 연산자 구현 ]

    class Car {
        var modelYear: Int?     // 연식
        var modelName: String?  // 모델 이름
        
        // Car 클래스의 인스턴스끼리 == 연산했을 때 modelName이 같다면 true를 반환
        /*
        Car 타입에 국한된 연산자이기 때문에 타입 메서드로 구현 가능
        */
        static func == (lhs: Car, rhs: Car) -> Bool {
            return lhs.modelName == rhs.modelName
        }
    }

    let myCar = Car()
    myCar.modelName = "S"

    let yourCar = Car()
    yourCar.modelName = "S"

    print(myCar == yourCar) // true
    ```