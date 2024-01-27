# **Chapter 24. 타입 중첩**
- 스위프트에서는 `타입 내부에 타입을 정의하고 구현`할 수 있다. 이를 `중첩 타입(Nested Types)`이라고 부름.


## 중첩 데이터 타입
- 함수를 중첩해 사용하듯이 클래스 내부에 새 클래스, 클래스 내부에 새 구조체, 구조체 내부에 새 열거형 등 `타입을 중첩해서 내부에 새 타입을 정의`할 수 있다.
- 👉 중첩 데이터 타입을 사용할 때는 `자신이 속해 있는 타입의 이름을 자신보다 앞에 적어줘야 한다.`
  - ex) `Person.Job`
- 👉 `부모 클래스 내부에 정의한 중첩 타입`은 **`해당 클래스를 상속받은 자식 클래스의 중첩 데이터 타입`으로도 취급할 수 있다.**
``` Swift
// [ 중첩 데이터 타입 구현 ]

class Person {
    // Person 클래스 내부의 중첩 데이터 타입인 Job 열거형 타입
    enum Job {
        case jobless, programmer, student
    }
    
    var job: Job = .jobless
}

class Student: Person {
    // Student 클래스 내부의 중첩 데이터 타입인 School 열거형 타입
    enum School {
        case elementary, middle, high
    }
    
    var school: School
    
    init(school: School) {
        self.school = school
        super.init()
        self.job = .student
    }
}

// 👉 Job 열거형은 Person 내부에 정의되어 있지만 Person을 상속받은 Student 클래스의 중첩 데이터 타입으로도 취급할 수 있다.
let personJob: Person.Job = .jobless
let studentJob: Student.Job = .student

let student: Student = Student(school: .middle)
print(student.job)      // student
print(student.school)   // middle
```

### 📌 `중첩 데이터 타입 구현이 필요한 예시`
- **👉 `이름이 같은 데이터 타입`이지만 어디 들어가는지에 따라 `역할이 달라야 할 때` 중첩 데이터 타입 구현이 필요하다.**
  - `Sports` 구조체와 `ESports` 구조체에는 각각 `GameType`과 `GameInfo`가 있다.
  - 이름이 같은 데이터 타입이지만 각 구조체에 맞게 서로 다른 종류의 게임이 있고, 제공해야 하는 게임 정보도 서로 다르다.

  ``` Swift
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
  ```

- 목적에 따라 타입을 중첩하는 것은 타입의 목적성을 명확히 하는 데 큰 도움이 된다.