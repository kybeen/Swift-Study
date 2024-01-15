# **Chapter 17. 서브스크립트**
### `서브스크립트(Subscript)`
- 컬렉션, 리스트, 시퀀스 등 타입의 요소에 접근하는 단축 문법
- 별도의 설정자(Setter), 접근자(Getter) 메서드 구현 없이 `인덱스`를 통해 값을 설정하거나 가져올 수 있다.
- 함수와 마찬가지로 여러 개의 매개변수를 가질 수 있고, 매개변수 기본값을 가질 수 있다.
---

## 서브스크립트 문법
- `subscript` 키워드로 정의
- 읽기/쓰기, 읽기 전용 구현 가능 (연산 프로퍼티와 유사)
- 설정자의 `newValue`의 타입은 `서브스크립트 반환 타입`과 동일함
``` Swift
// [ 서브스크립트 정의 문법 ]

subscript(index: Int) -> Int {
    get {
        // 서브스크립트 결괏값 반환
    }
    
    set(newValue) {
        // 설정자 역할 수행
    }
}
```

- `읽기 전용 서브스크립트` 구현 예시
    ``` Swift
    // [ 읽기 전용 서브스크립트 정의 문법 ]

    // #1
    subscript(index: Int) -> Int {
        get {
            // 서브스크립트 값 반환
        }
    }

    // #2
    subscript(index: Int) -> Int {
        // 결괏값 반환
    }
    ```
---

## 서브스크립트 구현
- 서브스크립트는 자신이 갖는 시퀀스나 컬렉션, 리스트 등의 `요소를 반환하고 설정`할 때 주로 사용한다.
- 함수와 마찬가지로 여러 개의 매개변수를 가질 수 있고, 매개변수 기본값을 가질 수 있다. (입출력 매개변수는 X)
``` Swift
// [ School 클래스 서브스크립트 구현 ]

struct Student {
    var name: String
    var number: Int
}

class School {
    
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    subscript(index: Int = 0) -> Student? {
        if index < self.number {
            return self.students[index]
        }
        return nil
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "A", "B", "C", "D", "E")

let aStudent: Student? = highSchool[1]
print("\(aStudent?.number) \(aStudent?.name)") // Optional(1) Optional("B")
print(highSchool[]?.name) // 매개변수 기본값 사용 : Optional("A")
```
---

## 복수 서브스크립트
- 다양한 매개변수 타입을 사용하여 서브스크립트를 구현할 수 있다.
``` Swift
// [ 복수 서브스크립트 구현 ]

struct Student {
    var name: String
    var number: Int
}

class School {
    
    var number: Int = 0
    var students: [Student] = [Student]()
    
    func addStudent(name: String) {
        let student: Student = Student(name: name, number: self.number)
        self.students.append(student)
        self.number += 1
    }
    
    func addStudents(names: String...) {
        for name in names {
            self.addStudent(name: name)
        }
    }
    
    // MARK: - 학생의 번호를 전달받는 서브스크립트
    subscript(index: Int) -> Student? {             // 첫 번째 서브스크립트
        // 번호에 해당하는 학생이 있다면 Student 인스턴스를 반환
        get {
            if index < self.number {
                return self.students[index]
            }
            return nil
        }
        
        // 번호에 학생을 할당
        set {
            guard var newStudent: Student = newValue else {
                return
            }
            
            var number: Int = index
            
            if index > self.number {
                number = self.number
                self.number += 1
            }
            
            newStudent.number = number
            self.students[number] = newStudent
        }
    }
    
    // MARK: - 학생의 이름을 전달받는 서브스크립트
    subscript(name: String) -> Int? {               // 두 번째 서브스크립트
        // 학생이 있다면 번호를 반환
        get {
            return self.students.filter{ $0.name == name }.first?.number
        }
        
        // 특정 이름의 학생을 해당 번호에 할당
        set {
            guard var number: Int = newValue else {
                return
            }
            
            if number > self.number {
                number = self.number
                self.number += 1
            }
            
            let newStudent: Student = Student(name: name, number: number)
            self.students[number] = newStudent
        }
    }
    
    // MARK: - 학생의 이름과 번호를 전달받는 서브스크립트
    subscript(name: String, number: Int) -> Student? {  // 세 번째 서브스크립트
        // 해당하는 학생이 있다면 Student 인스턴스 반환
        return self.students.filter{ $0.name == name && $0.number == number }.first
    }
}

let highSchool: School = School()
highSchool.addStudents(names: "A", "B", "C", "D", "E")

let bStudent: Student? = highSchool[1]
print("\(bStudent?.number) \(bStudent?.name)")  // Optional(1) Optional("B")

print(highSchool["A"])  // Optional(0)
print(highSchool["Z"])  // nil

highSchool[0] = Student(name: "AAA", number: 0)
highSchool["BBB"] = 1

print(highSchool["B"])      // nil
print(highSchool["BBB"])    // Optional(1)
print(highSchool["D", 3])   // Optional(Student(name: "D", number: 3))
print(highSchool["ABC"])    // nil
```
---

## 타입 서브스크립트
### `타입 서브스크립트`
- 인스턴스가 아니라 `타입 자체에서 사용`할 수 있는 서브스크립트
- `static subscript` 키워드로 정의할 수 있다.
  - 클래스의 경우에는 `class` 키워드를 사용할 수도 있음
``` Swift
// [ 타입 서브스크립트 구현 ]

enum School: Int {
    case elementary = 1, middle, high, university
    
    static subscript(level: Int) -> School? {
        return Self(rawValue: level)
        // return School(rawValue: level)과 같은 표현
    }
}

let school: School? = School[2]
print(school)   // School.middle
```