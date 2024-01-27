

//// [ 중첩 데이터 타입 구현 ]
//
//class Person {
//    // Person 클래스 내부의 중첩 데이터 타입인 Job 열거형 타입
//    enum Job {
//        case jobless, programmer, student
//    }
//    
//    var job: Job = .jobless
//}
//
//class Student: Person {
//    // Student 클래스 내부의 중첩 데이터 타입인 School 열거형 타입
//    enum School {
//        case elementary, middle, high
//    }
//    
//    var school: School
//    
//    init(school: School) {
//        self.school = school
//        super.init()
//        self.job = .student
//    }
//}
//
//// 👉 Job 열거형은 Person 내부에 정의되어 있지만 Person을 상속받은 Student 클래스의 중첩 데이터 타입으로도 취급할 수 있다.
//let personJob: Person.Job = .jobless
//let studentJob: Student.Job = .student
//
//let student: Student = Student(school: .middle)
//print(student.job)      // student
//print(student.school)   // middle




// [ 같은 이름의 중첩 데이터 타입 구현 ]

struct Sports {
    enum GameType {
        case football, basketball
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var time: Int
        var player: Int
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
        case .basketball:
            return GameInfo(time: 40, player: 5)
        case .football:
            return GameInfo(time: 90, player: 11)
        }
    }
}

struct ESports {
    enum GameType {
        case online, offline
    }
    
    var gameType: GameType
    
    struct GameInfo {
        var location: String
        var package: String
    }
    
    var gameInfo: GameInfo {
        switch self.gameType {
        case .online:
            return GameInfo(location: "www.liveonline.co.kr", package: "LoL")
        case .offline:
            return GameInfo(location: "제주", package: "SA")
        }
    }
}

var basketball: Sports = Sports(gameType: .basketball)
print(basketball.gameInfo)  // GameInfo(time: 40, player: 5)

var sudden: ESports = ESports(gameType: .offline)
print(sudden.gameInfo)      // GameInfo(location: "제주", package: "SA")

let someGameType: Sports.GameType = .football
let anotherGameType: ESports.GameType = .online
let errorIfYouWantIt: Sports.GameType = .online // ❌ 오류 발생!!
