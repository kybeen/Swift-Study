# **Chapter 6. 흐름 제어**

## 조건문

### `if 구문`
- 스위프트의 if 구문은 조건의 값이 반드시 `Bool 타입`이어야 한다.

``` Swift
// [ if문 기본 구현 ]

let first: Int = 5
let second: Int = 7

if first > second {
    print("first > second")
} else if first < second {
    print("first < second")
} else {
    print("first == second")
}
```

 ### `switch 구문`
 - 스위프트의 `switch` 구문에서 `break` 키워드 사용은 선택 사항
   - `case` 내부의 코드를 모두 실행하면 `break` 없이도 `switch` 구문이 종료된다.
 - **스위프트에서 `switch` 구문의 case를 연속 실행하려면 `fallthrough` 키워드를 사용해야 한다.**
 - 비교될 값이 열거형처럼 명확히 한정적인 값이 아닐 때는 `default`를 필수로 작성해줘야 한다.
 - `case`에는 범위 연산자와 `where` 절도 사용 가능하다.

``` Swift
// [ switch 구문 기본 구현 ]

let integerValue: Int = 5

switch integerValue {
case 0:
    print("Value == zero")
case 1...10:
    print("Value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < Value <= 100")
}

// 결과
// Value == 1~10
// Value < 0 or Value > 100
```

``` Swift
// [ 값 바인딩을 사용한 튜플 switch case 구성 ]

typealias NameAge = (name: String, age: Int)

let tupleValue: NameAge = ("rei", 25)

switch tupleValue {
case ("rei", 25):
    print("정확히 맞췄습니다!")
case ("rei", let age):
    print("이름만 맞았습니다. 나이는 \(age)입니다.")
case (let name, 25):
    print("나이만 맞았습니다. 이름은 \(name)입니다.")
default:
    print("누굴 찾나요?")
}
```

- `where` 키워드를 사용하여 `case`의 조건을 확장할 수 있다.
    ``` Swift
    // [ where를 사용하여 switch case 확장 ]

    let 직급: String = "사원"
    let 연차: Int = 1
    let 인턴인가: Bool = false

    switch 직급 {
    case "사원" where 인턴인가 == true:
        print("인턴입니다.")
    case "사원" where 연차 < 2 && 인턴인가 == false:
        print("신입사원입니다.")
    case "사원" where 연차 > 5:
        print("연식 좀 된 사원입니다.")
    case "사원":
        print("사원입니다.")
    case "대리":
        print("대리입니다.")
    default:
        print("사장입니까?")
    }
    ```

- 열거형에 대한 `switch` 구문 작성 시 나중에 열거형에 `case`가 추가될 경우를 대비하고 싶다면 `unknown` 속성을 활용해준다.
    ``` Swift
    enum Menu {
    case chicken
    case pizza
    case hamburger // 열거형에 새로 추가된 case
    }

    let lunchMenu: Menu = .chicken

    switch lunchMenu {
    case .chicken:
        print("반반 무많이")
    case .pizza:
        print("핫소스 많이 주세요")
    /* @unknown 속성을 부여하면 switch 구문이 모든 case에 대응하지 않는다는 컴파일러 경고가 나온다. */
    @unknown case _:
        print("오늘 메뉴가 뭐죠?")
    }
    ```
---

## 반복문
- 다른 언어와 마찬가지로 `continue`, `break` 등의 제어 키워드 사용이 가능하다.

### `for~in 구문`
``` Swift
// [ for~in 반복 구문의 활용 ]

for i in 0...2 {
    print(i)
}
// 0
// 1
// 2

// Dictionary
let friends: [String: Int] = ["Jay": 35, "Joe": 29, "Jenny": 31]

for tuple in friends {
    print(tuple)
}
// ("Joe", 29)
// ("Jay", 35)
// ("Jenny", 31)
```
---

### `while 구문`
``` Swift
// [ while 반복 구문의 사용 ]

var names: [String] = ["Joker", "Jenny", "Nova", "rei"]

while names.isEmpty == false {
    print("Good byd \(names.removeFirst())")
}
// Good bye Joker
// Good bye Jenny
// Good bye Nova
// Good bye rei
```
---

### `repeat-while 구문`
- 다른 프로그래밍 언어의 `do-while` 구문과 크게 다르지 않다.
- `repeat` 블록의 코드를 최초 1회 실행한 후, `while` 다음의 조건이 성립하면 블록 내부의 코드를 반복 실행한다.

``` Swift
// [ repeat-while 반복 구문의 사용 ]

var names: [String] = ["Joker", "Jenny", "Nova", "rei"]

repeat {
    print("Good byd \(names.removeFirst())")
} while names.isEmpty == false
// Good bye Joker
// Good bye Jenny
// Good bye Nova
// Good bye rei
```
---

## 구문 이름표
- 반복문 앞에 이름과 함께 콜론을 붙여 이름을 지정해주는 `구문 이름표`를 사용할 수 있다.
- 구문 이름표를 통해 구문의 이름을 지정해주면 이후 반복문 등의 구문 제어 시 더 편리하고 가독성 있게 코드를 작성할 수 있다.

``` Swift
// [ 중첩된 반복문의 구문 이름표 사용 ]
var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }

    var count: Int = 0

    printLoop: while true {
        
        print(num)
        count += 1

        if count == num {
            break printLoop
        }
    }

    removeLoop: while true {
        if numbers.first != num {
            break numbersLoop
        }
        numbers.removeFirst()
    }
}
// 3
// 3
// 3
// numbers에는 [2342, 6, 3252]가 남는다.
```