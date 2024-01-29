# **Chapter 25. 패턴**
> 📖 잘 정리된 글 : https://zeddios.tistory.com/274

- 스위프트에는 문법에 응용할 수 있는 다양한 종류의 `패턴(Pattern)`이 있다.
- 대부분의 패턴은 `switch`, `if`, `guard`, `for` 등의 키워드로 자주 활용되며 두 개 이상의 키워드가 합을 이뤄 동작한다.

- **`패턴`은 `'단독 또는 복합 값의 구조를 나타내는 것'`**
- **`패턴 매칭`은 `'코드에서 어떤 패턴의 형태를 찾아내는 행위'`**

  ---

- **💡 스위프트의 패턴은 크게 2 종류로 나뉜다.**
  - 👉 값을 해제(추출)하거나 무시하는 패턴
    - `와일드카드 패턴, 식별자 패턴, 값 바인딩 패턴, 튜플 패턴`
  - 👉 패턴 매칭을 위한 패턴
    - `열거형 케이스 패턴, 옵셔널 패턴, 표현 패턴, 타입캐스팅 패턴`
---


## 와일드카드 패턴 (Wildcard Pattern)
- **✅ 와일드카드 식별자 `_` 를 사용하면 `해당 와일드카드 식별자가 위치한 곳의 값을 무시`한다.**
``` Swift
// [ 와일드카드 패턴의 사용 ]

let string: String = "ABC"

switch string {
// ABC -> 어떤 값이 와도 상관없기에 항상 실행된다.
case _: print(string)
}

let optionalString: String? = "ABC"

switch optionalString {
// optionalString이 Optional("ABC") 일 때만 실행됨
case "ABC"?: print(optionalString)
    
// optionalString이 Optional("ABC") 외의 값이 있을 때만 실행
case _?: print("Has value, but not ABC")
    
// 값이 없을 때 실행
case nil: print("nil")
}
// Optional("ABC")

let rei = ("rei", 99, "Male")

switch rei {
// 첫 번째 요소가 "rei"일때만 실행
case ("rei", _, _): print("Hello rei!!")
    
// 그 외 언제든지 실행
case (_, _, _): print("Who cares~")
}
// Hello rei!!

for _ in 0..<2 {
    print("Hello")
}
// Hello
// Hello
```
---


## 식별자 패턴 (Identifier Pattern)
- **✅ `변수 또는 상수의 이름에 알맞는 값을 어떤 값과 매치`시키는 패턴**
- `값 바인딩 패턴`의 일종이라고 할 수도 있다.
``` Swift
// someValue의 타입인 Int와 할당하려는 42의 타입이 매치된다면 someValue는 42라는 값의 식별자가 된다.
let someValue: Int = 42
```
---


## 값 바인딩 패턴 (Value-Binding Pattern)
- **✅ `변수 또는 상수의 이름에 매치된 값을 바인딩`하는 패턴**
  - 값 바인딩 패턴의 일종인 `식별자 패턴`은 매칭되는 값을 `새로운 이름의 변수 또는 상수에 바인딩`한다.
``` Swift
// [ 값 바인딩 패턴의 사용 ]

let rei = ("rei", 99, "Male")

switch rei {
// name, age, gender를 rei의 각각의 요소와 바인딩
case let (name, age, gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
}
// Name: rei, Age: 99, Gender: Male

switch rei {
case (let name, let age, let gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
}
// Name: rei, Age: 99, Gender: Male

switch rei {
// 값 바인딩 패턴은 와일드카드 패턴과 결합하여 유용하게 사용될 수도 있다.
case (let name, _, let gender): print("Name: \(name), Gender: \(gender)")
}
// Name: rei, Gender: Male
```
---


## 튜플 패턴 (Tuple Pattern)
- **✅ 소괄호 `()` 내에 쉼표로 분리하는 리스트**
- 튜플 패턴은 그에 `상응하는 튜플 타입과 값을 매치`한다.
``` Swift
// [ 튜플 패턴의 사용 ]

let (a): Int = 2
print(a) // 2

let (x, y): (Int, Int) = (1, 2)
print(x) // 1
print(y) // 2

let name: String = "Jung"
let age: Int = 99
let gender: String? = "Male"

switch (name, age, gender) {
case ("Jung", _, _): print("Hello Jung!!")
case (_, _, "Male"?): print("Who are you man?")
default: print("I don't know who you are")
}
// Hello Jung!!

let points: [(Int, Int)] = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]

for (x, _) in points {
    print(x)
}
// 0
// 1
// 1
// 2
// 2
```
---


## 열거형 케이스 패턴 (Enumeration Case Pattern)
- **✅ 값을 열거형 타입의 `case`와 매치시킨다.**
- 만약 `연관 값`이 있는 열거형 케이스와 매치하려고 한다면 열거형 케이스 패턴에는 `반드시 튜플 패턴이 함께`해야 한다.
``` Swift
// [ 열거형 케이스 패턴의 사용 ]

let someValue: Int = 30

if case 0...100 = someValue {
    print("0 <= \(someValue) <= 100")
}
// 0 <= 30 <= 100

let anotherValue: String = "ABC"

if case "ABC" = anotherValue {
    print(anotherValue)
}
// ABC

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dishes: [MainDish] = []

var dinner: MainDish = .pasta(taste: "크림")
dishes.append(dinner)

if case .pasta(let taste) = dinner {
    print("\(taste) 파스타")
}
// 크림 파스타

dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dishes.append(dinner)

func whatIsThis(dish: MainDish) {
    guard case .pizza(let dough, let topping) = dish else {
        print("It's not a Pizza")
        return
    }
    
    print("\(dough) \(topping) 피자")
}
whatIsThis(dish: dinner)
// 치즈크러스트 불고기 피자

dinner = .chicken(withSauce: true)
dishes.append(dinner)

while case .chicken(let sauced) = dinner {
    print("\(sauced ? "양념" : "후라이드") 통닭")
    break
}
// 양념 통닭

dinner = .rice
dishes.append(dinner)

if case .rice = dinner {
    print("오늘 저녁은 밥입니다.")
}
// 오늘 저녁은 밥입니다.

for dish in dishes {
    switch dish {
    case let .pasta(taste): print(taste)
    case let .pizza(dough, topping): print(dough, topping)
    case let .chicken(sauced): print(sauced ? "양념" : "후라이드")
    case .rice: print("Just 쌀")
    }
}
/*
 크림
 치즈크러스트 불고기
 양념
 Just 쌀
 */
```
---


## 옵셔널 패턴 (Optional Pattern)
- **✅ `옵셔널 또는 암시적 추출 옵셔널 열거형에 감싸져 있는 값`을 매치시킬 때 사용**
- 식별자 패턴 뒤에 `?`를 넣어 표기하며 `열거형 케이스 패턴과 동일한 자리에 위치`한다.
``` Swift
// [ 옵셔널 패턴의 사용 ]

var optionalValue: Int? = 100

if case .some(let value) = optionalValue {
    print(value)
}
// 100

if case let value? = optionalValue {
    print(value)
}
// 100

func isItHasValue(_ optionalValue: Int?) {
    guard case .some(let value) = optionalValue else {
        print("none")
        return
    }
    
    print(value)
}
isItHasValue(optionalValue) // 100

while case .some(let value) = optionalValue {
    print(value)
    optionalValue = nil
}
// 100

print(optionalValue) // nil

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a 2
// Found a 3
// Found a 5

for case let number in arrayOfOptionalInts {
    print("Found a \(number)")
}
// Found a nil
// Found a Optional(2)
// Found a Optional(3)
// Found a nil
// Found a Optional(5)
```
---


## 타입캐스팅 패턴 (Type-Casting Pattern)
- `is` 패턴과 `as` 패턴이 있음
  - `is` 패턴은 `switch`의 `case` 레이블에서만 사용할 수 있다.
  - **✅ `is` 패턴은 `is (TYPE_NAME)` 과 같이 쓸 수 있다.**
  - **✅ `as` 패턴은 `SomePattern as (TYPE_NAME)` 과 같이 쓸 수 있다.**

- 타입캐스팅 파턴은 `타입캐스팅`을 하거나 `타입을 매치`시킨다.
  - **`is` 👉 프로그램 실행 중에 값의 타입이 `is` 우측에 쓰여진 타입 또는 그 타입의 자식클래스 타입이면 값과 매치 (`as` 연산자와 비슷한 역할을 하지만 반환된 결괏값을 신경쓰지 않는다는 차이가 있음)**
  - **`as` 👉 프로그램 실행 중에 값의 타입이 `as` 우측에 쓰여진 타입 또는 그 타입의 자식클래스 타입이면 값과 매치시킨다. 만약 `매치된다면 매치된 값의 타입은 as 패턴이 원하는 타입으로 캐스팅`된다.**

``` Swift
// [ 타입캐스팅 패턴의 사용 ]

let someValue: Any = 100

switch someValue {
// 타입이 매치되는지 확인하지만 캐스팅된 값을 사용할 수는 없다.
case is String: print("It's String!")
    
// 타입 확인과 동시에 캐스팅까지 완료되어 value에 저장된다.
// 값 바인딩 패턴과 결합된 모습
case let value as Int: print(value + 1)
    
default: print("Int도 String도 아닙니다.")
}
// 101
```
---


## 표현 패턴 (Expression Pattern)
- `표현식의 값을 평가한 결과를 이용`하는 패턴
- `switch` 구문의 `case` 레이블에서만 사용할 수 있다.
- **✅ 스위프트 표준 라이브러리의 `패턴 연산자`인 `~=` 연산자의 연산 결과가 `true`를 반환하면 매치시킨다.**
  - 👉 `~=` 연산자는 `같은 타입의 두 값을 비교할 때` `==` 연산자를 사용한다.
  - 👉 표현 패턴은 정숫값과 정수의 범위를 나타내는 `Range` 객체와 매치시킬 수도 있다.

- **💡 표현 패턴은 `~= 연산자를 중복 정의(Overload)`하거나, `~= 연산자를 새로 정의`하거나, `자신이 만든 타입에 ~= 연산자를 구현`해준다면 원하는대로 패턴을 완성시킬 수 있기 때문에 매우 유용한 패턴 중 하나이다. `제네릭`까지 추가하면 활용도는 더욱 높아진다.**

``` Swift
// [ 표현 패턴의 사용 ]

switch 3 {
case 0...5: print("0과 5 사이")
default: print("0보다 작거나 5보다 큽니다.")
}
// 0과 5 사이

var point: (Int, Int) = (1, 2)

// 같은 타입 간의 비교이므로 == 연산자를 사용하여 비교할 것이다.
switch point {
case (0, 0): print("원점")
case (-2...2, -2...2): print("\(point.0), \(point.1)은 원점과 가깝습니다.")
default: print("point \(point.0), \(point.1)")
}
// 1, 2은 원점과 가깝습니다.

// String 타입과 Int 타입이 매치될 수 있도록 ~= 연산자를 정의한다.
func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}

point = (0, 0)

// 새로 정의된 ~= 연산자를 사용하여 비교
switch point {
// ~= 연산자는 패턴매칭을 위해 case문에서 내부적으로 사용된다.
case ("0", "0"): print("원점")
default: print("point (\(point.0), \(point.1)")
}
// 원점

struct Person {
    var name: String
    var age: Int
}

let lingo: Person = Person(name: "Lingo", age: 99)
func ~= (pattern: String, value: Person) -> Bool {
    return pattern == value.name
}
func ~= (pattern: Person, value: Person) -> Bool {
    return pattern.name == value.name && pattern.age == value.age
}

switch lingo {
case Person(name: "Lingo", age: 99): print("Same Person!!")
case "Lingo": print("Hello Lingo!!")
default: print("I don't know who you are")
}
// Same Person!!
```

``` Swift
// [ 제네릭을 사용한 표현 패턴 활용 ]

// 제네릭을 사용하기 위해 프로토콜을 정의한다.
protocol Personalize {
    var name: String { get }
    var age: Int { get }
}

struct Person: Personalize {
    var name: String
    var age: Int
}

let star: Person = Person(name: "Star", age: 99)

// 제네릭을 사용하여 패턴 연산자를 정의한다.
func ~=<T: Personalize>(pattern: String, value: T) -> Bool {
    return pattern == value.name
}

func ~=<T: Personalize>(pattern: T, value: T) -> Bool {
    return pattern.name == value.name && pattern.age == value.age
}

// 이전 예시코드의 패턴 연산자가 없더라도 제네릭 패턴 연산자로 똑같이 사용할 수 있다.
switch star {
case Person(name: "Star", age: 99): print("Same Person!!")
case "Star": print("Hello Star!!")
default: print("I don't know who you are")
}
// Same Person!!

// 제네릭을 사용하여 패턴 연산자를 정의
func ~=<T: Personalize>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

// 패턴에 사용할 제네릭 함수
func young<T: Personalize>(value: T) -> Bool {
    return value.age < 50
}

switch star {
// 패턴결합을 하면 young(star)와 같은 효과를 본다.
case young: print("\(star.name) is young")
default: print("\(star.name) is old")
}
// Star is old

// 패턴에 사용할 제네릭 함수
func isNamed<T: Personalize>(_ pattern: String) -> ((T) -> Bool) {
    return { (value: T) -> Bool in value.name == pattern }
    // 패턴과 값을 비교할 클로저를 반환
}

switch star {
// 패턴결합을 하면 isNamed("Jung")(star)와 같은 효과를 본다.
case isNamed("Jung"): print("He is Jung")
default: print("Another person")
}
// Another person

// 연산자가 함수라는 점을 생각해보면 이런 방식으로 구현할 수도 있다.
prefix operator ==?

prefix func ==? <T: Personalize>(pattern: String) -> ((T) -> Bool) {
    return isNamed(pattern)
}

switch star {
    // 패턴결합을 하면 isNamed("Jung")(star)와 같은 효과를 본다.
case ==?"Jung": print("He is Jung")
default: print("Another person")
}
// Another person
```