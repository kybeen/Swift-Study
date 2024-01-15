import UIKit

//// [ 기반클래스 Person ]
//
//class Person {
//    var name: String = ""
//    var age: Int = 0
//    
//    var introduction: String {
//        return "이름: \(name). 나이: \(age)"
//    }
//    
//    func speak() {
//        print("야호ㅋ")
//    }
//}

//let rei: Person = Person()
//rei.name = "rei"
//rei.age = 26
//print(rei.introduction) // 이름: rei. 나이: 26
//rei.speak() // 야호ㅋ




//// [ Person 클래스를 상속받은 Student 클래스 ]
//
//class Student: Person {
//    var grade: String = "F"
//    
//    func study() {
//        print("Study hard...")
//    }
//}

//let rei: Person = Person()
//rei.name = "rei"
//rei.age = 26
//print(rei.introduction) // 이름: rei. 나이: 26
//rei.speak()             // 야호ㅋ
//
//let son: Student = Student()
//son.name = "son"
//son.age = 30
//son.grade = "A"
//print(son.introduction) // 이름: son. 나이: 30
//son.speak()             // 야호ㅋ
//son.study()             // Study hard...





//// [ Student 클래스를 상속받은 UniversityStudent 클래스 ]
//
//class UniversityStudent: Student {
//    var major: String = ""
//}
//
//let minjae: UniversityStudent = UniversityStudent()
//minjae.major = "Art"
//minjae.speak()              // 야호ㅋ
//minjae.study()              // Study hard...






//// [ 메서드 재정의 ]
//
//class Person {
//    var name: String = ""
//    var age: Int = 0
//    
//    var introduction: String {
//        return "이름: \(name). 나이: \(age)"
//    }
//    
//    func speak() {
//        print("야호ㅋ")
//    }
//    
//    // class : 상속 후 메서드 재정의가 가능한 타입 메서드
//    class func introduceClass() -> String {
//        return "인류의 소원은 평화"
//    }
//}
//
//class Student: Person {
//    var grade: String = "F"
//    
//    func study() {
//        print("Study hard...")
//    }
//    
//    override func speak() {
//        print("저는 학생입니다.")
//    }
//}
//
//class UniversityStudent: Student {
//    var major: String = ""
//    
//    class func introduceClass() {
//        print(super.introduceClass())
//    }
//    
//    override class func introduceClass() -> String {
//        return "대학생의 소원은 A+"
//    }
//    
//    override func speak() {
//        super.speak() // Student 클래스에서 재정의한 speak()가 호출
//        print("대학생이죠.")
//    }
//}
//
//let rei: Person = Person()
//rei.speak()     // 야호ㅋ
//
//let son: Student = Student()
//son.speak()     // 저는 학생입니다.
//
//let minjae: UniversityStudent = UniversityStudent()
//minjae.speak()  // 저는 학생입니다. 대학생이죠.
//
//print(Person.introduceClass())      // 인류의 소원은 평화
//print(Student.introduceClass())     // 인류의 소원은 평화
//print(UniversityStudent.introduceClass() as String) // 대학생의 소원은 A+
//UniversityStudent.introduceClass() as Void          // 인류의 소원은 평화








//// [ 프로퍼티 재정의 ]
//
//class Person {
//    var name: String = ""
//    var age: Int = 0
//    var koreanAge: Int {
//        return self.age + 1
//    }
//    
//    var introduction: String {
//        return "이름: \(name). 나이: \(age)"
//    }
//}
//
//class Student: Person {
//    var grade: String = "F"
//    
//    override var introduction: String {
//        return super.introduction + " " + "학점 : \(self.grade)"
//    }
//    
//    // 읽기 전용이었던 koreanAge 프로퍼티를 읽기/쓰기가 모두 가능하도록 재정의
//    override var koreanAge: Int {
//        get {
//            return super.koreanAge
//        }
//        
//        set {
//            self.age = newValue - 1
//        }
//    }
//}
//
//let rei: Person = Person()
//rei.name = "rei"
//rei.age = 25
////rei.koreanAge = 27        // Person 타입에는 koreanAge 설정자가 없기 때문에 오류 발생
//print(rei.introduction)     // 이름: rei. 나이: 25
//print(rei.koreanAge)        // 26
//
//let son: Student = Student()
//son.name = "son"
//son.age = 30
//son.koreanAge = 31
//print(son.introduction)     // 이름: son. 나이: 30 학점 : F
//print(son.koreanAge)        // 31








//// [ 프로퍼티 감시자 재정의 ]
//
//class Person {
//    var name: String = ""
//    var age: Int = 0 {
//        didSet {
//            print("Person age : \(self.age)")
//        }
//    }
//    var koreanAge: Int {
//        return self.age + 1
//    }
//    
//    var fullName: String {
//        get {
//            return self.name
//        }
//        
//        set {
//            self.name = newValue
//        }
//    }
//}
//
//class Student: Person {
//    var grade: String = "F"
//    
//    override var age: Int {
//        didSet {
//            print("Student age : \(self.age)")
//        }
//    }
//    
//    override var koreanAge: Int {
//        get {
//            return super.koreanAge
//        }
//        
//        set {
//            self.age = newValue - 1
//        }
//        
////        didSet {  } // 프로퍼티의 접근자와 프로퍼티 감시자는 동시에 재정의할 수 ❌ 오류 발생!!
//    }
//    
//    override var fullName: String {
//        didSet {
//            print("Full Name : \(self.fullName)")
//        }
//    }
//}
//
//let rei: Person = Person()
//rei.name = "rei"
//rei.age = 25                // Person age : 25
//rei.fullName = "rei Kim"
//print(rei.koreanAge)        // 26
//
//let son: Student = Student()
//son.name = "son"
//son.age = 30 // Person과 Student에 정의한 감시자가 모두 동작
//// Person age : 30
//// Student age : 30
//son.koreanAge = 31
//// Person age : 30
//// Student age : 30
//son.fullName = "Son hm" // Full Name : Son hm
//print(son.koreanAge)    // 31









//// [ 서브스크립트 재정의 ]
//
//class School {
//    var students: [Student] = [Student]()
//    
//    subscript(number: Int) -> Student {
//        print("School subscript")
//        return students[number]
//    }
//}
//
//class MiddleSchool: School {
//    var middleStudents: [Student] = [Student]()
//    
//    // 부모클래스(School)에게 상속받은 서브스크립트 재정의
//    override subscript(index: Int) -> Student {
//        print("MiddleSchool subscript")
//        return middleStudents[index]
//    }
//}
//
//let university: School = School()
//university.students.append(Student())
//university[0]   // School subscript
//
//let middle: MiddleSchool = MiddleSchool()
//middle.middleStudents.append(Student())
//middle[0]       // MiddleSchool subscript







//// [ final 키워드의 사용 ]
//
//class Person {
//    final var name: String = ""
//    
//    final func speak() {
//        print("가나다라마바사")
//    }
//}
//
//final class Student: Person {
//    // Person의 name은 final로 재정의를 막아놨기 때문에 오류 발생
//    override var name: String {
//        set {
//            super.name = newValue
//        }
//        
//        get {
//            return "학생"
//        }
//    }
//    
//    // Person의 speak()는 final로 재정의를 막아놨기 때문에 오류 발생
//    override func speak() {
//        print("저는 학생입니다.")
//    }
//}
//
//// Student 클래스는 final로 상속을 막아놨기 때문에 오류 발생
//class UniversityStudent: Student { }






//// [ Person 클래스를 상속받은 Student 클래스 ]
//
//class Person {
//    var name: String
//    var age: Int
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//}
//
//
//class Student: Person {
//    var major: String
//    
//    // 지정 이니셜라이저
//    init(name: String, age: Int, major: String) {
//        // 안전확인 1 ✅  부모 클래스의 지정 이니셜라이저를 호출하기 전에 자신의 self 프로퍼티를 이용해 major 프로퍼티의 값을 할당
//        self.major = "Swift"
//        // 안전확인 2 ✅ 부모클래스의 이니셜라이저 호출 (상속받은 프로퍼티는 따로 없기 때문에 부모의 이니셜라이저 호출 이후 값을 할당해줄 프로퍼티는 없다.)
//        super.init(name: name, age: age)
//    }
//    
//    // 편의 이니셜라이저
//    convenience init(name: String) {
//        // 안전확인 3 ✅ 따로 차후에 값을 할당할 프로퍼티가 없고, 다른 이니셜라이저를 호출함
//        self.init(name: name, age: 7, major: "")
//    }
//    
//    // 안전확인 4 ✅ 이니셜라이저 어디에서도 인스턴스 메서드를 호출하거나 인스턴스 프로퍼티의 값을 읽어오지 않았으므로 조건 만족
//}









//// [ 클래스 이니셜라이저 재정의 ]
//
//class Person {
//    var name: String
//    var age: Int
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//    
//    convenience init(name: String) {
//        self.init(name: name, age: 0)
//    }
//}
//
//class Student: Person {
//    var major: String
//    
//    // 부모클래스의 Person의 지정 이니셜라이저는 재정의를 위해 override 수식어 사용
//    override init(name: String, age: Int) {
//        self.major = "Swift"
//        super.init(name: name, age: age)
//    }
//    
//    // 부모클래스인 Person과 동일한 편의 이니셜라이저를 재정의 ➡️ override를 붙이지x
//    convenience init(name: String) {
//        self.init(name: name, age: 7)
//    }
//}








//// [ 실패 가능한 이니셜라이저 재정의 ]
//
//class Person {
//    var name: String
//    var age: Int
//    
//    init() {
//        self.name = "Unknown"
//        self.age = 0
//    }
//    
//    init?(name: String, age: Int) {
//        if name.isEmpty {
//            return nil
//        }
//        self.name = name
//        self.age = age
//    }
//    
//    init?(age: Int) {
//        
//        if age < 0 {
//            return nil
//        }
//        self.name = "Unknown"
//        self.age = age
//    }
//}
//
//class Student: Person {
//    var major: String
//    
//    // 부모 클래스와 동일하게 실패 가능한 이니셜라이저로 재정의
//    override init?(name: String, age: Int) {
//        self.major = "Swift"
//        super.init(name: name, age: age)
//    }
//    
//    // 부모 클래스와 다르게 실패하지 않는 이니셜라이저로 재정의
//    override init(age: Int) {
//        self.major = "Swift"
//        super.init()
//    }
//}










//// [ 이니셜라이저 자동 상속 ]
//
//class Person {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    convenience init() {
//        self.init(name: "Unknown")
//    }
//}
//
//class Student: Person {
//    var major: String = "Swift" // 기본값 있음
//}
//
//// 부모클래스의 지정 이니셜라이저 자동 상속
//let rei: Person = Person(name: "rei")
//let son: Student = Student(name: "son")
//print(rei.name) // rei
//print(son.name) // son
//
//// 부모클래스의 편의 이니셜라이저 자동 상속
//let jisung: Person = Person()
//let minjae: Student = Student()
//print(jisung.name)  // Unknown
//print(minjae.name)  // Unknown






//// [ 편의 이니셜라이저 자동 상속 ]
//
//class Person {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    convenience init() {
//        self.init(name: "Unknown")
//    }
//}
//
//class Student: Person {
//    // 기본값이 없더라도 이니셜라이저에서 적절히 초기화했고, 부모클래스의 지정 이니셜라이저를 모두 재정의했기 때문에
//    // 부모 클래스의 지정 이니셜라이저와 동일한 이니셜라이저를 모두 사용할 수 있는 상황
//    // 👉 규칙1에 부합 👉 편의 이니셜라이저가 자동으로 상속
//    var major: String
//    
//    override init(name: String) {
//        self.major = "Unknown"
//        super.init(name: name)
//    }
//    
//    init(name: String, major: String) {
//        self.major = major
//        super.init(name: name)
//    }
//}
//
//// 부모클래스의 편의 이니셜라이저 자동 상속
//let jisung: Person = Person()
//let minjae: Student = Student()
//print(jisung.name)  // Unknown
//print(minjae.name)  // Unknown







//// [ 편의 이니셜라이저 자동 상속 2 ]
//
//class Person {
//    var name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//    
//    convenience init() {
//        self.init(name: "Unknown")
//    }
//}
//
//class Student: Person {
//    var major: String
//    
//    // 자신만의 편의 이니셜라이저 (편의 이니셜라이저 자동 상속에는 아무 영향을 미치지 x)
//    convenience init(major: String) {
//        self.init()
//        self.major = major
//    }
//    
//    // 부모 클래스의 지정 이니셜라이저를 자식클래스의 편의 이니셜라이저로 구현하더라도 부모의 지정 이니셜라이저를 모두 사용할 수 있음
//    // 👉 규칙2를 충족 👉 편의 이니셜라이저가 자동으로 상속
//    override convenience init(name: String) {
//        self.init(name: name, major: "Unknown")
//    }
//    
//    init(name: String, major: String) {
//        self.major = major
//        super.init(name: name)
//    }
//}
//
//// 부모클래스의 편의 이니셜라이저 자동 상속
//let jisung: Person = Person()
//let minjae: Student = Student(major: "Swift")
//print(jisung.name)  // Unknown
//print(minjae.name)  // Unknown
//print(minjae.major) // Swift








//// [ 편의 이니셜라이저 자동 상속 3 ]
//
//class UniversityStudent: Student {
//    var grade: String = "A+" // 기본값 있음
//    var description: String {
//        return "\(self.name) \(self.major) \(self.grade)"
//    }
//    
//    // 자신만의 편의 이니셜라이저를 구현 👉 자동 상속에는 영향을 미치지 않는다.
//    convenience init(name: String, major: String, grade: String) {
//        self.init(name: name, major: major)
//        self.grade = grade
//    }
//    
//    // 별도의 지정 이니셜라이저를 구현하지 않음
//    // 👉 규칙1를 충족 👉 부모클래스의 이니셜라이저를 모두 자동 상속
//    
//    // 결과적으로 UniversityStudent 클래스는 상속받은 이니셜라이저와 자신의 편의 이니셜라이저들을 모두 사용할 수 있다.
//}
//
//let nova: UniversityStudent = UniversityStudent()
//print(nova.description)     // Unknown Unknown A+
//
//let raon: UniversityStudent = UniversityStudent(name: "raon")
//print(raon.description)     // raon Unknown A+
//
//let joker: UniversityStudent = UniversityStudent(name: "joker", major: "Programming")
//print(joker.description)    // joker Programming A+
//
//let chope: UniversityStudent = UniversityStudent(name: "chope", major: "Computer", grade: "C")
//print(chope.description)    // chope Computer C







//// [ 요구 이니셜라이저 정의 ]
//
//class Person {
//    var name: String
//    
//    // 요구 이니셜라이저 정의
//    required init() {
//        self.name = "Unknown"
//    }
//}
//
//class Student: Person {
//    // 프로퍼티에 기본값이 있으며 별다른 지정 이니셜라이저가 없기 때문에 Pereson의 이니셜라이저가 자동으로 상속됨
//    // 👉 required init()이 자동으로 상속돼서 따로 구현해줄 필요 x
//    var major: String = "Unknown"
//}
//
//let rei: Student = Student()
//print(rei.name) // Unknown





//// [ 요구 이니셜라이저 재구현 ]
//
//class Person {
//    var name: String
//    
//    // 요구 이니셜라이저 정의
//    required init() {
//        self.name = "Unknown"
//    }
//}
//
//class Student: Person {
//    var major: String = "Unknown"
//    
//    // 자신의 지정 이니셜라이저 구현
//    init(major: String) {
//        self.major = major
//        super.init()
//    }
//    
//    // 부모클래스로부터 이니셜라이저가 자동으로 상속되지 않으므로 요구 이니셜라이저를 구현해주어야 한다.
//    required init() {
//        self.major = "Unknown"
//        super.init()
//    }
//}
//
//class UniversityStudent: Student {
//    var grade: String
//    
//    // 자신의 지정 이니셜라이저 구현
//    init(grade: String) {
//        self.grade = grade
//        super.init()
//    }
//    
//    required init() {
//        self.grade = "F"
//        super.init()
//    }
//}
//
//let jiSoo: Student = Student()
//print("\(jiSoo.name) \(jiSoo.major)")                       // Unknown Unknown
//
//let rei: Student = Student(major: "Swift")
//print("\(rei.name) \(rei.major)")                           // Unknown Swift
//
//let juHyun: UniversityStudent = UniversityStudent(grade: "A+")
//print("\(juHyun.name) \(juHyun.major) \(juHyun.grade)")     // Unknown Unknown A+







// [ 일반 이니셜라이저의 요구 이니셜라이저 변경 ]

class Person {
    var name: String
    
    init() {
        self.name = "Unknown"
    }
}

class Student: Person {
    var major: String = "Unknown"
    
    init(major: String) {
        self.major = major
        super.init()
    }
    
    // 부모클래스의 이니셜라이저를 재정의함과 동시에
    // 요구 이니셜라이저로 변경됨을 알림
    required override init() {
        self.major = "Unknown"
        super.init()
    }
    
    // 이 요구 이니셜라이저는 앞으로 계속 요구한다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class UniversityStudent: Student {
    var grade: String
    
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    // Student 클래스에서 요구했으므로 구현해주어야 함
    required init() {
        self.grade = "F"
        super.init()
    }
    
    // Student 클래스에서 요구했으므로 구현해주어야 함
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

let rei: UniversityStudent = UniversityStudent()
print("\(rei.name) \(rei.major) \(rei.grade)")  // Unknown Unknown F

let son: UniversityStudent = UniversityStudent(name: "son")
print("\(son.name) \(son.major) \(son.grade)")  // son Unknown F
