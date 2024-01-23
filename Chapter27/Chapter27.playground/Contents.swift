

//// [ 강한참조의 참조 횟수 확인 ]
//
//class Person {
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//        print("\(name) is being initialized")
//    }
//    
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//var reference1: Person?
//var reference2: Person?
//var reference3: Person?
//
//reference1 = Person(name: "rei") // 인스턴스의 참조 횟수 : 1
//// rei is being initialized
//
//reference2 = reference1 // 인스턴스의 참조 횟수 : 2
//reference3 = reference1 // 인스턴스의 참조 횟수 : 3
//
//reference3 = nil // 인스턴스의 참조 횟수 : 2
//reference2 = nil // 인스턴스의 참조 횟수 : 1
//reference1 = nil // 인스턴스의 참조 횟수 : 0
//// rei is being deinitialized
///// 👉 참조 횟수가 0이 되는 순간 인스턴스는 ARC의 규칙에 의해 메모리에서 해제되며 메모리에서 해제되기 직전에 디이니셜라이저를 호출한다.



//// [ 강한참조 지역변수(상수)의 참조 횟수 확인 ]
//
//func foo() {
//    let rei: Person = Person(name: "rei")   // 인스턴스의 참조 횟수 : 1
//    // rei is being initialized
//    
//    // 함수 종료 시점
//    // 인스턴스의 참조 횟수 : 0
//    // rei is being initialized
//    
//    /// 👉 강한참조 지역변수(상수)가 사용된 범위의 코드 실행이 종료되면 그 지역변수(상수)가 참조하던 인스턴스의 참조 횟수가 1 감소한다.
//}
//foo()




//// [ 강한참조 지역변수(상수)의 참조 횟수 확인과 전역변수 ]
//
//var globalReference: Person?
//
//func foo() {
//    let rei: Person = Person(name: "rei")   // 인스턴스의 참조 횟수 : 1
//    // rei is being initialized
//    
//    globalReference = rei   // 인스턴스의 참조 횟수 : 2
//    
//    // 함수 종료 시점
//    // 인스턴스의 참조 횟수 : 1
//    
//    /// 👉 인스턴스 참조 횟수가 여전히 1이므로 메모리에서 해제되지 않는다.
//}
//foo()






//// [ 강한참조 순환 문제 ]
//
//class Person {
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    var room: Room?
//    
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//class Room {
//    let number: String
//    
//    init(number: String) {
//        self.number = number
//    }
//    
//    var host: Person?
//    
//    deinit {
//        print("Room \(number) is being deinitialized")
//    }
//}
//
//var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
//var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1
//
//room?.host = rei    // Person 인스턴스의 참조 횟수 : 2
//rei?.room = room    // Room 인스턴스의 참조 횟수 : 2
//
//rei = nil   // Person 인스턴스의 참조 횟수 : 1
//room = nil  // Room 인스턴스의 참조 횟수 : 1
//
///*
// Person 인스턴스를 참조할 방법을 상실했지만 메모리에는 남아 있음
// Room 인스턴스를 참조할 방법을 상실했지만 메모리에는 남아 있음
// 👉 Person과 Room의 디이니셜라이저가 호출되지 않는 것을 확인할 수 있다.
// 👉 메모리 누수 발생 ‼️
// */




//// [ 강한참조 순환 문제를 수동으로 해결 ]
//
//var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
//var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1
//
//room?.host = rei    // Person 인스턴스의 참조 횟수 : 2
//rei?.room = room    // Room 인스턴스의 참조 횟수 : 2
//
//rei?.room = nil     // Room 인스턴스의 참조 횟수 : 1
//rei = nil           // Person 인스턴스의 참조 횟수 : 1
//
//room?.host = nil    // Person 인스턴스의 참조 횟수 : 0
//// rei is being deinitialized
//
//room = nil          // Room 인스턴스의 참조 횟수 : 0
//// Room 505 is being deinitialized







//// [ 강한참조 순환 문제를 약한참조로 해결 ]
//
//class Person {
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    var room: Room?
//    
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//class Room {
//    let number: String
//    
//    init(number: String) {
//        self.number = number
//    }
//    
//    // 약한참조를 하도록 weak 키워드와 함께 정의
//    weak var host: Person?
//    
//    deinit {
//        print("Room \(number) is being deinitialized")
//    }
//}
//
//var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
//var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1
//
//room?.host = rei    // Person 인스턴스의 참조 횟수 : 1 👉 host 프로퍼티는 약한참조를 하기 때문에 참조 횟수가 증가하지 않는다.
//rei?.room = room    // Room 인스턴스의 참조 횟수 : 2
//
//rei = nil   // Person 인스턴스의 참조 횟수 : 0, Room 인스턴스의 참조 횟수 : 1 👉 Person 인스턴스의 room 프로퍼티가 강한참조를 하고 있던 Room 인스턴스의 참조 횟수도 감소한다.
//// rei is being deinitialized
//print(room?.host)   // nil 👉 host 프로퍼티는 약한참조를 하고 있었기 때문에 자신이 참조하는 인스턴스가 메모리에서 해제되면 자동으로 nil을 할당
//
//room = nil  // Room 인스턴스의 참조 횟수 : 0
//// Room 505 is being deinitialized







//// [ 미소유참조 ]
//
//class Person {
//    let name: String
//    
//    /*
//     - 카드를 소지할 수도, 소지하지 않을 수도 있기 때문에 옵셔널로 정의한다.
//     - 카드를 한 번 가진 후 잃어버리면 안 되기 때문에 강한참조를 해야 한다.
//     */
//    var card: CreditCard?
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    deinit { print("\(name) is being deinitialized") }
//}
//
//class CreditCard {
//    let number: UInt
//    unowned let owner: Person   // 카드는 소유자가 분명히 존재해야 한다.
//    
//    init(number: UInt, owner: Person) {
//        self.number = number
//        self.owner = owner
//    }
//    
//    deinit {
//        print("Card #\(number) is being deinitialized")
//    }
//}
//
//var rei: Person? = Person(name: "rei") // Person 인스턴스의 참조 횟수 : 1
//
//if let person: Person = rei {
//    // CreditCard의 인스턴스 참조 횟수 : 1
//    person.card = CreditCard(number: 1004, owner: person)
//    // Person 인스턴스의 참조 횟수 : 1 👉 owner는 미소유참조를 하기 때문에 Person 인스턴스의 참조 횟수가 증가하지 않는다.
//}
//
//rei = nil   // Person 인스턴스의 참조 횟수 : 0
//// CreditCard 인스턴스의 참조 횟수 : 0 👉 card 프로퍼티는 강한참조를 하고 있었기 때문에 CreditCard 인스턴스의 참조 횟수도 1 감소된다.
//// rei is being deinitialized
//// Card #1004 is being deinitialized







//// [ 미소유 옵셔널 참조의 사용 ]
//
//class Department {
//    var name: String
//    var subjects: [Subject] = [] // 학과에서 운영하는 각 과목을 배열에 담아 강한참조
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Subject {
//    var name: String
//    unowned var department: Department  // 학과 (과목은 반드시 특정 학과에 속해야 하기 때문에 옵셔널x)
//    unowned var nextSubject: Subject?   // 학생이 수강해야 하는 다음 과목 (모든 과목이 다음 차례의 과목을 갖고 있는 것은 아니기 때문에 옵셔널)
//    init(name: String, in department: Department) {
//        self.name = name
//        self.department = department
//        self.nextSubject = nil
//    }
//}
//
//let department = Department(name: "Computer Science")
//
//let intro = Subject(name: "Computer Architecture", in: department)
//let intermediate = Subject(name: "Swift Language", in: department)
//let advanced = Subject(name: "iOS App Programming", in: department)
//
///*
// - intro, intermediate 과목은 다음 수강 과목을 미소유 옵셔널 참조로 nextSubject 프로퍼티에 저장한다.
// - 옵셔널 값인 클래스의 인스턴스가 메모리에서 해제될 때 ARC에 의해 보호받지 못한다. → 이는 미소유참조와 동일하지만, 미소유 옵셔널 참조는 nil이 될 수 있다는 점이 다르다.
// */
//intro.nextSubject = intermediate
//intermediate.nextSubject = advanced
//department.subjects = [intro, intermediate, advanced]
///*
// - 옵셔널이 아닌 미소유참조와 같이 nextSubject가 항상 메모리에서 해제되지 않고 살아 있는 과목의 인스턴스를 참조하도록 신경 써주어야 한다.
//    - ex) department.subjects에서 한 과목을 제거한다면, 그 과목을 nextSubject로 참조하고 있느 인스턴스에서 nextSubject의 참조를 제거해 줘야 한다.
// */






//// [ 미소유참조와 암시적 추출 옵셔널 프로퍼티의 활용 ]
//
//class Company {
//    let name: String
//    // 암시적 추출 옵셔널 프로퍼티 (강한참조)
//    var ceo: CEO!
//    
//    init(name: String, ceoName: String) {
//        self.name = name
//        self.ceo = CEO(name: ceoName, company: self)
//    }
//    
//    func introduce() {
//        print("\(name)의 CEO는 \(ceo.name)입니다.")
//    }
//}
//
//class CEO {
//    let name: String
//    // 미소유참조 상수 프로퍼티 (미소유참조)
//    unowned let company: Company
//    
//    init(name: String, company: Company) {
//        self.name = name
//        self.company = company
//    }
//    
//    func introduce() {
//        print("\(name)는 \(company.name)의 CEO입니다.")
//    }
//}
//
//let company: Company = Company(name: "무한상사", ceoName: "김태호")
//company.introduce()     // 무한상사의 CEO는 김태호입니다.
//company.ceo.introduce() // 김태호는 무한상사의 CEO입니다.







//// [ 클로저의 강한참조 순환 문제 ]
//
//class Person {
//    let name: String
//    let hobby: String?
//    
//    // introduce는 지연 저장 프로퍼티로 선언되어 있기 대문에 할당된 클로저 내부에서 self 프로퍼티를 사용할 수 있다.
//    lazy var introduce: () -> String = {
//        
//        var introduction: String = "My name is \(self.name)."
//        
//        guard let hobby = self.hobby else {
//            return introduction
//        }
//        
//        introduction += " "
//        introduction += "My hobby is \(hobby)."
//        
//        return introduction
//    }
//    
//    init(name: String, hobby: String? = nil) {
//        self.name = name
//        self.hobby = hobby
//    }
//    
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//var rei: Person? = Person(name: "rei", hobby: "eating")
//print(rei?.introduce()) // My name is rei. My hobby is eating.
//rei = nil
///*
// rei 변수에 nil을 할당했지만 deinit이 호출되지 않음 👉 메모리 누수 발생
// */






//// [ 획득목록을 통한 값 획득 ]
//
///*
// - 변수 a는 획득목록을 통해 클로저가 생성될 때 값 0을 획득했지만 b는 따로 값을 획득하지 않았다.
//    👉 a 변수는 클로저가 생성됨과 동시에 획득목록 내에서 다시 a라는 이름의 상수로 초기화된 것임
//    👉 외부에서 a의 값을 변경하더라도 클로저의 획득목록으로 획득한 a와는 별개가 된다.
//    👉 b의 경우에는 클로저의 내/외부 상관없이 값이 변하는대로 반영된다.
// */
//var a = 0
//var b = 0
//let closure = { [a] in
//    print(a, b)
//    b = 20
//}
//
//a = 10
//b = 10
//closure() // a는 클로저 생성 시 획득한 값을 갖지만, b는 변경된 값을 사용한다.
//// 0 10
//print(b)
//// 20







//// [ 참조 타입의 획득목록 동작 ]
//
///*
// - 변수 x는 획득목록을 통해 값을 획득했고 y는 획득목록에 별도로 명시되지 않았지만, 두 변수 모두 참조 타입의 인스턴스가 있기 때문에 서로 동작은 같다.
// */
//class SimpleClass {
//    var value: Int = 0
//}
//
//var x = SimpleClass()
//var y = SimpleClass()
//
//let closure = { [x] in
//    print(x.value, y.value)
//}
//x.value = 10
//y.value = 10
//
//closure() // 10 10





//// [ 획득목록의 획득 종류 명시 ]
//
//class SimpleClass {
//    var value: Int = 0
//}
//
//var x: SimpleClass? = SimpleClass()
//var y = SimpleClass()
//
//// 획득목록에서 x를 약한참조로, y를 미소유참조하도록 지정
//let closure = { [weak x, unowned y] in
//    // x는 약한참조이므로 클로저 내부에서 사용하더라도 x가 참조하는 인스턴스의 참조 횟수를 증가시키지 않는다.
//    print(x?.value, y.value)
//}
//
//x = nil
//y.value = 10
//
//closure() // nil 10
///*
// 👉 클로저의 x가 참조하는 인스턴스가 메모리에서 해제되어 클로저 내부에서도 더 이상 참조가 불가능
// 👉 y는 미소유참조를 했기 때문에 클로저가 참조 횟수를 증가시키지는 않지만, 만약 메모리에서 해제된 상태에서 사용 시 오류가 발생한다.
// */






//// [ 획득목록을 통한 클로저의 강한참조 순환 문제 해결 ]
//
//class Person {
//    let name: String
//    let hobby: String?
//    
//    // 👉 self를 미소유참조하도록 획득목록에 명시
//    lazy var introduce: () -> String = { [unowned self] in
//        var introduction: String = "My name is \(self.name)."
//        
//        guard let hobby = self.hobby else {
//            return introduction
//        }
//        
//        introduction += " "
//        introduction += "My hobby is \(hobby)."
//        return introduction
//    }
//    
//    init(name: String, hobby: String? = nil) {
//        self.name = name
//        self.hobby = hobby
//    }
//    
//    deinit {
//        print("\(name) is being deinitialized")
//    }
//}
//
//var rei: Person? = Person(name: "rei", hobby: "eating")
//print(rei?.introduce()) // My name is rei. My hobby is eating.
//
//rei = nil   // rei is being deinitialized
//// 👉 의도한 대로 인스턴스가 메모리에서 해제된다.





//// [ 획득목록의 미소유참조로 인한 차후 접근 문제 발생 ]
//
//var rei: Person? = Person(name: "rei", hobby: "eating")
//var son: Person? = Person(name: "son", hobby: "football")
//
//// son의 introduce 프로퍼티에 rei의 introduce 프로퍼티 클로저의 참조 할당
//son?.introduce = rei?.introduce ?? {" "}
//
//print(rei?.introduce()) // My name is rei. My hobby is eating.
//
//rei = nil   // rei is being deinitialized
//print(son?.introduce()) // 🚧 이미 메모리에서 해제된 인스턴스(rei) 참조를 시도하게 되면서 오류 발생!!





// [ 획득목록의 약한참조를 통한 차후 접근 문제 방지 ]

class Person {
    let name: String
    let hobby: String?
    
    // 👉 self를 약한참조하도록 획득목록에 명시
    lazy var introduce: () -> String = { [weak self] in
        // 👉 약한참조이기 때문에 옵셔널임
        guard let `self` = self else {
            return "원래의 참조 인스턴스가 없어졌습니다."
        }
        
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)."
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var rei: Person? = Person(name: "rei", hobby: "eating")
var son: Person? = Person(name: "son", hobby: "football")

// son의 introduce 프로퍼티에 rei의 introduce 프로퍼티 클로저의 참조 할당
son?.introduce = rei?.introduce ?? {" "}

print(rei?.introduce()) // My name is rei. My hobby is eating.

rei = nil   // rei is being deinitialized
print(son?.introduce()) // 원래의 참조 인스턴스가 없어졌습니다.
// 👉 이미 메모리에서 해제된 인스턴스(rei) 참조를 시도하지만 옵셔널 처리 덕에 오류는 발생하지 않음
