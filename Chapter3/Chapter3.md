# **Chapter 3. 데이터 타입 기본**

- 스위프트의 기본 데이터 타입은 구조체를 기반으로 구현되어 있다.
---

### 정수 타입 (Int, UInt)
- **`Int`** : +,- 부호를 포함한 정수
- **`UInt`** : - 부호를 포함하지 않는 0을 포함한 양의 정수
- 각각 8, 16, 32, 64비트의 형태가 있다. ex) `Int8`, `UInt16` ...
  - 시스템 아키텍쳐에 따라 기본 `Int`, `UInt`의 타입이 달라짐
  - 스위프트는 타입에 굉장히 엄격하기 때문에 플랫폼에 따른 `Int`의 최댓값 ~ `UInt`의 최댓값 사이의 값을 사용하게 되는 경우 이외에는 `UInt`보다는 `Int` 타입을 사용하는 것이 좋다.
    
    (두개 타입을 모두 사용할 경우 완전히 다른 타입으로 인식하기 때문에 정수 타입 변수끼리의 계산 시에도 많은 자원이 소모될 수 있음)

``` Swift
var integer: Int = -100
let unsignedInteger: UInt = 50 // UInt 타입에는 음수값 할당할 수 없음
print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최댓값: \(Int.max), Int 최솟값: \(Int.min)")
print("UInt 최댓값: \(UInt.max), Int 최솟값: \(UInt.min)")

let largeInteger: Int64 = Int64.max
let smallUnsignedInteger: UInt8 = UInt8.max
print("Int64 최댓값: \(largeInteger), UInt8 최댓값: \(smallUnsignedInteger)")

let tooLarge: Int = Int.max + 1 // Int의 표현 범위를 초과하므로 오류
let cannotBeNegative: UInt = -5 // UInt는 음수가 될 수 없으므로 오류

integer = unsignedInteger // Swift에서 Int와 UInt는 다른 타입이기 때문에 오류!!!
integer = Int(unsignedInteger) // 같은 타입의 값으로 변환 후 할당해주어야 함
```

```Swift
// 진수별 정수 표현
let decimalInteger: Int = 28        // 10진수
let binaryInteger: Int = 0b11100    // 2진수로 10진수 28을 표현 (접두어 0b 사용)
let octalInteger: Int = 0o34        // 8진수로 10진수 28을 표현 (접두어 0o 사용)
let hexadecimalInteger: Int = 0x1C  // 16진수로 10진수 28을 표현 (접두어 0x 사용)
```
---

### Bool 타입
``` Swift
var boolean: Bool = true
boolean.toggle() // true - false 반전
```
---

### 실수 타입 (Float, Double)
- `Float`과 `Double`은 부동소수점을 사용하는 실수 타입이며 부동소수 타입이라고 함
  - `Float` : 32비트 부동소수 표현
  - `Double` : 64비트 부동소수 표현
  - 무엇을 사용해야 할 지 잘 모르는 상황이라면 `Double` 사용 권장

``` Swift
// Float이 수용할 수 있는 범위를 넘어섬
// 감당 가능할 만큼만 남기므로 정확도가 떨어진다.
var floatValue: Float = 1234567890.1

// Double은 충분히 수용 가능
let doubleValue: Double = 1234567890.1

print("floatValue: \(floatValue) doubleValue: \(doubleValue)")


```
---

### 문자 타입 (Character)
- `Character` 타입은 '문자'를 의미한다.
- 유니코드에서 지원하는 모든 언어 및 특수기호 등을 사용 가능
  
``` Swift
let alphabetA: Character = "A"
print(alphabetA)
let 한글변수이름: Character = "ㄱ"
print("한글의 첫 자음: \(한글변수이름)")

// 유니코드 문자 사용 가능
let commandCharacter: Character = "♡"
print(commandCharacter)
```
---

### 문자열 (String)
- `String` 타입은 문자의 나열(문자열)을 의미
``` Swift
// 이니셜라이저를 사용하여 빈 문자열 생성
var introduce: String = String()

// 문자열 이어붙이기
introduce.append("제 이름은")
introduce = introduce + " " + "rei" + "입니다."
print(introduce)

// 문자 수 카운트
print("introduce의 글자 수: \(introduce.count)")
// 빈 문자열인지 확인
print("비어있나요?: \(introduce.isEmpty)")

// 유니코드의 스칼라값을 사용하면 값에 해당하는 표현이 출력됨
let unicodeScalarValue: String = "\u{2665}"
```

- String 타입의 다양한 기능
``` Swift
// 연산자를 통한 문자열 결합
var greeting: String = "Hello"
greeting += " "
greeting += "rei"
greeting += "!"
print(greeting)

// 연산자를 통한 문자열 비교
var isSameString: Bool = false

isSameString = "Hello"=="Hello"
print(isSameString) // true

isSameString = "hello"=="Hello"
print(isSameString) // false

// 메서드를 통한 접두어, 접미어 확인
var hasPrefix: Bool = false
hasPrefix = greeting.hasPrefix("Hello ")
print(hasPrefix) // true

var hasSuffix: Bool = false
hasSuffix = greeting.hasSuffix(" rei!")
print(hasSuffix)

// 메서드를 통한 대소문자 변환
var convertedString: String = ""
convertedString = greeting.uppercased()
print(convertedString)

convertedString = greeting.lowercased()
print(convertedString)

// 프로퍼티를 통한 빈 문자열 확인
var isEmptyString: Bool = false
isEmptyString = greeting.isEmpty
print(isSameString) // false

greeting = ""
isEmptyString = greeting.isEmpty
print(isEmptyString) // true

// 코드상에서 여러 줄에 문자열을 쓰고 싶다면 큰따옴표 3개를 사용
// 큰따옴표 3개를 써주고 한 줄을 내려써야 함 (마지막 줄도)
greeting = """
안녕하세요
감사해요
잘있어요
다시 만나요
"""
print(greeting)
```

- 특수문자
  - `\n` : 줄바꿈
  - `\\` : 백슬래시
  - `\"` : 큰따옴표
  - `\t` : 탭
  - `\O` : 문자열이 끝났음을 알리는 null 문자
---

### Any, AnyObject와 nil
- `Any` : 스위프트의 모든 데이터 타입을 사용할 수 있다는 뜻
- `AnyObject` : `Any`보다는 조금 한정된 의미로 클래스의 인스턴스만 할당 가능

``` Swift
var someVar: Any = "rei"
someVar = 50
someVar = 100.1
```

- `nil` : 특정 타입이 아니라 '없음'을 의미하는 스위프트의 키워드
- 변수 또는 상수에 값이 없는 경우(nil값일 경우), 해당 변수 또는 상수에 접근하게 되면 잘못된 메모리 접근으로 런타임 오류 발생