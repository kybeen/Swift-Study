

//// [ 와일드카드 패턴의 사용 ]
//
//let string: String = "ABC"
//
//switch string {
//// ABC -> 어떤 값이 와도 상관없기에 항상 실행된다.
//case _: print(string)
//}
//
//let optionalString: String? = "ABC"
//
//switch optionalString {
//// optionalString이 Optional("ABC") 일 때만 실행됨
//case "ABC"?: print(optionalString)
//    
//// optionalString이 Optional("ABC") 외의 값이 있을 때만 실행
//case _?: print("Has value, but not ABC")
//    
//// 값이 없을 때 실행
//case nil: print("nil")
//}
//// Optional("ABC")
//
//let rei = ("rei", 99, "Male")
//
//switch rei {
//// 첫 번째 요소가 "rei"일때만 실행
//case ("rei", _, _): print("Hello rei!!")
//    
//// 그 외 언제든지 실행
//case (_, _, _): print("Who cares~")
//}
//// Hello rei!!
//
//for _ in 0..<2 {
//    print("Hello")
//}
//// Hello
//// Hello





//// [ 값 바인딩 패턴의 사용 ]
//
//let rei = ("rei", 99, "Male")
//
//switch rei {
//// name, age, gender를 rei의 각각의 요소와 바인딩
//case let (name, age, gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
//}
//// Name: rei, Age: 99, Gender: Male
//
//switch rei {
//case (let name, let age, let gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
//}
//// Name: rei, Age: 99, Gender: Male
//
//switch rei {
//// 값 바인딩 패턴은 와일드카드 패턴과 결합하여 유용하게 사용될 수도 있다.
//case (let name, _, let gender): print("Name: \(name), Gender: \(gender)")
//}
//// Name: rei, Gender: Male





//// [ 튜플 패턴의 사용 ]
//
//let (a): Int = 2
//print(a) // 2
//
//let (x, y): (Int, Int) = (1, 2)
//print(x) // 1
//print(y) // 2
//
//let name: String = "Jung"
//let age: Int = 99
//let gender: String? = "Male"
//
//switch (name, age, gender) {
//case ("Jung", _, _): print("Hello Jung!!")
//case (_, _, "Male"?): print("Who are you man?")
//default: print("I don't know who you are")
//}
//// Hello Jung!!
//
//let points: [(Int, Int)] = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]
//
//for (x, _) in points {
//    print(x)
//}
//// 0
//// 1
//// 1
//// 2
//// 2





//// [ 열거형 케이스 패턴의 사용 ]
//
//let someValue: Int = 30
//
//if case 0...100 = someValue {
//    print("0 <= \(someValue) <= 100")
//}
//// 0 <= 30 <= 100
//
//let anotherValue: String = "ABC"
//
//if case "ABC" = anotherValue {
//    print(anotherValue)
//}
//// ABC
//
//enum MainDish {
//    case pasta(taste: String)
//    case pizza(dough: String, topping: String)
//    case chicken(withSauce: Bool)
//    case rice
//}
//
//var dishes: [MainDish] = []
//
//var dinner: MainDish = .pasta(taste: "크림")
//dishes.append(dinner)
//
//if case .pasta(let taste) = dinner {
//    print("\(taste) 파스타")
//}
//// 크림 파스타
//
//dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
//dishes.append(dinner)
//
//func whatIsThis(dish: MainDish) {
//    guard case .pizza(let dough, let topping) = dish else {
//        print("It's not a Pizza")
//        return
//    }
//    
//    print("\(dough) \(topping) 피자")
//}
//whatIsThis(dish: dinner)
//// 치즈크러스트 불고기 피자
//
//dinner = .chicken(withSauce: true)
//dishes.append(dinner)
//
//while case .chicken(let sauced) = dinner {
//    print("\(sauced ? "양념" : "후라이드") 통닭")
//    break
//}
//// 양념 통닭
//
//dinner = .rice
//dishes.append(dinner)
//
//if case .rice = dinner {
//    print("오늘 저녁은 밥입니다.")
//}
//// 오늘 저녁은 밥입니다.
//
//for dish in dishes {
//    switch dish {
//    case let .pasta(taste): print(taste)
//    case let .pizza(dough, topping): print(dough, topping)
//    case let .chicken(sauced): print(sauced ? "양념" : "후라이드")
//    case .rice: print("Just 쌀")
//    }
//}
///*
// 크림
// 치즈크러스트 불고기
// 양념
// Just 쌀
// */





//// [ 옵셔널 패턴의 사용 ]
//
//var optionalValue: Int? = 100
//
//if case .some(let value) = optionalValue {
//    print(value)
//}
//// 100
//
//if case let value? = optionalValue {
//    print(value)
//}
//// 100
//
//func isItHasValue(_ optionalValue: Int?) {
//    guard case .some(let value) = optionalValue else {
//        print("none")
//        return
//    }
//    
//    print(value)
//}
//isItHasValue(optionalValue) // 100
//
//while case .some(let value) = optionalValue {
//    print(value)
//    optionalValue = nil
//}
//// 100
//
//print(optionalValue) // nil
//
//let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
//
//for case let number? in arrayOfOptionalInts {
//    print("Found a \(number)")
//}
//// Found a 2
//// Found a 3
//// Found a 5
//
//for case let number in arrayOfOptionalInts {
//    print("Found a \(number)")
//}
//// Found a nil
//// Found a Optional(2)
//// Found a Optional(3)
//// Found a nil
//// Found a Optional(5)






//// [ 타입캐스팅 패턴의 사용 ]
//
//let someValue: Any = 100
//
//switch someValue {
//// 타입이 매치되는지 확인하지만 캐스팅된 값을 사용할 수는 없다.
//case is String: print("It's String!")
//    
//// 타입 확인과 동시에 캐스팅까지 완료되어 value에 저장된다.
//// 값 바인딩 패턴과 결합된 모습
//case let value as Int: print(value + 1)
//    
//default: print("Int도 String도 아닙니다.")
//}
//// 101





//// [ 표현 패턴의 사용 ]
//
//switch 3 {
//case 0...5: print("0과 5 사이")
//default: print("0보다 작거나 5보다 큽니다.")
//}
//// 0과 5 사이
//
//var point: (Int, Int) = (1, 2)
//
//// 같은 타입 간의 비교이므로 == 연산자를 사용하여 비교할 것이다.
//switch point {
//case (0, 0): print("원점")
//case (-2...2, -2...2): print("\(point.0), \(point.1)은 원점과 가깝습니다.")
//default: print("point \(point.0), \(point.1)")
//}
//// 1, 2은 원점과 가깝습니다.
//
//// String 타입과 Int 타입이 매치될 수 있도록 ~= 연산자를 정의한다.
//func ~= (pattern: String, value: Int) -> Bool {
//    return pattern == "\(value)"
//}
//
//point = (0, 0)
//
//// 새로 정의된 ~= 연산자를 사용하여 비교
//switch point {
//case ("0", "0"): print("원점")
//default: print("point (\(point.0), \(point.1)")
//}
//// 원점
//
//struct Person {
//    var name: String
//    var age: Int
//}
//
//let lingo: Person = Person(name: "Lingo", age: 99)
//func ~= (pattern: String, value: Person) -> Bool {
//    return pattern == value.name
//}
//func ~= (pattern: Person, value: Person) -> Bool {
//    return pattern.name == value.name && pattern.age == value.age
//}
//
//switch lingo {
//case Person(name: "Lingo", age: 99): print("Same Person!!")
//case "Lingo": print("Hello Lingo!!")
//default: print("I don't know who you are")
//}
//// Same Person!!






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
