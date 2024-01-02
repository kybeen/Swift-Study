import Foundation


func addThree(_ num: Int) -> Int {
    return num + 3
}


// [ 맵 메서드를 사용하여 옵셔널을 연산할 수 있는 addThree(_:) 함수 ]
print(Optional(2).map(addThree))   // Optional(5)

// [ 옵셔널에 맵 메서드와 클로저의 사용 ]
var value: Int? = 2
print(value.map{ $0 + 3 }) // Optional(5)
value = nil
print(value.map{ $0 + 3 }) // nil(== Optional<Int>.none)



// 짝수면 2를 곱해서 반환하고, 짝수가 아니라면 nil을 반환하는 함수
func doubledEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}

Optional(2).flatMap(doubledEven)    // 4
Optional(3).flatMap(doubledEven)    // nil




// [ 맵과 컴팩트의 차이 ]
let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map { $0 }
let compactMapped: [Int] = optionals.compactMap{ $0 }

print(mapped)           // [Optional(1), Optional(2), nil, Optional(5)]
print(compactMapped)    // [1, 2, 5]



// [ 중첩된 컨테이너에서 맵과 플랫맵(콤팩트맵)의 차이 ]
let multipleContainer = [[1, 2, Optional.none], [3, Optional.none], [4, 5, Optional.none]]

let mappedMultipleContainer = multipleContainer.map{ $0.map{ $0 } }
let flatmappedMultipleContainer = multipleContainer.flatMap{ $0.flatMap{ $0 } }

print(mappedMultipleContainer)  // [[Optional(1), Optional(2), nil], [Optional(3), nil], [Optional(4), Optional(5), nil]]
print(flatmappedMultipleContainer)  // [1, 2, 3, 4, 5]




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




// [ 플랫맵 체이닝 중 빈 컨텍스트를 만났을 때의 결과 ]

func integerToNil(param: Int) -> String? {
    return nil
}

optionalString = "2"

let result = optionalString.flatMap(stringToInteger)
    .flatMap(integerToNil) // 이 부분에서 nil을 반환받기 때문에 이후 호출되는 메서드는 무시
    .flatMap(stringToInteger)

print(result)   // nil
