
//// [ 타입의 프로토콜 채택 ]
//
//struct SomeStruct: AProtocol, AnotherProtocol {
//    // 구조체 정의
//}
//
//struct SomeClass: AProtocol, AnotherProtocol {
//    // 클래스 정의
//}
//
//struct SomeEnum: AProtocol, AnotherProtocol {
//    // 열거형 정의
//}

//
//struct SomeClass: SuperClass, AProtocol, AnotherProtocol {
//    // 클래스 정의
//}





//// [ 프로퍼티 요구 ]
//
//protocol SomeProtocol {
//    var settableProperty: String { get set }        // 읽기﹒쓰기 모두 요구
//    var notNeedToBeSettableProperty: String { get } // 읽기만 가능하다면 어떻게 구현해도 상관x
//}
//
//protocol AnotherProtocol {
//    // 타입 프로퍼티 요구
//    static var someTypeProperty: Int { get set }
//    static var anotherTypeProperty: Int { get }
//}






//// [ Sendable 프로토콜과 Sendable 프로토콜을 준수하는 Message와 Mail 클래스 ]
//
//protocol Sendable {
//    var from: String { get }
//    var to: String { get }
//}
//
//class Message: Sendable {
//    var sender: String
//    var from: String { // 읽기 전용 연산 프로퍼티
//        return self.sender
//    }
//    
//    var to: String
//    
//    init(sender: String, receiver: String) {
//        self.sender = sender
//        self.to = receiver
//    }
//}
//
//class Mail: Sendable {
//    var from: String
//    var to: String
//    
//    init(sender: String, receiver: String) {
//        self.from = sender
//        self.to = receiver
//    }
//}





//// [ Receiveable, Sendable 프로토콜과 두 프로토콜을 준수하는 Message와 Mail 클래스 ]
//
//// 무언가를 수신받을 수 있는 기능
//protocol Receiveable {
//    func received(data: Any, from: Sendable)
//}
//
//// 무언가를 발신할 수 있는 기능
//protocol Sendable {
//    var from: Sendable { get }
//    var to: Receiveable? { get }
//    
//    func send(data: Any)
//    
//    static func isSendableInstance(_ instance: Any) -> Bool
//}
//
//// 수신, 발신이 가능한 Message 클래스
//class Message: Sendable, Receiveable {
//    // 발신은 발신 가능한 객체 → Sendable 프로토콜을 준수하는 타입의 인스턴여야 한다.
//    var from: Sendable {
//        return self
//    }
//    
//    // 상대방은 수신 가능한 객체 → Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 한다.
//    var to: Receiveable?
//    
//    // 메시지를 발신
//    func send(data: Any) {
//        guard let receiver: Receiveable = self.to else {
//            print("Message has no receiver")
//            return
//        }
//        // 수신 가능한 인스턴스의 received 메서드를 호출한다.
//        receiver.received(data: data, from: self.from)
//    }
//    
//    // 메시지를 수신
//    func received(data: Any, from: Sendable) {
//        print("Message received \(data) from \(from)")
//    }
//    
//    // class 메서드이므로 상속이 가능
//    class func isSendableInstance(_ instance: Any) -> Bool {
//        if let sendableInstance: Sendable = instance as? Sendable {
//            return sendableInstance.to != nil
//        }
//        return false
//    }
//}
//
//// 수신, 발신이 가능한 Mail 클래스
//class Mail: Sendable, Receiveable {
//    var from: Sendable {
//        return self
//    }
//    
//    var to: Receiveable?
//    
//    func send(data: Any) {
//        guard let receiver: Receiveable = self.to else {
//            print("Mail has no receiver")
//            return
//        }
//        receiver.received(data: data, from: self.from)
//    }
//    
//    func received(data: Any, from: Sendable) {
//        print("Mail received \(data) from \(from)")
//    }
//    
//    // static 메서드이므로 상속이 불가능
//    static func isSendableInstance(_ instance: Any) -> Bool {
//        if let sendableInstance: Sendable = instance as? Sendable {
//            return sendableInstance.to != nil
//        }
//        return false
//    }
//}
//
//// 두 Message 인스턴스를 생성
//let myPhoneMessage: Message = Message()
//let yourPhoneMessage: Message = Message()
//
//// 아직 수신받을 인스턴스가 없음
//myPhoneMessage.send(data: "Hello")  // Message has no receiver
//
//// Message 인스턴스는 발신과 수신이 모두 가능하므로 메시지를 주고 받을 수 있다.
//myPhoneMessage.to = yourPhoneMessage
//myPhoneMessage.send(data: "Hello")  // Message received Hello from Message
//
//// 두 Mail 인스턴스를 생성
//let myMail: Mail = Mail()
//let yourMail: Mail = Mail()
//
//myMail.send(data: "Hi")     // Mail has no receiver
//
//// Mail과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로 서로 주고 받을 수 있다.
//myMail.to = yourMail
//myMail.send(data: "Hi")     // Mail received Hi from Mail
//
//myMail.to = myPhoneMessage
//myMail.send(data: "Bye")    // Message received Bye from Mail
//
//// String은 Sendable 프로토콜을 준수하지 X
//Message.isSendableInstance("Hello")             // false
//
//// Mail과 Message는 Sendable 프로토콜을 준수한다.
//Message.isSendableInstance(myPhoneMessage)      // true
//
//// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태
//Message.isSendableInstance(yourPhoneMessage)    // false
//Mail.isSendableInstance(myPhoneMessage)         // true
//Mail.isSendableInstance(myMail)                 // true







//// [ Resettable 프로토콜의 가변 메서드 요구 ]
//
//protocol Resettable {
//    mutating func reset()
//}
//
//class Person: Resettable {
//    var name: String?
//    var age: Int?
//    
//    func reset() {
//        self.name = nil
//        self.age = nil
//    }
//}
//
//struct Point: Resettable {
//    var x: Int = 0
//    var y: Int = 0
//    
//    mutating func reset() {
//        self.x = 0
//        self.y = 0
//    }
//}
//
//enum Direction: Resettable {
//    case east, west, south, north, unknown
//    
//    mutating func reset() {
//        self = Direction.unknown
//    }
//}






//// [ 프로토콜의 이니셜라이저 요구와 구조체의 이니셜라이저 요구 구현 ]
//
//protocol Named {
//    var name: String { get }
//    
//    init(name: String)
//}
//
//struct Pet: Named {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}




//// [ 클래스의 이니셜라이저 요구 구현 ]
//
//class Person: Named {
//    var name: String
//    
//    // 프로토콜에서 요구하는 이니셜라이저를 클래스에서 구현할 때는 required 필요
//    required init(name: String) {
//        self.name = name
//    }
//}




//// [ 상속 불가능한 클래스의 이니셜라이저 요구 구현 ]
//
//final class Person: Named {
//    var name: String
//    
//    // final 클래스에는 required를 적을 필요 x
//    init(name: String) {
//        self.name = name
//    }
//}





//// [ 상속받은 클래스의 이니셜라이저 요구 구현 및 재정의 ]
//
//class School {
//    var name: String
//    
//    // Named 프로토콜을 채택하지 않았지만 Named 프로토콜에서 요구하는 이니셜라이저가 있음
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class MiddleSchool: School, Named {
//    // Named 프로토콜에서 요구하는 이니셜라이저와 동일한 이니셜라이저가 부모 클래스인 School에 구현되어 있기 때문에
//    // required override 키워드 둘 다 적어줘야 함
//    required override init(name: String) {
//        super.init(name: name)
//    }
//}





//// [ 실패 가능한 이니셜라이저 요구를 포함하는 Named 프로토콜과 Named 프로토콜을 준수하는 다양한 타입들 ]
//
//protocol Named {
//    var name: String { get }
//    
//    init?(name: String) // 실패 가능한 이니셜라이저 요구
//}
//
//
//struct Animal: Named {
//    var name: String
//    
//    // 실패 가능한 이니셜라이저 (옵셔널이 아닌 인스턴스를 반환하는)
//    init!(name: String) {
//        self.name = name
//    }
//}
//
//struct Pet: Named {
//    var name: String
//    
//    // 실패하지 않는 이니셜라이저
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Person: Named {
//    var name: String
//    
//    // 실패하지 않는 요구 이니셜라이저
//    required init(name: String) {
//        self.name = name
//    }
//}
//
//class School: Named {
//    var name: String
//    
//    // 실패 가능한 요구 이니셜라이저
//    required init?(name: String) {
//        self.name = name
//    }
//}






//// [ 프로토콜의 상속 ]
//
//protocol Readable {
//    func read()
//}
//
//protocol Writeable {
//    func write()
//}
//
//protocol ReadSpeakable: Readable {
//    func speak()
//}
//
//protocol ReadWriteSpeakable: Readable, Writeable {
//    func speak()
//}
//
//
//class SomeClass: ReadWriteSpeakable {
//    func read() {
//        print("Read")
//    }
//    
//    func write() {
//        print("Write")
//    }
//    
//    func speak() {
//        print("Speak")
//    }
//}




//// [ 클래스 전용 프로토콜의 정의 ]
//
//protocol ClassOnlyProtocol: class, Readable, Writeable {
//    func onlyClassMethod()
//}
//
//class SomeClass: ClassOnlyProtocol {
//    func read() {
//        print("Read")
//    }
//    
//    func write() {
//        print("Write")
//    }
//    
//    func onlyClassMethod() {
//        print("Conform Only Class Protocol")
//    }
//}
//
//// ClassOnlyProtocol 프로토콜은 클래스 타입에만 채택 가능하기 때문에 오류!!
//struct SomeStruct: ClassOnlyProtocol {
//    func read() { }
//    func write() { }
//}








//// [ 프로토콜 조합 및 프로토콜, 클래스 조합 ]
//
//protocol Named {
//    var name: String { get }
//}
//
//protocol Aged {
//    var age: Int { get }
//}
//
//struct Person: Named, Aged {
//    var name: String
//    var age: Int
//}
//
//class Car: Named {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//class Truck: Car, Aged {
//    var age: Int
//    
//    init(name: String, age: Int) {
//        self.age = age
//        super.init(name: name)
//    }
//}
//
//func celebrateBirthday(to celebrator: Named & Aged) {
//    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
//}
//
//let rei: Person = Person(name: "rei", age: 99)
//celebrateBirthday(to: rei)      // Happy birthday rei!! Now you are 99
//
//let myCar: Car = Car(name: "Boong Boong")
////celebrateBirthday(to: myCar)    // 오류 발생!! Aged를 충족시키지 못하기 때문
//
//// 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합할 수 있기 때문에 오류 발생!!
////var someVariable: Car & Truck & Aged
//
//// Car 클래스의 인스턴스 역할도 수행할 수 있고,
//// Aged 프로토콜을 준수하는 인스턴스만 할당할 수 있다.
//var someVariable: Car & Aged
//
//// Truck 인스턴스는 Car 클래스 역할도 할 수 있고, Aged 프로토콜도 준수하므로 할당할 수 있다.
//someVariable = Truck(name: "Truck", age: 5)
//
//// Car의 인스턴스인 myCar는 Aged 프로토콜을 준수하지 않으므로 할당할 수 없다.
//// 오류 발생!!
////someVariable = myCar







//// [ 프로토콜 확인 및 캐스팅 ]
//
//print(rei is Named)     // true
//print(rei is Aged)      // true
//
//print(myCar is Named)   // true
//print(myCar is Aged)    // false
//
//if let castedInstance: Named = rei as? Named {
//    print("\(castedInstance.name) is Named") // rei is Named
//}
//
//if let castedInstance: Aged = rei as? Aged {
//    print("\(castedInstance) is Aged 👉 \(castedInstance.age)살임")   // Person(name: "rei", age: 99) is Aged 👉 99살임
//}
//
//if let castedInstance: Named = myCar as? Named {
//    print("\(castedInstance) is Named")     // __lldb_expr_37.Car is Named
//}
//
//if let castedInstance: Aged = myCar as? Aged {
//    print("\(castedInstance) is Aged")      // 출력 없음...캐스팅 실패
//}









//// [ 프로토콜의 선택적 요구 ]
//
//import Foundation
//
//@objc protocol Movable {
//    func walk()
//    @objc optional func fly()
//}
//
//// 걷기만 할 수 있는 호랑이
//// @objc 속성의 프로토콜을 사용하기 위해 Objective-C의 클래스인 NSObject를 상속
//class Tiger: NSObject, Movable {
//    func walk() {
//        print("Tiger walks")
//    }
//}
//
//// 걷고 날 수 있는 새
//class Bird: NSObject, Movable {
//    func walk() {
//        print("Bird walks")
//    }
//    
//    func fly() {
//        print("Bird flies")
//    }
//}
//
//let tiger: Tiger = Tiger()
//let bird: Bird = Bird()
//
//tiger.walk()    // Tiger walks
////tiger.fly?() // Tiger의 인스턴스 구현 시에 fly() 메서드가 구현되어 있지 않은 것을 확인할 수 있기 때문에 오류 (사용할 수 x)
//bird.walk()     // Bird walks
//bird.fly()      // Bird flies
//
//var movableInstance: Movable = tiger
//
//// Movable 프로토콜 변수에 할당되었을 때는 인스턴스의 타입에 실제로 fly() 메서드가 구현되어 있는지 알 수 없으므로
//// 옵셔널 체인을 통해 메서드 호출 시도
//movableInstance.fly?()  // 응답 없음
//
//movableInstance = bird
//movableInstance.fly?()  // Bird fliss











/// 좀만 위로 올려보면 있는 *[📌이니셜라이저 요구 - 실패 가능한 이니셜라이저]* 설명 부분의 예시 코드에서 정의한 프로토콜, 클래스 사용
protocol Named {
    var name: String { get }
    
    init?(name: String) // 실패 가능한 이니셜라이저 요구
}


struct Animal: Named {
    var name: String
    
    // 실패 가능한 이니셜라이저 (옵셔널이 아닌 인스턴스를 반환하는)
    init!(name: String) {
        self.name = name
    }
}

struct Pet: Named {
    var name: String
    
    // 실패하지 않는 이니셜라이저
    init(name: String) {
        self.name = name
    }
}

class Person: Named {
    var name: String
    
    // 실패하지 않는 요구 이니셜라이저
    required init(name: String) {
        self.name = name
    }
}

class School: Named {
    var name: String
    
    // 실패 가능한 요구 이니셜라이저
    required init?(name: String) {
        self.name = name
    }
}


// [ 프로토콜 타입 변수 ]
var someNamed: Named = Animal(name: "Animal")
someNamed = Pet(name: "Pet")
someNamed = Person(name: "Person")
someNamed = School(name: "School")!
