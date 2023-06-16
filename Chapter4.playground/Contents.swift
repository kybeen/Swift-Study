/* Chapter 4. 데이터 타입 고급 */
/**
 - 스위프트는 타입에 굉장히 민갑하고 엄격함
 - 서로 다른 타입끼리의 데이터 교환은 꼭 타입캐스팅(Type-Casting)을 거쳐야 함
 - 스위프트에서 값 타입의 데이터 교환은 엄밀히 말하면 타입캐스팅이 아닌 새로운 인스턴스를 생성하여 할당하는 것임
 
 [ 타입 확인 ]
 - 스위프트는 컴파일 시 데이터의 타입을 확인해서 서로 다른 타입의 값을 할당하는 실수를 방지해줌
 */


/* [ 타입 추론 ] */
// - 스위프트에서는 변수나 상수를 선언할 때 특정 타입을 명시하지 않아도 컴파일러가 할당된 값을 기준으로 변수나 상수의 타입을 결정함
var name = "Kybeen" // 타입을 지정하지 않았으나 타입 추론을 통하여 name은 String 타입으로 선언됨
// name = 100 // 앞서 타입 추론에 의해 String 타입 변수로 지정되었기 때문에 오류 발생




/* [ 타입 별칭 ] */
// - 스위프트에서 기본으로 재공하는 데이터 타입이든, 사용자가 임의로 만든 데이터 타입이든 이미 존재하는 데이터 타입에 임의로 다른 이름(별칭)을 부여할 수 있음.
typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2080
// MyInt도, YourInt도 Int이기 때문에 같은 타입으로 취급
year = age

let month: Int = 7 // 기존의 Int도 사용 가능
let percentage: MyDouble = 99.9




/* [ 튜플(Tuple) ] */
// - 튜플은 타입의 이름이 따로 지정되어 있지 않은, 프로그래머 마음대로 만드는 타입
// - '지정된 데이터의 묶음'이라고 표현할 수 있음
// - 튜플은 타입 이름이 따로 없으므로 일정 타입의 나열만으로 튜플 타입을 생성해줄 수 있음
print("[ 튜플(Tuple) ]")

// String, Int, Double 타입을 갖는 튜플
var person: (String, Int, Double) = ("yagom", 100, 182.5)

// 인덱스를 통해 값을 빼올 수 있음
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")
person.1 = 99
person.2 = 178.5
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

// - 인덱스로 접근 시에 튜플의 각 요소가 어떤 의미가 있는지 유추하기 힘듦
// - 그래서 튜플의 요소마다 이름을 붙여줄 수도 있음

// String, Int, Double 타입을 갖는 튜플
var person2: (name: String, age: Int, height: Double) = ("Kybeen", 26, 190.5)

// 요소 이름을 통해서 값을 빼올 수 있음
print("이름: \(person2.name), 나이: \(person2.age), 신장: \(person2.height)")
person2.age = 99
person2.2 = 180.4 // 기존처럼 인덱스로 접근도 가능함


// - 튜플에는 타입 이름 키워드가 따로 없기 때문에 타입 별칭을 사용하여 조금 더 깔끔하고 안전하게 코드를 작정할 수 있다.
typealias PersonTuple = (name: String, age: Int, height: Double)
let yagom: PersonTuple = ("yagom", 100, 178.6)
let eric: PersonTuple = ("eric", 150, 183.5)
print("이름: \(yagom.name), 나이: \(yagom.age), 신장: \(yagom.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")





print()
/* [ 컬렉션형 ] */
// - 스위프트는 튜플 외에도 많은 수의 데이터를 묶어서 저장하고 관리할 수 있는 컬렉션 타입을 제공함
// - 컬렉션 타입에는 배열(Array), 딕셔너리(Dictionary), 세트(Set) 등이 있음
print("[ 컬렉션형 ]")

print()
// [ 배열(Array) ]
/**
 - 배열은 같은 타입의 데이터를 일렬로 나열한 후 순서대로 저장하는 형태의 컬렉션 타입
 
 <프로퍼티>
 - .isEmpty : 비어있는 배열인지 확인 가능
 - .count : 요소 개수 확인 가능
 - .first, .last : 첫번째와 마지막 요소
 
 <메서드>
 - firstIndex(of:) : 해당 요소의 인덱스를 알아낼 수 있음 (중복된 요소가 있다면 제일 먼저 발견된 요소의 인덱스 반환
 - append(_:)  : 맨 뒤에 요소 추가
 - insert(_:at:) : 중간에 요소 삽입
 - remove(_:) : 요소 삭제(해당 요소가 삭제된 후 반환)
 */
//NOTE: 스위프트의 Array는 C언어의 배열처럼 버퍼(Buffer)임. 단, C언어처럼 한 번 선언하면 크기가 고정되던 버퍼가 아니라, 필요에 따라 자동으로 버퍼의 크기를 조절해주므로 요소의 삽입 및 삭제가 자유롭다.

print("[ 배열(Array) ]")
var names: Array<String> = ["yagom", "chulsoo", "younghee", "yagom"]
var names2: [String] = ["yagom", "chulsoo", "younghee", "yagom"] // 위와 동일한 표현

var emptyArray: [Any] = [Any]() // Any 데이터를 요소로 갖는 빈 배열 생성
var emptyArray2: [Any] = Array<Any>() // 위와 동일한 표현

// 배열의 타입을 정확히 명시했다면 []만으로도 빈 배열을 생성할 수 있음
var emptyArray3: [Any] = []
print(emptyArray3.isEmpty) // true
print(names.count) // 4

print(names[2]) // younghee
names[2] = "jenny"
print(names2[2]) // jenny
// names[4] = "elsa" // 인덱스의 범위를 벗어났기 때문에 오류바랭
names.append("elsa")
names.append(contentsOf: ["john", "max"]) // 맨 마지막에 john과 max가 추가됨
names.insert("happy", at: 2) // 인덱스 2에 삽입됨
names.insert(contentsOf: ["jinhee", "minsoo"], at: 5) // 인덱스 5의 위치에 jinhee와 minsoo가 삽입됨

print(names[4]) // yagom
print(names.firstIndex(of: "yagom")) // 0
print(names.firstIndex(of: "christal")) // nil
print(names.first) // yagom
print(names.last) // max

let firstItem: String = names.removeFirst() // 첫번째 요소인 yagom이 제거됨
let lastItem: String = names.removeLast() // 마지막 요소인 max가 제거됨
let indexZeroItem: String = names.remove(at: 0) // 첫번째 인덱스의 chulsoo가 제거됨

print(firstItem)
print(lastItem)
print(indexZeroItem)
// 범위 연산자를 사용해서 배열의 일부만 갖고오기
print(names[1...3]) // ["jenny", "yagom", "jinhee"]


print()
/* [ 딕셔너리(Dictionary) ] */
/**
 - 요소들이 순서 없이 키:쌍 으로 구성되는 컬렉션 타입
 
 <프로퍼티>
 - .isEmpty : 비어 있는지
 - .count : 요소 개수

 <메서드>
 - removeValue(forKey:) : 특정 키에 해당하는 값 제거 (해당 값이 제거된 후 반환됨)
 */

print("[ 딕셔너리(Dictionary) ]")
// typealias를 통해 조금 더 단순하게 표현해볼 수도 있음
typealias StringIntDictionary = [String: Int]
// 키는 String, 값은 Int 타입인 빈 딕셔너리를 생성함
var numberForName: Dictionary<String, Int> = Dictionary<String, Int>()
var numberForName2: [String: Int] = [String: Int]() // 위 선언과 같은 표현
var numberForName3: StringIntDictionary = StringIntDictionary() // 위와 같음

// 딕셔너리의 키와 값 타입을 정확히 명시했다면 [:]만 써도 빈 딕셔너리 생성 가능
var numberForName4: [String: Int] = [:]

var numberForName5: [String: Int] = ["yagom": 100, "chulsoo": 200, "jenny": 300]
print(numberForName5.isEmpty) // false
print(numberForName5.count) // 3

/**
 - 딕셔너리는 배열과 다르게 딕셔너리 내부에 없는 키로 접근해도 오류가 발생하지 않음. (nil을 반환함)
 - 해당 키의 값이 없을 수도 있기 때문에 키로 접근 시에는 옵셔널 값을 반환한다.
 */
print(numberForName5["chulsoo"]) // 200
print(numberForName5["minji"]) // nil

numberForName5["chulsoo"] = 150
print(numberForName5["chulsoo"]) // 150

numberForName5["max"] = 999 // max라는 키로 999라는 값을 추가
print(numberForName5["max"]) // 999

print(numberForName5.removeValue(forKey: "yagom")) // 100 (값 제거)

// 위에서 yagom 키에 해당하는 값이 삭제되었으므로 nil이 반환됨
print(numberForName5.removeValue(forKey: "yagom")) // nil
// 키에 해당하는 값이 없으면 기본값을 돌려주도록 할 수도 있음
print(numberForName5["yagom", default: 0]) // 0


print()
/* [ 세트(Set) ] */
/**
 - 같은 타입의 데이터를 순서 없이 하나의 묶음으로 저장하는 형태의 컬렉션 타입
 - 세트 내의 값은 모두 유일한 값임 (중복된 값이 존재하지 않음)
 --> **순서가 중요하지 않거나 각 요소가 유일한 값이어야 하는 경우**에 보통 사용
 
 - **해시 가능한 값**이 들어와야 함
    - 스위프트 표준 라이브러리의 Hashable 프로토콜을 따른다는 것을 의미함. 스위프트의 모든 기본 데이터 타입은 모두 해시 가능한 값임
 
 <프로퍼티>
 - .isEmpty : 비어 있는지
 - .count: 요소 개수

 <메서드>
 - insert(_:) : 요소 추가
 - remove(_:) : 요소 삭제 (요소가 삭제된 후 반환됨)
 - sorted() : 정렬된 배열 반환
 */
print("[ 세트(Set) ]")

//var names: Set<String> = Set<String>() // 빈 세트 생성
//var names: Set<String> = [] // 빈 세트 생성

// Array와 마찬가지로 대괄호를 사용함
var names0: Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]
// 그렇기 때문에 타입 추론을 사용하면 컴파일러는 Set이 아니라 Array로 타입을 지정함 (@@주의@@)
var numbers = [100, 200, 300]
print(type(of: numbers)) // Array<Int>

print(names0.isEmpty) // false
print(names0.count) // 3 - 중복된 값은 허용되지 않아 yagom은 1개만 남음

print(names0.count) // 3
names0.insert("jenny")
print(names0.count) // 4

print(names0.remove("chulsoo")) // chulsoo
print(names0.remove("john")) // nil


// [ 세트의 활용 - 집합연산 ]
// 세트는 자신 내부의 값들이 모두 유일함을 보장하므로, 집합관계를 표현할 때 유용함
/**
 <집합 연산 메서드>
 - intersection() : 교집합
 - symmetricDifference() : 여집합의 합
 - union() : 합집합
 - subtracting() : 차집합
 */
print("[ 세트의 활용 - 집합연산 ]")
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

print(unionSet.sorted()) // ["chulsoo", "hana", "jenny", "john", "minsoo", "yagom"]

// [ 세트의 활용 - 포함관계 연산 ]
/**
 <포함 관계 연산 메서드>
 - isDisjoint(with:) : with와 서로 배타적인지
 - isSubset(of:) : of의 부분집합인지
 - isSuperset(of:) : of의 전체집합인지
 */
print("[ 세트의 활용 - 포함관계 연산 ]")
let 새: Set<String> = ["비둘기", "닭", "기러기"]
let 포유류: Set<String> = ["사자", "호랑이", "곰"]
let 동물: Set<String> = 새.union(포유류) // 새와 포유류의 합집합

print(새.isDisjoint(with: 포유류)) // true
print(새.isSubset(of: 동물)) // true
print(동물.isSuperset(of: 포유류)) // true
print(동물.isSuperset(of: 새)) // true


// [ 컬렉션에서 임의의 요소 추출과 뒤섞기 ]
/**
 - randomElement() : 컬렉션에서 임의의 요소를 추출
 - shuffle() : 컬렉션의 요소를 임의로 뒤섞음
 - shuffled() : 자신의 요소는 그대로 둔 채 새로운 컬렉션에 임의의 순서로 뒤섞어서 반환
 */
print("[ 컬렉션에서 임의의 요소 추출과 뒤섞기 ]")
var array: [Int] = [0, 1, 2, 3, 4]
var set: Set<Int> = [0, 1, 2, 3, 4]
var dictionary: [String: Int] = ["a": 1, "b": 2, "c": 3]
var string: String = "string"

print(array.randomElement()) // 임의의 요소
print(array.shuffled()) // 뒤죽박죽된 배열을 반환 - array 내부의 요소는 그대로 있음
print(array) // [0, 1, 2, 3, 4] - array는 그대로인 것을 볼 수 있다.
array.shuffle() // array 자체를 뒤죽박죽으로 뒤섞음
print(array) // array가 뒤죽박죽됨

print(set.shuffled()) // 세트를 뒤섞으면 배열로 반환해줌
//set.shuffle() // 오류 발생! 세트는 순서가 없기 때문에 스스로 뒤섞을 수 없음
print(dictionary.shuffled()) // 딕셔너리를 뒤섞으면 (키, 값)이 쌍을 이룬 튜플의 배열로 반환해줌
print(string.shuffled()) // String도 컬렉션이기 때문에 뒤섞임




print()
/* [ 열거형 ] */
print("[ 열거형 ]")


