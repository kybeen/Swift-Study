# **Chapter 4. 데이터 타입 고급**

### 데이터 타입 안심
- 스위프트는 타입에 굉장히 민감하고 엄격함 (`Type-safe 언어`)
- 서로 다른 타입끼리의 데이터 교환은 꼭 `타입캐스팅(Type-Casting)`을 거쳐야 함
- 스위프트에서는 컴파일 시 타입 확인을 지원하기 때문에 서로 다른 타입의 값을 할당하려고 할 때 컴파일 오류로 알려준다.

- 스위프트는 타입 추론을 지원함
``` Swift
// 타입 추론을 통해 String 타입으로 선언
var name = "Rei"

// 정수 타입 값 할당 시 오류
name = 100
```
---

### 타입 별칭
- `typealias` 키워드로 이미 존재하는 데이터 타입에 임의로 다른 이름(별칭) 부여 가능
- 기본 타입과 이후에 추가한 별칭을 모두 사용 가능하다.

``` Swift
typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2080
// MyInt도, YourInt도 Int이기 때문에 같은 타입으로 취급
year = age

let month: Int = 7 // 기존의 Int도 사용 가능
```
---

### 튜플(Tuple)
- `Tuple`은 타입의 이름이 따로 지정되어 있지 않은, 프로그래머 마음대로 만드는 타입이다. 
- `지정된 데이터의 묶음`이라고 표현할 수 있음
- 파이썬의 튜플과 유사
- 일정 타입의 나열만으로 튜플 타입을 생성해줄 수 있다.

``` Swift
// String, Int, Double 타입을 갖는 튜플
var person: (String, Int, Double) = ("rei", 100, 182.5)

// 인덱스로 값을 빼올 수 있다.
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")
// 인덱스로 값 할당 가능
person.1 = 99
person.2 = 178.5
```

- 튜플의 각 요소의 데이터가 무엇을 나타내는지 쉽게 파악할 수 있도록 이름을 붙여줄 수 있다.
``` Swift
// String, Int, Double 타입을 갖는 튜플
var person: (name: String, age: Int, height: Double) = ("rei", 100, 182.5)

// 요소 이름을 통해 값을 빼올 수 있다.
print("이름: \(person.name), 나이: \(person.age), 신장: \(person.height)")
// 요소 이름을 통해 값 할당 가능
person.age = 99
person.2 = 178.5 // 인덱스를 통해서도 가능
```

- 타입 별칭을 사용하여 튜플 별칭을 지정하면 편하게 사용 가능
``` Swift
typealias PersonTuple = (name: String, age: Int, height: Double)

let rei: PersonTuple = ("rei", 100, 178.5)
```
---

### 컬렉션형
- 많은 수의 데이터를 묶어서 저장하고 관리할 수 있는 컬렉션 타입
- `배열(Array)`, `딕셔너리(Dictionary)`, `세트(Set)` 등이 있다.
  - String도 컬렉션임

### `배열(Array)`
- 배열 사용 시에는 `Array` 키워드와 타입 이름의 조합으로 사용
- 대괄호(`[]`)로 값을 묶어 표현하는 것도 가능

``` Swift
// 배열의 선언과 생성
var names: Array<String> = ["rei", "chulsoo", "kybeen"]
var names: [String] = ["rei", "chulsoo", "kybeen"] // 위와 동일한 축약 표현

var emptyArray: [Any] = [Any]() // Any 데이터를 요소로 갖는 빈 배열 생성
var emptyArray: [Any] = Array<Any>() // 위와 같은 코드

// 배열의 타입을 정확히 명시했다면 [] 만으로도 빈 배열 생성 가능
var emptyArray: [Any] = []

// 배열이 비어있는지 확인
print("\(emptyArray.isEmpty)") // true
// 배열 요소 개수 확인
print("\(names.count)") // 3
```

- 배열의 사용
``` Swift
// 배열의 맨 뒤에 요소 추가
names.append("youngbin")
names.append(contentsOf: ["rr", "bb"])

// 배열의 특정 인덱스에 요소 삽입
names.insert("happy", at: 2) // 인덱스 2에 삽입
names.insert(contentsOf: ["yy", "kk"], at: 5)

// 특정 요소의 인덱스 검색
print(names.firstIndex(of: "rei")) // 0
print(names.firstIndex(of: "minjae")) // nil

// 첫번째, 마지막 요소 확인
print(names.first)
print(names.last)

// 첫번째, 마지막 요소 제거
let firstItem: String = names.removeFirst()
let lastItem: String = names.removeLast()
// 특정 인덱스 요소 제거
let indexZeroItem: String = names.remove(at: 0)

// 배열의 일부만 확인
print(names[1 ... 3])
```

### `딕셔너리(Dictionary)`
- 요소들이 순서 없이 `키와 쌍`으로 구성되는 컬렉션 타입
``` Swift
// [ 딕셔너리의 선언과 생성 ]

// typealias로 편리하게 사용 가능
typealias StringIntDictionary = [String: Int]

// 키는 String, 값은 Int타입인 빈 딕셔너리를 생성
var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()
var numberForName: [String: Int] = [String: Int]() // 위와 같은 축약 표현
var numberForName: StringIntDictionary = StringIntDictionary() // typealias를 활용한 위와 같은 표현

// 키:값의 타입을 정확히 명시해줬다면 [:]만으로도 빈 딕셔너리 생성 가능
var numberForName: [String: Int] = [:]

// 초기값과 함께 생성
var numberForName: [String: Int] = ["rei": 100, "kybeen": 20, "yb": 600]

print(numberForName.isEmpty) // false
print(numberForName.count) // 3
```

- 딕셔너리의 사용
``` Swift
print(numberForName["rei"]) // 100
print(numberForName["minjae"]) // 딕셔너리 내부에 없는 키로 접근 시 nil 반환

// 새로운 키:값 추가
numberForName["max"] = 999

// 특정 키의 값 제거
print(numberForName.removeValue(forKey: "kybeen")) // 20

// 특정 키에 해당하는 값이 없을 경우 기본값을 반환하도록 하기
print(numberForName["kybeen", default: 0]) // 0
```

### `세트(Set)`
- 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 형태의 컬렉션 타입
- 세트 내에는 중복된 값이 존재하지 않는다.
- `순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우`에 주로 사용
- 세트의 요소로는 `해시 가능한 값`이 들어와야 한다.

``` Swift
// [ 세트의 선언과 생성 ]
// 세트는 배열과 달리 축약형 표현이 없다. ex) [String]
var names: Set<String> = Set<String>() // 빈 세트 생성
var names: Set<String> = [] // 빈 세트 생성

var names: Set<String> = ["rei", "kybeen", "yb", "rei"]

// 타입 추론을 사용하게 되면 컴파일러는 Set이 아닌 Array로 타입을 지정하게 된다.
var numbers = [100, 200, 300]
print(type(of: numbers)) // Array<Int>

print(names.isEmpty) // false
print(names.count) // 3 - 중복된 값은 허용되지 않아 "rei"는 1개만 남는다.
```

- 세트의 사용
``` Swift
// 요소 추가
names.insert("minjae")

// 요소 삭제 - 요소가 삭제된 후 반환된다.
print(names.remove("kybeen")) // kybeen
print(names.remove("son")) // nil
```

- 세트는 집합관계를 표현하고자 할 때 유용하게 사용 가능
``` Swift
// [ 세트의 활용 - 집합연산 ]
let englishClassStudents: Set<String> = ["john", "chulsoo", "yagom"]
let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo", "hana", "minsoo"]

// 교집합 {"yagom", "chulsoo"}
let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)
// 여집합의 합 (배타적 논리합) {"john", "jenny", "hana", "minsoo"}
let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)
// 합집합 {"minsoo", "jenny", "john", "yagom", "chulsoo", "hana"}
let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)
// 차집합 {"john"}
let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)

// 정렬된 배열 반환
print(unionSet.sorted()) // ["chulsoo", "hana", "jenny", "john", "minsoo", "yagom"]
```
``` Swift
// [ 세트의 활용 - 포함관계 연산 ]
let 새: Set<String> = ["비둘기", "닭", "기러기"]
let 포유류: Set<String> = ["사자", "호랑이", "곰"]
let 동물: Set<String> = 새.union(포유류) // 새와 포유류의 합집합

print(새.isDisjoint(with: 포유류)) // 서로 배타적인지 - true
print(새.isSubset(of: 동물)) // 새가 동물의 부분집합인지 - true
print(동물.isSuperset(of: 포유류)) // 동물이 포유류의 전체집합인지 - true
print(동물.isSuperset(of: 새)) // 동물이 새의 전체집합인지 - true
```

### 컬렉션에서 임의의 요소 추출하기
``` Swift
array.randomElement() // 임의의 요소
array.shuffle() // array 배열 자체를 임의의 순서로 섞기
array.shuffled() // 임의의 순서로 섞인 새로운 배열 반환 (arry는 그대로)
```
---

### 열거형
- 연관된 항목들을 묶어서 표현할 수 있는 타입
- 스위프트의 열거형은 항목별로 값을 가질 수도, 가지지 않을 수도 있다.

``` Swift
// [ 열거형의 선언 ]
enum School {
    case primary        // 유치원
    case elementary     // 초등
    case middle         // 중등
    case high           // 고등
    case college        // 대학
    case university     // 대학교
    case graduate       // 대학원
}
```
``` Swift
// [ 열거형 변수의 생성 및 값 변경 ]
var highestEducationLevel: School = School.university
var highestEducationLevel: School = .university // 위와 같은 표현
```

- 열거형의 각 항목은 자체로도 하나의 값이지만, 각 항목의 `원시 값(Raw Value)`도 가질 수 있다.
- 일부 항목만 원시 값을 줄 수도 있다.
  - ex) 일부 항목에만 String 타입의 원시 값을 지정해주면 나머지 항목들은 각 항목의 이름을 그대로 원시 값으로 갖게 된다.
``` Swift
// [ 열거형의 원시 값 지정과 사용 ]
enum School {
    case primary = "유치원"
    case elementary = "초등"
    case middle = "중등"
    case high = "고등"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let highestEducationLevel: School = School.university
print("저의 최종학력은 \(highestEducationLevel.rawValue) 졸업입니다.")
// 저의 최종학력은 대학교 졸업입니다.
```
``` Swift
// [ 원시 값을 통한 열거형 초기화 ]
let primary = School(rawValue: "유치원") // primary
```

- 열거형 내의 항목(case)은 자신과 연관된 `연관 값`을 가질 수 있다.
- 연관 값은 각 항목 옆에 `소괄호로 묶어 표현`
``` Swift
// [ 연관 값을 갖는 열거형 ]
enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: "토마토")
dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dinner = .chicken(withSauce: true)
dinner = .rice
```

- 열거형에 포함된 모든 케이스를 알아야 할 때 `CaseIterable`프로토콜을 채택하면 모든 케이스의 컬렉션을 사용할 수 있다.
``` Swift
// [ CaseIterable 프로토콜으르 활용한 열거형의 항목 순회 ]
enum School: CaseIterable {
    case primary    
    case elementary 
    case middle     
    case high       
    case college    
    case university 
    case graduate    
}

let allCases: [School] = School.allCases // School 열거형의 모든 값이 들어 있는 배열
```

- `순환 열거형`은 열거형 항목의 연관 값이 자신의 값이고자 할 때 사용한다.
- 순환 열거형을 명시할 때는 `indirect` 키워드 사용
  - `indirect` 키워드는 이진 탐색 트리 등의 순환 알고리즘을 구현할 때 유용하게 사용할 수 있다.
``` Swift
// [ 특정 항목에 순환 열거형 항목 명시 ]
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```
``` Swift
// [ 열거형 전체에 순환 열거형 명시 ]
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}
```
``` Swift
// [ 순환 열거형의 사용 ]
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

// ArithmeticExpression 열거형의 계산을 도와주는 순환 함수(Recursive Function)
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5 + 4) * 2 = \(result)") // (5 + 4) * 2 = 18
```

- `Comparable` 프로토콜을 준수하는 연관 값만 갖거나 연관 값이 없는 열거형은 `Comparable` 프로토콜 채택을 통해 각 케이스를 비교할 수 있다.
  - 앞에 위치한 케이스가 더 작은 값이 된다.
``` Swift
// [ 비교 가능한 열거형의 사용 ]
enum Condition: Comparable {
    case terrible
    case bad
    case good
    case great
}
let myCondition: Condition = Condition.great
let yourCondition: Condition = Condition.bad

if myCondition >= yourCondition {
    print("제 상태가 더 좋군요")
} else {
    print("당신의 상태가 더 좋아요")
}
// 제 상태가 더 좋군요


enum Device: Comparable {
    case iPhone(version: String)
    case iPad(version: String)
    case macBook
    case iMac
}
var devices: [Device] = []
devices.append(Device.iMac)
devices.append(Device.iPhone(version: "14.3"))
devices.append(Device.iPhone(version: "6.1"))
devices.append(Device.iPad(version: "10.3"))
devices.append(Device.macBook)

let sortedDevices: [Device] = devices.sorted() // 정렬된 devices 배열 반환 (기존 devices 배열은 그대로)
print(sortedDevices)
// [Device.iPhone(version: "14.3"), Device.iPhone(version: "6.1"), Device.iPad(version: "10.3"), Device.macBook, Device.iMac]
```