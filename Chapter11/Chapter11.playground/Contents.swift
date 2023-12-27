import Foundation

//// [ 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저 ]
//
//class SomeClass {
//    init() {
//        // 초기화할 때 필요한 코드
//    }
//}
//
//struct SomeStruct {
//    init() {
//        // 초기화할 때 필요한 코드
//    }
//}
//
//enum SomeEnum {
//    case someCase
//    
//    init() {
//        // 열거형은 초기화할 때 반드시 case 중 하나가 되어야 함
//        self = .someCase
//        // 초기화할 때 필요한 코드
//    }
//}




//// [ Area 구조체와 이니셜라이저 ]
//
//struct Area {
//    var squareMeter: Double
//    
//    init() {
//        squareMeter = 0.0 // squareMeter의 초깃값 할당
//    }
//}
//
//let room: Area = Area()
//print(room.squareMeter) // 0.0




//// [ 프로퍼티 기본값 지정 ]
//
//struct Area {
//    var squareMeter: Double = 0.0 // 프로퍼티 기본값 할당
//}
//
//let room: Area = Area()
//print(room.squareMeter) // 0.0




//// [ 이니셜라이저 매개변수 ]
//
//struct Area {
//    var squareMeter: Double
//    
//    init(fromPy py: Double) {                   // 첫 번째 이니셜라이저
//        squareMeter = py * 3.3058
//    }
//    
//    init(fromSquareMeter squareMeter: Double) { // 두 번째 이니셜라이저
//        self.squareMeter = squareMeter
//    }
//    
//    init(value: Double) {                       // 세 번째 이니셜라이저
//        squareMeter = value
//    }
//    
//    init(_ value: Double) {                     // 네 번째 이니셜라이저
//        squareMeter = value
//    }
//}
//
//let roomOne: Area = Area(fromPy: 15.0)
//print(roomOne.squareMeter)  // 49.587
//
//let roomTwo: Area = Area(fromSquareMeter: 33.06)
//print(roomTwo.squareMeter)  // 33.06
//
//let roomThree: Area = Area(value: 30.0)
//let roomFour: Area = Area(55.0)
//
//Area() // 오류





//// [ Person 클래스 ]
//
//class Person {
//    var name: String
//    var age: Int?
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let rei: Person = Person(name: "rei")
//print(rei.name) // rei
//print(rei.age)  // nil
//
//rei.age = 99
//print(rei.age)  // Optional(99)




//// [ 상수 프로퍼티의 초기화 ]
//
//class Person {
//    let name: String
//    var age: Int?
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//let rei: Person = Person(name: "rei")
//rei.name = "reiKim" // 오류 발생





//// [ Point 구조체와 Size 구조체의 선언과 멤버와이즈 이니셜라이저의 사용 ]
//
//struct Point {
//    var x: Double = 0.0
//    var y: Double = 0.0
//}
//
//struct Size {
//    var width: Double = 0.0
//    var height: Double = 0.0
//}
//
//let point: Point = Point(x: 0, y: 0)
//let size: Size = Size(width: 50.0, height: 50.0)
//
//// 구조체의 저장 프로퍼티에 기본값이 있다면 필요한 매개변수만 사용해서 초기화하는 것도 가능
//let somePoint: Point = Point()
//let someSize: Size = Size(width: 50)
//let anotherPoint: Point = Point(y: 100)





//// [ Student 열거형과 초기화 위임 ]
//
//enum Student {
//    case elementary, middle, high
//    case none
//    
//    // 사용자 정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 사용할 수 있다.
//    init() {
//        self = .none
//    }
//    
//    init(koreanAge: Int) {                  // 첫 번째 사용자 정의 이니셜라이저
//        switch koreanAge {
//        case 8...13:
//            self = .elementary
//        case 14...16:
//            self = .middle
//        case 17...19:
//            self = .high
//        default:
//            self = .none
//        }
//    }
//    
//    init(bornAt: Int, currentYear: Int) {   // 두 번째 사용자 정의 이니셜라이저
//        self.init(koreanAge: currentYear - bornAt + 1)
//    }
//}
//
//var younger: Student = Student(koreanAge: 16)
//print(younger)  // middle
//
//younger = Student(bornAt: 1998, currentYear: 2016)
//print(younger)  // high






//// [ 실패 가능한 이니셜라이저 ]
//
//class Person {
//    let name: String
//    var age: Int?
//    
//    init?(name: String) {
//        
//        if name.isEmpty {
//            return nil
//        }
//        self.name = name
//    }
//    
//    init?(name: String, age: Int) {
//        if name.isEmpty || age < 0 {
//            return nil
//        }
//        self.name = name
//        self.age = age
//    }
//}
//
//let rei: Person? = Person(name: "rei", age: 99)
//
//if let person: Person = rei {
//    print(person.name)
//} else {
//    print("Person wasn't initialized")
//}
//// rei
//
//let steve: Person? = Person(name: "steve", age: -10)
//
//if let person: Person = steve {
//    print(person.name)
//} else {
//    print("Person wasn't initialized")
//}
//// Person wasn't initialized






//// [ 열거형의 실패 가능한 이니셜라이저 ]
//
//enum Student: String {
//    case elementary = "초등학생", middle = "중학생", high = "고등학생"
//    
//    init?(koreanAge: Int) {
//        switch koreanAge {
//        case 8...13:
//            self = .elementary
//        case 14...16:
//            self = .middle
//        case 17...19:
//            self = .high
//        default:
//            return nil
//        }
//    }
//    
//    init?(bornAt: Int, currentYear: Int) {
//        self.init(koreanAge: currentYear - bornAt + 1)
//    }
//}
//
//var younger: Student? = Student(koreanAge: 20)
//print(younger)  // nil
//
//younger = Student(bornAt: 1998, currentYear: 2023)
//print(younger)  // nil
//
//younger = Student(rawValue: "대학생")
//print(younger)  // nil
//
//younger = Student(rawValue: "고등학생")
//print(younger)  // high





//// [ 클로저를 통한 프로퍼티 기본값 설정 ]
//
//class SomeClass {
//    let someProperty: SomeType = {
//        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해준다.
//        // 반환되는 값의 타입은 SomeType과 같은 타입이어야 함
//        return someValue
//    }()
//}




//// [ 클로저를 통한 Student 프로퍼티 기본값 설정 ]
//
//struct Student {
//    var name: String?
//    var number: Int?
//}
//
//class SchoolClass {
//    var students: [Student] = {
//        var arr: [Student] = [Student]()
//        
//        for num in 1...15 {
//            var student: Student = Student(name: nil, number: num)
//            arr.append(student)
//        }
//        
//        return arr
//    }()
//}
//
//let myClass: SchoolClass = SchoolClass()
//print(myClass.students.count) // 15






//// [ 디이니셜라이저의 구현 ]
//
//class SomeClass {
//    deinit {
//        print("Instance will be deallocated immediately")
//    }
//}
//
//var instance: SomeClass? = SomeClass()
//instance = nil // Instance will be deallocated immediately






// [ FileManager 클래스의 디이니셜라이저 활용 ]

class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File: \(self.fileName)")
    }
    
    func writeFile() {
        print("Write File: \(self.fileName)")
    }
    
    func closeFile() {
        print("Close File: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile()      // Open File: abc.txt
    manager.modifyFile()    // Modify File: abc.txt
}

fileManager = nil
// Deinit instance
// Write File: abc.txt
// Close File: abc.txt
