import Foundation

//// [ 저장 프로퍼티의 선언 및 인스턴스 생성 ]
//
//// 좌표
//struct CoordinatePoint {
//    var x: Int      // 저장 프로퍼티
//    var y: Int      // 저장 프로퍼티
//}
//
//// 구조체에는 기본적으로 저장 프로퍼티를 매개변수로 갖는 이니셜라이저가 있다.
//let reiPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)
//
//// 사람의 위치 정보
//class Position {
//    var point: CoordinatePoint // 저장 프로퍼티(변수) - 위치(Point)는 변경될 수 있기 때문에 변수 저장 프로퍼티
//    let name: String // 저장 프로퍼티(상수)
//    
//    // 프로퍼티 기본값을 지정해주지 않는다면 이니셜라이저를 따로 정의해주어야 한다.
//    init(name: String, currentPoint: CoordinatePoint) {
//        self.name = name
//        self.point = currentPoint
//    }
//}
//
//// 사용자 정의 이니셜라이저를 호출해서 프로퍼티 초깃값을 할당해 주어야 인스턴스 생성이 가능함
//let reiPosition: Position = Position(name: "rei", currentPoint: reiPoint)





//// [ 저장 프로퍼티의 초깃값 지정 ]
//
//// 좌표
//struct CoordinatePoint {
//    var x: Int = 0      // 저장 프로퍼티
//    var y: Int = 0      // 저장 프로퍼티
//}
//
//// 프로퍼티의 초깃값을 할당했다면 굳이 전달인자로 초깃값을 넘길 필요가 없다.
//let reiPoint: CoordinatePoint = CoordinatePoint()
//// 기존의 초깃값 할당 이니셜라이저도 사용 가능함
//let ybPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)
//
//print("rei's point: \(reiPoint.x), \(reiPoint.y)")
//// rei's point: 0, 0
//print("yb's point: \(ybPoint.x), \(ybPoint.y)")
//// yb's point: 10, 5
//
//// 사람의 위치 정보
//class Position {
//    var point: CoordinatePoint = CoordinatePoint()  // 저장 프로퍼티
//    var name: String = "Unknown"                    // 저장 프로퍼티
//}
//
//// 초깃값을 지정해줬다면 사용자 정의 이니셜라이저를 사용하지 않아도 된다.
//let reiPosition: Position = Position()
//
//reiPosition.point = reiPoint
//reiPosition.name = "rei"





//// [ 옵셔널 저장 프로퍼티 ]
//
//// 좌표
//struct CoordinatePoint {
//    // 위치는 x, y 값이 모두 있어야 하므로 옵셔널이면 안 된다.
//    var x: Int
//    var y: Int
//}
//
//// 사람의 위치 정보
//class Position {
//    // 현재 사람의 위치를 모를 수도 있다. 👉 옵셔널
//    var point: CoordinatePoint?
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//// 이름은 필수지만 위치는 모를 수 있음
//let reiPosition: Position = Position(name: "rei")
//
//// 위치를 알게되면 그 때 위치 값을 할당
//reiPosition.point = CoordinatePoint(x: 20, y: 10)






//// [ 지연 저장 프로퍼티 ]
//
//struct CoordinatePoint {
//    var x: Int = 0
//    var y: Int = 0
//}
//
//class Position {
//    lazy var point: CoordinatePoint = CoordinatePoint()
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let reiPosition: Position = Position(name: "rei")
//
//// 이 코드를 통해 point 프로퍼티로 처음 접근할 때 point 프로퍼티의 CoordinatePoint가 생성된다.
//print(reiPosition.point) // CoordinatePoint(x: 0, y: 0)




//// [ 연산 프로퍼티를 적용하지 않고 메서드로 접근자와 설정자를 구현한 코드 ]
//
//struct CoordinatePoint {
//    var x: Int  // 저장 프로퍼티
//    var y: Int  // 저장 프로퍼티
//    
//    // 대칭점을 구하는 메서드 - 접근자
//    // Self는 타입 자기 자신을 뜻함 (Self 대신 CoordinatePoint 사용해도 됨)
//    func oppositePoint() -> Self {
//        return CoordinatePoint(x: -x, y: -y)
//    }
//    
//    // 대칭점을 설정하는 메서드 - 설정자
//    // mutating 키워드에 대한 내용은 10.2.1절에서
//    mutating func setOppositePoint(_ opposite: CoordinatePoint) {
//        x = -opposite.x
//        y = -opposite.y
//    }
//}
//
//var reiPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
//
//// 현재 좌표
//print(reiPosition)                  // 10, 20
//// 대칭 좌표
//print(reiPosition.oppositePoint())  // -10, -20
//
//// 대칭 좌표를 (15, 10)으로 설정하면
//reiPosition.setOppositePoint(CoordinatePoint(x: 15, y: 10))
//// 현재 좌표는 -15, -10으로 설정된다.
//print(reiPosition)  // -15, -10





//// [ 연산 프로퍼티의 정의와 사용 ]
//
//struct CoordinatePoint {
//    var x: Int  // 저장 프로퍼티
//    var y: Int  // 저장 프로퍼티
//    
//    // 대칭 좌표
//    var oppositePoint: CoordinatePoint { // 연산 프로퍼티
//        // 접근자
//        get {
//            return CoordinatePoint(x: -x, y: -y)
//        }
//        
//        // 설정자
//        set(opposite) {
//            x = -opposite.x
//            y = -opposite.y
//        }
//    }
//}
//
//var reiPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
//
//// 현재 좌표
//print(reiPosition)                  // 10, 20
//// 대칭 좌표
//print(reiPosition.oppositePoint)    // -10, -20
//
//// 대칭 좌표를 (15, 10)으로 설정하면
//reiPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)
//// 현재 좌표는 (-15, -10)으로 설정된다.
//print(reiPosition)  // -15, -10




//// [ 매개변수 이름을 생략한 설정자 ]
//
//struct CoordinatePoint {
//    var x: Int  // 저장 프로퍼티
//    var y: Int  // 저장 프로퍼티
//    
//    // 대칭 좌표
//    var oppositePoint: CoordinatePoint { // 연산 프로퍼티
//        // 접근자
//        get {
//            return CoordinatePoint(x: -x, y: -y)
//        }
//        
//        // 설정자
//        set(opposite) {
//            x = -opposite.x
//            y = -opposite.y
//        }
//    }
//}
//
//var reiPosition: CoordinatePoint = CoordinatePoint(x: 10, y: 20)
//
//// 현재 좌표
//print(reiPosition)                  // 10, 20
//// 대칭 좌표
//print(reiPosition.oppositePoint)    // -10, -20
//
//// 대칭 좌표를 (15, 10)으로 설정하면
//reiPosition.oppositePoint = CoordinatePoint(x: 15, y: 10)
//// 현재 좌표는 (-15, -10)으로 설정된다.
//print(reiPosition)  // -15, -10




//// [ 프로퍼티 감시자 ]
//
//class Account {
//    var credit: Int = 0 {
//        willSet {
//            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
//        }
//        
//        didSet {
//            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
//        }
//    }
//}
//
//let myAccount: Account = Account()
//// 잔액이 0원에서 1000원으로 변경될 예정입니다.
//myAccount.credit = 1000
//// 잔액이 0원에서 1000원으로 변경되었습니다.





//// [ 상속받은 연산 프로퍼티의 프로퍼티 감시자 구현 ]
//
//class Account {
//    var credit: Int = 0 { // 저장 프로퍼티
//        willSet {
//            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
//        }
//        
//        didSet {
//            print("잔액이 \(oldValue)원에서 \(credit)원으로 변경되었습니다.")
//        }
//    }
//    
//    var dollarValue: Double { // 연산 프로퍼티
//        get {
//            return Double(credit) / 1000.0
//        }
//        
//        set {
//            credit = Int(newValue * 1000)
//            print("잔액을 \(newValue)달러로 변경 중입니다.")
//        }
//    }
//}
//
//class ForeignAccount: Account {
//    override var dollarValue: Double {
//        willSet {
//            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
//        }
//        
//        didSet {
//            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
//        }
//    }
//}
//
//let myAccount: ForeignAccount = ForeignAccount()
//// 잔액이 0원에서 1000원으로 변경될 예정입니다.
//myAccount.credit = 1000
//// 잔액이 0원에서 1000원으로 변경되었습니다.
//
//// 잔액이 1.0달러에서 2.0달러로 변경될 예정입니다.
//// 잔액이 1000원에서 2000원으로 변경될 예정입니다.
//// 잔액이 1000원에서 2000원으로 변경되었습니다.
//
//myAccount.dollarValue = 2 // 잔액을 2.0달러로 변경 중입니다.
//// 잔액이 1.0달러에서 2.0달러로 변경되었습니다.





//// [ 저장변수의 감시자와 연산변수 ]
//var wonInPocket: Int = 2000 {
//    willSet {
//        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
//    }
//    
//    didSet {
//        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
//    }
//}
//
//var dollarInPocket: Double {
//    get {
//        return Double(wonInPocket) / 1000.0
//    }
//    
//    set {
//        wonInPocket = Int(newValue * 1000.0)
//        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
//    }
//}
//
//// 주머니의 돈이 2000원에서 3500원으로 변경될 예정입니다.
//// 주머니의 돈이 2000원에서 3500원으로 변경되었습니다.
//dollarInPocket = 3.5 // 주머니의 달러를 3.5달러로 변경 중입니다.




//// [ 타입 프로퍼티와 인스턴스 프로퍼티 ]
//
//class AClass {
//    
//    // 저장 타입 프로퍼티
//    static var typeProperty: Int = 0
//    
//    // 저장 인스턴스 프로퍼티
//    var instanceProperty: Int = 0 {
//        didSet {
//            // AClass.typeProperty와 같은 표현
//            Self.typeProperty = instanceProperty + 100
//        }
//    }
//    
//    // 연산 타입 프로퍼티
//    static var typeComputedProperty: Int {
//        get {
//            return typeProperty
//        }
//        
//        set {
//            typeProperty = newValue
//        }
//    }
//}
//
//AClass.typeProperty = 123
//
//let classInstance: AClass = AClass()
//classInstance.instanceProperty = 100
//
//print(AClass.typeProperty) // 200
//print(AClass.typeComputedProperty) // 200




//// [ 타입 프로퍼티의 사용 ]
//
//class Account {
//    static let dollarExchangeRate: Double = 1000.0 // 타입 상수
//    
//    var credit: Int = 0         // 저장 인스턴스 프로퍼티
//    
//    var dollarValue: Double {   // 연산 인스턴스 프로퍼티
//        get {
//            // Self.dollarExchangeRate는 Account.dollarExchangeRate와 같은 표현
//            return Double(credit) / Self.dollarExchangeRate
//        }
//        
//        set {
//            credit = Int(newValue * Account.dollarExchangeRate)
//            print("잔액을 \(newValue)달러로 변경 중입니다.")
//        }
//    }
//}






//// [ 키 경로 타입의 타입 확인 ]
//
//class Person {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Stuff {
//    var name: String
//    var owner: Person
//}
//
//print(type(of: \Person.name))   // ReferenceWritableKeyPath<Person, String>
//print(type(of: \Stuff.name))    // WritableKeyPath<Stuff, String>
//
//// 키 경로는 기존의 키 경로에 하위 경로를 덧붙여 줄 수도 있다.
//let keyPath = \Stuff.owner
//let nameKeyPath = keyPath.appending(path: \.name)





//// [ keyPath 서브스크립트와 키 경로 활용 ]
//
//class Person {
//    let name: String
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Stuff {
//    var name: String
//    var owner: Person
//}
//
//let rei = Person(name: "rei")
//let steve = Person(name: "steve")
//let macbook = Stuff(name: "MacBook Pro", owner: rei)
//var iMac = Stuff(name: "iMac", owner: rei)
//let iPhone = Stuff(name: "iPhone", owner: steve)
//
//let stuffNameKeyPath = \Stuff.name
//let ownerKeyPath = \Stuff.owner
//
//// \Stuff.owner.name과 같은 표현
//let ownerNameKeyPath = ownerKeyPath.appending(path: \.name)
//
//// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 가져온다.
//print(macbook[keyPath: stuffNameKeyPath]) // MacBook Pro
//print(iMac[keyPath: stuffNameKeyPath]) // iMac
//print(iPhone[keyPath: stuffNameKeyPath]) // iPhone
//
//print(macbook[keyPath: ownerNameKeyPath]) // rei
//print(iMac[keyPath: ownerNameKeyPath]) // rei
//print(iPhone[keyPath: ownerNameKeyPath]) // steve
//
//// 키 경로와 서브스크립트를 이용해 프로퍼티에 접근하여 값을 변경
//iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
//iMac[keyPath: ownerKeyPath] = steve
//
//print(iMac[keyPath: stuffNameKeyPath])  // iMac Pro
//print(iMac[keyPath: ownerNameKeyPath])  // steve






//// [ 클로저를 대체할 수 있는 키 경로 표현 ]
//
//struct Person {
//    let name: String
//    let nickname: String?
//    let age: Int
//    
//    var isAdult: Bool {
//        return age > 18
//    }
//}
//
//let rei: Person = Person(name: "rei", nickname: "dudqls", age: 100)
//let bitna: Person = Person(name: "bitna", nickname: "bit", age: 100)
//let geumzzok: Person = Person(name: "geumzzok", nickname: nil, age: 3)
//
//let family: [Person] = [rei, bitna, geumzzok]
//let names: [String] = family.map(\.name)    // ["rei", "bitna", "geumzzok"]
//let nicknames: [String] = family.compactMap(\.nickname) // ["dudqls", "bit"]
//let adults: [String] = family.filter(\.isAdult).map(\.name) // ["rei", "bitna"]





//// [ 클래스의 인스턴스 메서드 ]
//
//class LevelClass {
//    // 현재 레벨을 저장하는 저장 프로퍼티
//    var level: Int = 0 {
//        // 프로퍼티 값이 변경되면 호출하는 프로퍼티 감시자
//        didSet {
//            print("Level \(level)")
//        }
//    }
//    
//    // 레벨이 올랐을 때 호출할 메서드
//    func levelUp() {
//        print("Level Up!")
//        level += 1
//    }
//    
//    // 레벨이 감소했을 때 호출할 메서드
//    func levelDown() {
//        print("Level Down")
//        level -= 1
//        if level < 0 {
//            reset()
//        }
//    }
//    
//    // 특정 레벨로 이동할 때 호출할 메서드
//    func jumpLevel(to: Int) {
//        print("Jump to \(to)")
//        level = to
//    }
//    // 레벨을 초기화할 때 호출할 메서드
//    func reset() {
//        print("Reset!")
//        level = 0
//    }
//}
//
//var levelClassInstance: LevelClass = LevelClass()
//levelClassInstance.levelUp() // Level Up!
//// Level 1
//levelClassInstance.levelDown() // Level Down
//// Level 0
//levelClassInstance.levelDown() // Level Down
//// Level -1
//// Reset!
//// Level 0
//levelClassInstance.jumpLevel(to: 3) // Jump to 3
//// Level 3






//// [ mutating 키워드의 사용 ]
//struct LevelStruct {
//    var level: Int = 0 {
//        didSet {
//            print("Level \(level)")
//        }
//    }
//    
//    mutating func levelUp() {
//        print("Level Up!")
//        level += 1
//    }
//    
//    mutating func levelDown() {
//        print("Level Down")
//        level -= 1
//        if level < 0 {
//            reset()
//        }
//    }
//    
//    mutating func jumpLevel(to: Int) {
//        print("Jump to \(to)")
//        level = to
//    }
//    
//    mutating func reset() {
//        print("Reset!")
//        level = 0
//    }
//}
//
//var levelStructInstance: LevelStruct = LevelStruct()
//levelStructInstance.levelUp()   // Level Up!
//// Level 1
//levelStructInstance.levelDown() // Level Down
//// Level 0
//levelStructInstance.levelDown() // Level Down
//// Level -1
//// Reset!
//// Level 0
//levelStructInstance.jumpLevel(to: 3)    // Jump to 3
//// Level 3







//// [ self 프로퍼티와 mutating 키워드 ]
//
//class LevelClass {
//    var level: Int = 0
//    
//    func reset() {
//        // 오류!! - self 프로퍼티 참조 변경 불가
//        self = LevelClass()
//    }
//}
//
//struct LevelStruct {
//    var level: Int = 0
//    
//    mutating func levelUp() {
//        print("Level Up!")
//        level += 1
//    }
//    
//    mutating func reset() {
//        print("Reset!")
//        self = LevelStruct()
//    }
//}
//
//var levelStructInstance: LevelStruct = LevelStruct()
//levelStructInstance.levelUp()       // Level Up!
//print(levelStructInstance.level)    // 1
//
//levelStructInstance.reset()         // Reset!
//print(levelStructInstance.level)    // 0
//
//enum OnOffSwitch {
//    case on, off
//    mutating func nextState() {
//        self = self == .on ? .off : .on
//    }
//}
//
//var toggle: OnOffSwitch = OnOffSwitch.off
//toggle.nextState()
//print(toggle)   // on





//// [ Puppy 구조체에 callAsFunction 메서드 구현 ]
//
//struct Puppy {
//    var name: String = "멍멍이"
//    
//    func callAsFunction() {
//        print("멍멍")
//    }
//    
//    func callAsFunction(destination: String) {
//        print("\(destination)(으)로 달려갑니다.")
//    }
//    
//    func callAsFunction(something: String, times: Int) {
//        print("\(something)(을)를 \(times)번 반복합니다.")
//    }
//    
//    func callAsFunction(color: String) -> String {
//        return "\(color) 응가"
//    }
//    
//    mutating func callAsFunction(name: String) {
//        self.name = name
//    }
//}
//
//var doggy: Puppy = Puppy()
//
//doggy.callAsFunction() // 멍멍
//doggy() // 멍멍
//
//doggy.callAsFunction(destination: "집") // 집(으)로 달려갑니다.
//doggy(destination: "뒷동산")   // 뒷동산(으)로 달려갑니다.
//
//doggy(something: "재주넘기", times: 3)  // 재주넘기(을)를 3번 반복합니다.
//print(doggy(color: "무지개색")) // 무지개색 응가
//doggy(name: "댕댕이")
//print(doggy.name)   // 댕댕이






//// [ 클래스의 타입 메서드 ]
//class AClass {
//    static func staticTypeMethod() {
//        print("AClass staticTypeMethod")
//    }
//    
//    class func classTypeMethod() {
//        print("AClass classTypeMethod")
//    }
//}
//
//class BClass: AClass {
//    /*
//     // 오류 - 재정의 불가
//     override static func staticTypeMethod() {
//         
//     }
//     */
//    override class func classTypeMethod() {
//        print("BClass classTypeMethod")
//    }
//}
//
//AClass.staticTypeMethod()   // AClass staticTypeMethod
//AClass.classTypeMethod()    // AClass classTypeMethod
//BClass.staticTypeMethod()   // AClass staticTypeMethod
//BClass.classTypeMethod()    // BClass classTypeMethod





// [ 타입 프로퍼티와 타입 메서드의 사용 ]

// 시스템 음량은 한 기기에서 유일한 값이어야 한다.
struct SystemVolume {
    // 타입 프로퍼티를 사용하면 언제나 유일한 값이 됨
    static var volume: Int = 5
    
    // 타입 프로퍼티를 제어하기 위해 타입 메서드 사용
    static func mute() {
        // 타입 메서드에서 self는 타입 자체를 가리킨다.
        self.volume = 0 // SystemVolume.volume = 0 & Self.volume = 0 과 같은 표현
    }
}

// 내비게이션 역할은 여러 인스턴스가 수행할 수 있다.
class Navigation {
    
    // 내비게이션 인스턴스마다 음량을 따로 설정할 수 있다.
    var volume: Int = 5
    
    // 길 안내 음성 재생
    func guideWay() {
        // 내비게이션 외 다른 재생원 음소거
        SystemVolume.mute()
    }
    
    // 길 안내 음성 종료
    func finishGuideWay() {
        // 기존 재생원 음량 복구
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume) // 0

myNavi.finishGuideWay()
print(SystemVolume.volume) // 5
