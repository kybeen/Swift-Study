/* Chapter 3. 데이터 타입 기본 */
// 스위프트의 기본 데이터 타입은 모두 구조체를 기반으로 구현되어 있음

/* [ Int와 UInt ] */
/**
 - Int와 UInt는 각각 8비트, 16비트, 32비트, 64비트의 형태가 있음 (Int8, Int16, Int32, Int64, UInt8, UInt16, UInt32, UInt64)
    --> 시스템 아키텍처에 따라 Int와 UInt의 타입이 달라진다.
 - 각 타입의 최대,최솟값은 max, min 프로퍼티를 통해 확인 가능
 */
print("[ Int와 UInt ]")
var integer: Int = -100
let unsignedInteger: UInt = 50 // UInt 타입에는 음수값 할당할 수 없음
print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최댓값: \(Int.max), Int 최솟값: \(Int.min)")
print("UInt 최댓값: \(UInt.max), Int 최솟값: \(UInt.min)")
let largeInteger: Int64 = Int64.max
let smallUnsignedInteger: UInt8 = UInt8.max
print("Int64 최댓값: \(largeInteger), UInt8 최댓값: \(smallUnsignedInteger)")

//let tooLarge: Int = Int.max + 1 // Int의 표현 범위를 초과하므로 오류
//let cannotBeNegative: UInt = -5 // UInt는 음수가 될 수 없으므로 오류

//integer = unsignedInteger       // 오류 --> 스위프트에서 Int와 UInt는 엄연히 다른 타입으로 취급함
integer = Int(unsignedInteger)  // Int타입의 값으로 할당해주어야 함

// 진수별 정수 표현
let decimalInteger: Int = 28
let binaryInteger: Int = 0b11100    // 2진수로 10진수 28을 표현 (접두어 0b 사용)
let octalInteger: Int = 0o34        // 8진수로 10진수 28을 표현 (접두어 0o 사용)
let hexadecimalInteger: Int = 0x1C  // 16진수로 10진수 28을 표현 (접두어 0x 사용)


print()
/* [ Bool ] */
/**
 - 참(true) 또는 거짓(false)만 값으로 갖는 불리언 타입
 */
print("[ Bool ]")
var boolean: Bool = true
boolean.toggle() // true - false 반전



print()
/* [ Float과 Double ] */
/**
 - 부동소수점을 사용하는 실수 타입 (소수점 자리가 있는 수)
 
 - Double : 64비트의 부동소수 표현
 - Float: 32비트의 부동소수 표현
 필요에 따라 사용하는데 뭘 사용할지 애매하면 걍 Double 쓰는걸 권장
 */
print("[ Float과 Double ]")
var floatValue: Float = 1234567890.1 // Float이 수용할 수 있는 범위를 넘어서는 값이라서 감당할 수 만큼만 남기므로 정확도가 떨어짐
let doubleValue: Double = 1234567890.1
print("floatValue: \(floatValue) doubleValue: \(doubleValue)")


print()
/* [ 임의의 수 만들기 ] */
/**
 - Swift 4.2 버전부터 임의의 수를 만드는 random(in:) 메서드가 추가됨
 - 정수, 실수 모두 임의의 수를 만들 수 있음
 */
print("[ 임의의 수 만들기 ]")
print(Int.random(in: -100...100))
print(UInt.random(in: 1...30))
print(Double.random(in: 1.5...4.3))
print(Float.random(in: -0.5...1.5))




print()
/* [ Character ] */
/**
 - Character는 말 그대로 단 하나의 '문자'를 의미함
 - 스위프트는 유니코드 9 문자를 사용하므로 영어는 물론, 유니코드에서 지원하는 모든 언어 및 특수기호 등을 사용할 수 있음 (이모티콘, 한글 등...)
 */
print("[ Character ]")
let alphabetA: Character = "A"
print(alphabetA)

// Character 값에 유니코드 문자를 사용할 수 있음
let commandCharacter: Character = "🤩"
print(commandCharacter)



print()
/* [ String ] */
/**
 - String은 문자열 (문자의 나열)
 - Character와 마찬가지로 유니코드 9를 사용
 */
print("[ String ]")
// 이니셜라이저를 사용하여 빈 문자열 생성 가능
var introduce: String = String()

// append() 메서드로 문자열을 이어붙일 수 있음
introduce.append("제 이름은")

// + 연산자를 통해서도 문자열을 이어붙일 수 있음
introduce = introduce + " rei 입니다."
print(introduce)

// count 프로퍼티로 문자 수를 셀 수 있음
print("introduce의 글자 수: \(introduce.count)")

// 빈 문자열인지 확인 가능
print("introduce가 비어 있나요?: \(introduce.isEmpty)")

// 유니코드의 스칼라값을 사용하면 값에 해당하는 표현이 출력됨
let unicodeScalarValue: String = "\u{2665}"
print(unicodeScalarValue)


print()
/* [ String 타입의 다양한 기능 ] */
// 연산자를 통한 문자열 결합
print("[ String 타입의 다양한 기능 ]")
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





print()
/* [ 특수문자 사용 ] */
// 문자열 내에서 일정 기능을 하는 특수문자들
print("[ 특수문자 사용 ]")
print("문자열 내부에\n 이런 \"특수문자\"를 사용하면 \\ 이런 놀라운 결과를 볼 수 있습니다.")
print(#"문자열 내부에서 특수문자를 사용하기 싫다면 문자열 앞, 뒤에 #을 붙여주세요."#)
let number: Int = 100
print(#"특수문자를 사용하지 않을 때도 문자열 보간법을 사용하고 싶다면 이렇게 \#(number) 해보세요"#)





print()
/* [ Any, AntObject와 nil ] */
/**
 - Any는 스위프트의 모든 데이터 타입을 사용할 수 있다는 뜻
 - AnyObject는 Any보다는 한정된 의미로 클래스의 인스턴스만 할당 가능
 근데 굳이 사용하지는 않는게 나을듯
 
 - nil은 특정 타입이 아니라 '없음'을 나타내는 스위프트의 키워드임
 - 변수 또는 상수에 값이 들어있지 않고 비어있음을 나타내는 데 사용
 */
print("[ Any, AntObject와 nil ]")
var someVar: Any = "Rei"
someVar = 40
someVar = 10.3
