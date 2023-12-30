import Foundation

//// [ for-in 구문과 맵 매서드의 사용 비교 ]
//
//let numbers: [Int] = [0, 1, 2, 3, 4]
//
//var doubledNumbers: [Int] = [Int]()
//var strings: [String] = [String]()
//
//// for 구문 사용
//for number in numbers {
//    doubledNumbers.append(number * 2)
//    strings.append("\(number)")
//}
//
//print(doubledNumbers)   // [0, 2, 4, 6, 8]
//print(strings)          // ["0", "1", "2", "3", "4"]
//
//// map 메서드 사용
//doubledNumbers = numbers.map({ (number: Int) -> Int in
//    return number * 2
//})
//strings = numbers.map({ (number: Int) -> String in
//    return "\(number)"
//})
//
//print(doubledNumbers)   // [0, 2, 4, 6, 8]
//print(strings)          // ["0", "1", "2", "3", "4"]





//// [ 클로저 표현의 간략화 ]
//
//let numbers: [Int] = [0, 1, 2, 3, 4]
//
//// 기본 클로저 표현식 사용
//var doubledNumbers = numbers.map({ (number: Int) -> Int in
//    return number * 2
//})
//
//// 매개변수 및 반환 타입 생략
//doubledNumbers = numbers.map({ return $0 * 2 })
//print(doubledNumbers)   // [0, 2, 4, 6, 8]
//
//// 반환 키워드 생략
//doubledNumbers = numbers.map({ $0 * 2 })
//print(doubledNumbers)   // [0, 2, 4, 6, 8]
//
//// 후행 클로저 사용
//doubledNumbers = numbers.map { $0 * 2 }
//print(doubledNumbers)   // [0, 2, 4, 6, 8]




//// [ 클로저의 반복 사용 ]
//
//let evenNumbers: [Int] = [0, 2, 4, 6, 8]
//let oddNumbers: [Int] = [0, 1, 3, 5, 7]
//let multiplyTwo: (Int) -> Int = { $0 * 2 }
//
//let doubledEvenNumbers = evenNumbers.map(multiplyTwo)
//print(doubledEvenNumbers)   // [0, 4, 8, 12, 16]
//
//let doubledOddNumbers = oddNumbers.map(multiplyTwo)
//print(doubledOddNumbers)    // [0, 2, 6, 10, 14]




//// [ 다양한 컨테이너 타입에서의 맵의 활용 ]
//
//// Dictionary
//let alphabetDictionary: [String: String] = ["a": "A", "b": "B"]
//var keys: [String] = alphabetDictionary.map { (tuple: (String, String)) -> String in
//    return tuple.0
//}
//
//keys = alphabetDictionary.map { $0.0 }
//let values: [String] = alphabetDictionary.map { $0.1 }
//
//print(keys)     // ["a", "b"]
//print(values)   // ["A", "B"]
//
//
//// Set
//var numberSet: Set<Int> = [1, 2, 3, 4, 5]
//let resultSet = numberSet.map { $0 * 2 }
//print(resultSet)    // [10, 2, 6, 8, 4]
//
//
//// Optional
//let optionalInt: Int? = 3
//let resultInt: Int? = optionalInt.map { $0 * 2 }
//print(resultInt)    // Optional(6)
//
//
//// Range
//let range: CountableClosedRange = (0...3)
//let resultRange: [Int] = range.map { $0 * 2 }
//print(resultRange)  // [0, 2, 4, 6]






//// [ 필터 메서드의 사용 ]
//
//let numbers: [Int] = [0, 1, 2, 3, 4, 5]
//
//let evenNumbers: [Int] = numbers.filter { (number: Int) -> Bool in
//    return number % 2 == 0
//}
//print(evenNumbers)  // [0, 2, 4]
//
//let oddNumbers: [Int] = numbers.filter { $0 % 2 == 1 }
//print(oddNumbers)   // [1, 3, 5]



//// [ 맵과 필터 메서드의 연계 사용 ]
//
//let numbers: [Int] = [0, 1, 2, 3, 4, 5]
//
//let mappedNumbers: [Int] = numbers.map { $0 + 3 }
//
//let evenNumbers: [Int] = mappedNumbers.filter { (number: Int) -> Bool in
//    return number % 2  == 0
//}
//print(evenNumbers)  // [4, 6, 8]
//
//// 메서드를 체인처럼 연결하여 사용 가능
//let oddNumbers: [Int] = numbers.map{ $0 + 3 }.filter{ $0 % 2 == 1 }
//print(oddNumbers)   // [3, 5, 7]





//// [ 리듀스 메서드의 사용 ]
//
//let numbers: [Int] = [1, 2, 3]
//
//// ✅ 첫 번째 형태인 reduce(_:_:) 메서드의 사용
//
//// 초깃값이 0이고 정수 배열의 모든 값을 더함
//var sum: Int = numbers.reduce(0, { (result: Int, next: Int) -> Int in
//    print("\(result) + \(next)")
//    // 0 + 1
//    // 1 + 2
//    // 3 + 3
//    return result + next
//})
//print(sum)  // 6
//
//// 초깃값이 0이고 정수 배열의 모든 값을 뺌
//let subtract: Int = numbers.reduce(0, { (result: Int, next: Int) -> Int in
//    print("\(result) - \(next)")
//    // 0 - 1
//    // -1 - 2
//    // -3 - 3
//    return result - next
//})
//print(subtract) // -6
//
//// 초깃값이 3이고 정수 배열의 모든 값을 더함
//let sumFromThree: Int = numbers.reduce(3) {
//    print("\($0) + \($1)")
//    // 3 + 1
//    // 4 + 2
//    // 6 + 3
//    return $0 + $1
//}
//print(sumFromThree) // 9
//
//// 초깃값이 3이고 정수 배열의 모든 값을 뺌
//var subtractFromThree: Int = numbers.reduce(3) {
//    print("\($0) - \($1)")
//    // 3 - 1
//    // 2 - 2
//    // 0 - 3
//    return $0 - $1
//}
//print(subtractFromThree)    // -3
//
//// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결
//let names: [String] = ["Chope", "Jay", "Joker", "Nova"]
//
//let reducedNames: String = names.reduce("yagom's friend : ") {
//    return $0 + ", " + $1
//}
//print(reducedNames) // yagom's friend : , Chope, Jay, Joker, Nova
//
//
//// ✅ 두 번째 형태인 reduce(into:_:) 메서드의 사용
//
//// 초깃값이 0이고 정수 배열의 모든 값을 더함
//// 첫 번째 형태와 다르게 클로저의 값을 반환하지 않고 내부에서 직접 이전 값을 변경한다.
//sum = numbers.reduce(into: 0, { (result: inout Int, next: Int) in
//    print("\(result) + \(next)")
//    // 0 + 1
//    // 1 + 2
//    // 3 + 3
//    result += next
//})
//print(sum)  // 6
//
//// 초깃값이 3이고 정수 배열의 모든 값을 뺌
//subtractFromThree = numbers.reduce(into: 3, {
//    print("\($0) - \($1)")
//    // 3 - 1
//    // 2 - 2
//    // 0 - 3
//    $0 -= $1
//})
//print(subtractFromThree)    //  -3
//
//// 첫 번째 리듀스 형태와 다르기 때문에 다른 컨테이너에 값을 변경하여 넣어줄 수도 있다.
//// 맵/필터와 유사한 형태로 사용 가능
//// 홀수는 걸러내고 짝수만 두 배로 변경하여 초깃값인 [1, 2, 3] 배열에 직접 연산
//var doubledNumbers: [Int] = numbers.reduce(into: [1, 2]) { (result: inout [Int], next: Int) in
//    print("result \(result) next: \(next)")
//    // result [1, 2] next: 1
//    // result [1, 2] next: 2
//    // result [1, 2, 4] next: 3
//    
//    guard next.isMultiple(of: 2) else {
//        return
//    }
//    
//    print("\(result) append \(next)")
//    // [1, 2] append 2
//    
//    result.append(next * 2)
//}
//print(doubledNumbers)   // [1, 2, 4]
//
//// 필터와 맵을 사용한 모습
//doubledNumbers = [1, 2] + numbers.filter { $0.isMultiple(of: 2) }.map { $0 * 2 }
//print(doubledNumbers)   // [1, 2, 4]
//
//// 이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산
//var upperCasedNames: [String]
//upperCasedNames = names.reduce(into: [], {
//    $0.append($1.uppercased())
//})
//print(upperCasedNames)  // ["CHOPE", "JAY", "JOKER", "NOVA"]
//
//// 맵 사용
//upperCasedNames = names.map { $0.uppercased() }
//print(upperCasedNames)  // ["CHOPE", "JAY", "JOKER", "NOVA"]






//// [ 맵, 필터, 리듀스 메서드의 연계 사용 ]
//
//let numbers: [Int] = [1, 2, 3, 4, 5, 6, 7]
//
//// 짝수를 걸러내어 각 값에 3을 곱해준 후 모든 값을 더함
//var result: Int = numbers.filter{ $0.isMultiple(of: 2) }.map{ $0 * 3 }.reduce(0){ $0 + $1 }
//print(result)   // 36







// [ 친구들의 정보 생성 ]
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()

friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))



// [ 조건에 맞는 친구 결과 출력 ]

// 입력된 자료는 작년 자료이기 때문에 친구들의 나이는 실제 나이보다 한 살 더 적게 적혀있다고 가정
var result: [Friend] = friends.map{ Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1) }

// 서울 외의 지역에 거주하며 25세 이상인 친구
result = result.filter{ $0.location != "서울" && $0.age >= 25 }

let string: String = result.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"}
print(string)
// 서울 외의 지역에 거주하며 25세 이상인 친구
// Yoobato male 발리 27세
// JiSoo male 시드니 25세
// JuHyun male 경기 31세
// JungKi unknown 대전 30세
// YoungMin male 경기 25세
