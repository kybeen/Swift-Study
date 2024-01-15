# **Chapter 18. 상속**
- `클래스`는 메서드/프로퍼티 등을 다른 클래스로부터 `상속`받을 수 있다.
  - 상속받은 클래스는 상속한 클래스의 `자식클래스(Subclass/Child-class)` 라고 한다.
  - 자식클래스에게 특성을 물려준(상속한) 클래스를 `부모클래스(Superclass/Parents-class)` 라고 한다.

- 부모클래스로부터 물려받은 메서드, 프로퍼티, 서브스크립트 등을 호출/접근할 수 있고, 재정의도 가능하다.
- `연산 프로퍼티`를 정의한 클래스에서는 연산 프로퍼티에 `프로퍼티 감시자`를 구현할 수 없다. **하지만 `자식클래스`에서는 부모 프로퍼티의 연산/저장 프로퍼티 등에 대한 `프로퍼티 감시자를 구현할 수 있다.`**

- `기반클래스(Base class)` : 다른 클래스로부터 상속을 받지 않은 클래스
    ``` Swift
    // [ 기반클래스 Person ]

    class Person {
        var name: String = ""
        var age: Int = 0
        
        var introduction: String {
            return "이름: \(name). 나이: \(age)"
        }
        
        func speak() {
            print("야호ㅋ")
        }
    }

    let rei: Person = Person()
    rei.name = "rei"
    rei.age = 26
    print(rei.introduction) // 이름: rei. 나이: 26
    rei.speak() // 야호ㅋ
    ```
---

## 클래스 상속
- **`상속`은 `기반클래스`를 다른 클래스에서 물려받는 것을 말한다.**
- 자식클래스는 부모클래스의 메서드, 프로퍼티, 서브스크립트 등 모든 특성을 포함한다.
  > 🚧 상속을 못하도록 방지하는 `final` 키워드를 사용하면 모든 속성을 상속받지는 않는다.
- 자식클래스의 고유한 메서드, 프로퍼티, 서브스크립트를 정의하여 사용할 수도 있다.
    ``` Swift
    class 클래스 이름: 부모클래스 이름 {
        프로퍼티/메서드들
    }
    ```

``` Swift
// [ Person 클래스를 상속받은 Student 클래스 ]

class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
}

let rei: Person = Person()
rei.name = "rei"
rei.age = 26
print(rei.introduction) // 이름: rei. 나이: 26
rei.speak()             // 야호ㅋ

let son: Student = Student()
son.name = "son"
son.age = 30
son.grade = "A"
print(son.introduction) // 이름: son. 나이: 30
son.speak()             // 야호ㅋ
son.study()             // Study hard...
```

``` Swift
// [ Student 클래스를 상속받은 UniversityStudent 클래스 ]

class UniversityStudent: Student {
    var major: String = ""
}

let minjae: UniversityStudent = UniversityStudent()
minjae.major = "Art"
minjae.speak()              // 야호ㅋ
minjae.study()              // Study hard...
```
---

## 재정의(Override)
### `재정의`
- 부모클래스로부터 물려받은 특성을 그대로 사용하지 않고 자신만의 기능으로 변경하여 사용하는 것
- `override` 키워드 사용
  - 스위프트 컴파일러가 조상클래스에 해당 특성이 있는지 확인한 후 재정의하게 된다. (❌해당 특성이 없을 경우 컴파일 오류 발생)

- **자식클래스에서 부모클래스의 특성을 재정의했을 때, `기존 부모클래스의 특성`을 자식클래스에서 사용하고 싶다면 `super` 프로퍼티를 사용하면 된다.**
  - `super` 키워드를 `타입 메서드` 내에서 사용한다면, `부모클래스의 타입 메서드, 타입 프로퍼티`에 접근할 수 있음
  - `super` 키워드를 `인스턴스 메서드` 내에서 사용한다면, `부모클래스의 인스턴스 메서드, 인스턴스 프로퍼티, 서브스크립트`에 접근할 수 있음
  ``` Swift
  super.someMethod()    // 부모클래스의 메서드 호출
  super.someProperty    // 부모클래스의 프로퍼티 접근
  super[index]          // 부모클래스의 서브스크립트로 접근
  ```

### `메서드 재정의`
``` Swift
// [ 메서드 재정의 ]

class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름: \(name). 나이: \(age)"
    }
    
    func speak() {
        print("야호ㅋ")
    }
    
    // class : 상속 후 메서드 재정의가 가능한 타입 메서드
    class func introduceClass() -> String {
        return "인류의 소원은 평화"
    }
}

class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
    
    override func speak() {
        print("저는 학생입니다.")
    }
}

class UniversityStudent: Student {
    var major: String = ""
    
    class func introduceClass() {
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+"
    }
    
    override func speak() {
        super.speak() // Student 클래스에서 재정의한 speak()가 호출
        print("대학생이죠.")
    }
}

let rei: Person = Person()
rei.speak()     // 야호ㅋ

let son: Student = Student()
son.speak()     // 저는 학생입니다.

let minjae: UniversityStudent = UniversityStudent()
minjae.speak()  // 저는 학생입니다. 대학생이죠.

print(Person.introduceClass())      // 인류의 소원은 평화
print(Student.introduceClass())     // 인류의 소원은 평화
print(UniversityStudent.introduceClass() as String) // 대학생의 소원은 A+
UniversityStudent.introduceClass() as Void          // 인류의 소원은 평화
```

### `프로퍼티 재정의`
- 저장 프로퍼티로 재정의할 수는 X
- 프로퍼티 자체를 재정의하는 것이 아니라 프로퍼티의 `접근자(Getter)` `설정자(Setter)` `프로퍼티 감시자(Property Observer)` 등을 재정의하는 것을 의미한다.
- 프로퍼티를 상속받은 자식클래스에서는 조상 클래스의 프로퍼티 종류(저장, 연산)는 알지 못하고 `이름`과 `타입`만 알 수 있다.
``` Swift
// [ 프로퍼티 재정의 ]

class Person {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String {
        return "이름: \(name). 나이: \(age)"
    }
}

class Student: Person {
    var grade: String = "F"
    
    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)"
    }
    
    // 읽기 전용이었던 koreanAge 프로퍼티를 읽기/쓰기가 모두 가능하도록 재정의
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
    }
}

let rei: Person = Person()
rei.name = "rei"
rei.age = 25
//rei.koreanAge = 27        // Person 타입에는 koreanAge 설정자가 없기 때문에 오류 발생
print(rei.introduction)     // 이름: rei. 나이: 25
print(rei.koreanAge)        // 26

let son: Student = Student()
son.name = "son"
son.age = 30
son.koreanAge = 31
print(son.introduction)     // 이름: son. 나이: 30 학점 : F
print(son.koreanAge)        // 31
```

### `프로퍼티 감시자 재정의`
- 상수 저장 프로퍼티, 읽기 전용 프로퍼티는 `프로퍼티 감시자`를 재정의할 수 없다.
- **📌 프로퍼티 감시자를 재정의하더라도 `조상 클래스`에 정의한 프로퍼티 감시자는 동작한다.**
- 프로퍼티의 접근자(Getter)와 프로퍼티 감시자는 동시에 재정의할 수 없다.
  - 둘 다 동작하길 원한다면 `재정의하는 접근자에 프로퍼티 감시자의 역할을 구현해야 한다.`
``` Swift
// [ 프로퍼티 감시자 재정의 ]

class Person {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person age : \(self.age)")
        }
    }
    var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get {
            return self.name
        }
        
        set {
            self.name = newValue
        }
    }
}

class Student: Person {
    var grade: String = "F"
    
    override var age: Int {
        didSet {
            print("Student age : \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age = newValue - 1
        }
        
//        didSet {  } // 프로퍼티의 접근자와 프로퍼티 감시자는 동시에 재정의할 수 ❌ 오류 발생!!
    }
    
    override var fullName: String {
        didSet {
            print("Full Name : \(self.fullName)")
        }
    }
}

let rei: Person = Person()
rei.name = "rei"
rei.age = 25                // Person age : 25
rei.fullName = "rei Kim"
print(rei.koreanAge)        // 26

let son: Student = Student()
son.name = "son"
son.age = 30 // Person과 Student에 정의한 감시자가 모두 동작
// Person age : 30
// Student age : 30
son.koreanAge = 31
// Person age : 30
// Student age : 30
son.fullName = "Son hm" // Full Name : Son hm
print(son.koreanAge)    // 31
```
---

### `서브스크립트 재정의`
- 자식클래스에서 재정의하려는 서브스크립트는 부모클래스 서브스크립트의 매개변수와 반환 타입이 같아야 한다.
- 방법은 메서드 재정의와 같음
``` Swift
// [ 서브스크립트 재정의 ]

class School {
    var students: [Student] = [Student]()
    
    subscript(number: Int) -> Student {
        print("School subscript")
        return students[number]
    }
}

class MiddleSchool: School {
    var middleStudents: [Student] = [Student]()
    
    // 부모클래스(School)에게 상속받은 서브스크립트 재정의
    override subscript(index: Int) -> Student {
        print("MiddleSchool subscript")
        return middleStudents[index]
    }
}

let university: School = School()
university.students.append(Student())
university[0]   // School subscript

let middle: MiddleSchool = MiddleSchool()
middle.middleStudents.append(Student())
middle[0]       // MiddleSchool subscript
```
---

### `재정의 방지`
- 자식클래스에서 몇몇 특성을 `재정의할 수 없도록 제한`하고 싶다면 재정의를 방지하고 싶은 특성 앞에 `final` 키워드를 명시해준다.
- `클래스 자체`를 상속하거나 재정의할 수 없도록 하고 싶다면 `final class`로 정의해준다.
``` Swift
// [ final 키워드의 사용 ]

class Person {
    final var name: String = ""
    
    final func speak() {
        print("가나다라마바사")
    }
}

final class Student: Person {
    // Person의 name은 final로 재정의를 막아놨기 때문에 오류 발생
    override var name: String {
        set {
            super.name = newValue
        }
        
        get {
            return "학생"
        }
    }
    
    // Person의 speak()는 final로 재정의를 막아놨기 때문에 오류 발생
    override func speak() {
        print("저는 학생입니다.")
    }
}

// Student 클래스는 final로 상속을 막아놨기 때문에 오류 발생
class UniversityStudent: Student { }

```
---

## 클래스의 이니셜라이저 - 상속과 재정의
- `값 타입`의 이니셜라이저는 [이니셜라이저 위임(초기화 위임)](https://github.com/kybeen/Swift-Study/blob/main/Chapter11/Chapter11.md)을 위해 이니셜라이저끼리 구분할 필요가 없다.
- **✅ `클래스`에서는 `지정 이니셜라이저`와 `편의 이니셜라이저`로 역할을 구분한다.**
- **✅ 또한 클래스는 상속이 가능하기 때문에 상속받았을 때 이니셜라이저를 어떻게 재정의하는지도 중요하다.**


### 📌 `지정 이니셜라이저`와 `편의 이니셜라이저`

`지정 이니셜라이저(Designated Initializer)`
- 이니셜라이저가 정의된 클래스의 모든 프로퍼티를 초기화해야 한다.
- 모든 클래스는 하나 이상의 지정 이니셜라이저를 가져야 한다.
- 필요에 따라 부모 클래스의 이니셜라이저를 호출할 수 있다.
- 조상클래스에서 지정 이니셜라이저가 자손클래스의 지정 이니셜라이저 역할을 충분히 할 수 있다면 자손클래스는 지정 이니셜라이저를 갖지 않을 수 있다.
    ``` Swift
    // 값 타입 이니셜라이저와 동일한 형식
    init(매개변수들) {
        초기화 구문
    }
    ```


`편의 이니셜라이저(Convenience Initializer)`
- 초기화를 좀 더 쉽게 도와주는 역할 (필수는 아님)
- 지정 이니셜라이저를 자신 내부에서 호출
  - 지정 이니셜라이저의 매개변수가 많거나, 특정 목적에 사용하기 위해 설계할 수 있다.
- `convenience` 지정자를 `init` 키워드 앞에 명시하여 선언
  ``` Swift
  convenience init(매개변수들) {
      초기화 구문
  }
  ```


### 📌 `클래스의 초기화 위임`
- **💡 지정 이니셜라이저와 편의 이니셜라이저 사이의 규칙**
  1. **`자식클래스의 지정 이니셜라이저`는 `부모클래스의 지정 이니셜라이저`를 반드시 호출** 해야 한다.
  2. `편의 이니셜라이저`는 **자신을 정의한 클래스** 의 `다른 이니셜라이저`를 반드시 호출해야 한다.
  3. `편의 이니셜라이저`는 궁극적으로는 **`지정 이니셜라이저`를 반드시 호출** 해야 한다.
```
👉 누군가는 지정 이니셜라이저에게 초기화를 반드시 위임한다.
👉 편의 이니셜라이저는 초기화를 반드시 누군가에 위임한다.
```
<img width="500" alt="이니셜라이저" src="https://github.com/kybeen/Rei-iOS/assets/89764127/1acdc52a-ece8-42d2-b9f2-22943d2bde75">


### 📌 `2단계 초기화`
- 스위프트의 클래스 초기화는 `2단계`를 거친다.
  - **1️⃣ : 클래스에 정의한 각각의 `저장 프로퍼티에 초깃값`이 할당**
  - **2️⃣ : (모든 저장 프로퍼티의 초기 상태가 결정되면) `저장 프로퍼티들을 사용자 정의할 기회`를 얻는다.**

- 2단계 초기화는 프로퍼티를 초기화하기 전에 프로퍼티 값에 접근하는 것을 막아 초기화를 안전하게 할 수 있도록 해준다.
- 다른 이니셜라이저가 프로퍼티의 값을 실수로 변경하는 것을 방지한다.

- **💡 스위프트 컴파일러는 오류 없이 2단계 초기화를 처리하기 위해 `4가지 안전확인(Safety-checks)`을 실행한다.**
  1. 자식클래스의 지정 이니셜라이저가 부모클래스의 이니셜라이저를 호출하기 전에 `자신의 프로퍼티를 모두 초기화했는지` 확인
  2. 자식클래스의 지정 이니셜라이저는 `상속받은 프로퍼티에 값을 할당하기 전에` 반드시 부모클래스의 이니셜라이저를 호출해야 한다.
  3. 편의 이니셜라이저는 자신의 클래스에 정의한 프로퍼티를 포함하여 `그 어떤 프로퍼티라도 값을 할당하기 전에` 다른 이니셜라이저를 호출해야 한다.
  4. `초기화 1단계를 마치기 전`까지는 이니셜라이저는 인스턴스 메서드를 호출할 수 없으며, 인스턴스 프로퍼티의 값을 읽어들일 수도 없다. `self` 프로퍼티를 자신의 인스턴스를 나타내는 값으로 활용할 수도 없다.
    > *‼️ 클래스의 인스턴스는 `초기화 1단계`를 마치기 전까지는 아직 유효하지 않다.*

### 📌 2단계 초기화가 이루어지는 과정
**`✅ 1단계`**
1. 클래스가 지정 또는 편의 이니셜라이저를 호출한다.
2. 그 클래스의 새로운 인스턴스를 위한 메모리가 할당된다. 메모리 초기화는 아직 x
3. 지정 이니셜라이저는 클래스에 정의된 모든 저장 프로퍼티에 값이 있는지 확인한다. 현재 클래스 부분까지의 저장 프로퍼티를 위한 메모리는 초기화가 완료된다.
4. 지정 이니셜라이저는 부모 클래스의 이니셜라이저가 같은 동작을 행할 수 있도록 초기화를 양도한다.
5. 부모클래스는 상속 체인을 따라 최상위 클래스에 도달할 때까지 이 작업을 반복한다.

- 최상위 클래스에 도달했을 때, 최상위 클래스까지의 모든 저장 프로퍼티에 값이 있다고 확인하면 해당 인스턴스의 메모리는 모두 초기화된 것이다. ➡️ 1단계 완료

    <img width="600" alt="1단계" src="https://github.com/kybeen/Rei-iOS/assets/89764127/6802bfd4-f851-46f7-9a70-03bd7ec3dda2">


**`✅ 2단계`**
1. 최상위 클래스로부터 최하위 클래스까지 상속 체인을 따라 내려오면서 지정 이니셜라이저들이 인스턴스를 제각각 사용자 정의하게 된다. 이 단계에서는 `self`를 통해 프로퍼티 값을 수정할 수 있고, 인스턴스 메서드를 호출하는 등의 작업을 진행할 수 있다.
2. 마지막으로 각각의 편의 이니셜라이저를 통해 `self`를 통한 사용자 정의 작업을 진행할 수 있다.

    <img width="600" alt="2단계" src="https://github.com/kybeen/Rei-iOS/assets/89764127/531dba83-b190-4d6e-be5f-4cb17a936359">

``` Swift
// [ Person 클래스를 상속받은 Student 클래스 ]

class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}


class Student: Person {
    var major: String
    
    // 지정 이니셜라이저
    init(name: String, age: Int, major: String) {
        // 안전확인 1 ✅  부모 클래스의 지정 이니셜라이저를 호출하기 전에 자신의 self 프로퍼티를 이용해 major 프로퍼티의 값을 할당
        self.major = "Swift"
        // 안전확인 2 ✅ 부모클래스의 이니셜라이저 호출 (상속받은 프로퍼티는 따로 없기 때문에 부모의 이니셜라이저 호출 이후 값을 할당해줄 프로퍼티는 없다.)
        super.init(name: name, age: age)
    }
    
    // 편의 이니셜라이저
    convenience init(name: String) {
        // 안전확인 3 ✅ 따로 차후에 값을 할당할 프로퍼티가 없고, 다른 이니셜라이저를 호출함
        self.init(name: name, age: 7, major: "")
    }
    
    // 안전확인 4 ✅ 이니셜라이저 어디에서도 인스턴스 메서드를 호출하거나 인스턴스 프로퍼티의 값을 읽어오지 않았으므로 조건 만족
}

```

### 📌 `이니셜라이저 상속 및 재정의`
- **기본적으로 스위프트의 이니셜라이저는 `부모클래스의 이니셜라이저를 상속받지 않는다.`**
  - 부모클래스로부터 물려받은 이니셜라이저는 자식클래스에 최적화되어 있지 않아서, 부모클래스의 이니셜라이저를 사용했을 때 자식클래스의 새로운 인스턴스가 완전하고 정확하게 초기화되지 않는 상황을 방지하기 위해
  - 안전하고 적절하다고 판단되는 특정 상황에서는 상속되기도 한다. *(18.3.5 이니셜라이저 자동 상속 참고)*

- 보통 자식클래스에서 부모클래스의 이니셜라이저와 같은 이니셜라이저를 사용하고 싶으면 `자식클래스에서 똑같은 이니셜라이저를 구현해주면 된다.`
  - 🔵 부모클래스와 동일한 `지정 이니셜라이저`를 자식클래스에서 구현해주려면 `재정의`하면 된다. (`override`)
  - 🔵 클래스에 주어지는 `기본 이니셜라이저`를 재정의 할 때와, `자식클래스의 편의 이니셜라이저`가 `부모클래스의 지정 이니셜라이저`를 재정의하는 경우에도 `override를` 붙여준다.

  - 🟢 반대로 부모클래스의 `편의 이니셜라이저`와 동일한 이니셜라이저를 자식클래스에 구현할 때는 `override`를 붙이지 않는다.
    - **자식클래스에서 부모클래스의 편의 이니셜라이저는 절대 호출할 수 없기 때문에 재정의할 필요가 x**
    ``` Swift
    // [ 클래스 이니셜라이저 재정의 ]

    class Person {
        var name: String
        var age: Int
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        convenience init(name: String) {
            self.init(name: name, age: 0)
        }
    }

    class Student: Person {
        var major: String
        
        // 부모클래스의 Person의 지정 이니셜라이저는 재정의를 위해 override 수식어 사용
        override init(name: String, age: Int) {
            self.major = "Swift"
            super.init(name: name, age: age)
        }
        
        // 부모클래스인 Person과 동일한 편의 이니셜라이저를 재정의 ➡️ override를 붙이지x
        convenience init(name: String) {
            self.init(name: name, age: 7)
        }
    }
    ```

- 부모클래스의 `실패 가능한 이니셜라이저`를 자식클래스에서 재정의하고 싶을 때는 `실패 가능한 이니셜라이저`도 가능하고, `실패하지 않는 이니셜라이저`도 가능하다.
    ``` Swift
    // [ 실패 가능한 이니셜라이저 재정의 ]

    class Person {
        var name: String
        var age: Int
        
        init() {
            self.name = "Unknown"
            self.age = 0
        }
        
        init?(name: String, age: Int) {
            if name.isEmpty {
                return nil
            }
            self.name = name
            self.age = age
        }
        
        init?(age: Int) {
            
            if age < 0 {
                return nil
            }
            self.name = "Unknown"
            self.age = age
        }
    }

    class Student: Person {
        var major: String
        
        // 부모 클래스와 동일하게 실패 가능한 이니셜라이저로 재정의
        override init?(name: String, age: Int) {
            self.major = "Swift"
            super.init(name: name, age: age)
        }
        
        // 부모 클래스와 다르게 실패하지 않는 이니셜라이저로 재정의
        override init(age: Int) {
            self.major = "Swift"
            super.init()
        }
    }
    ```


### 📌 `이니셜라이저 자동 상속`
- 기본적으로 스위프트의 이니셜라이저는 부모클래스의 이니셜라이저를 상속받지 않지만, **`특정 조건에 부합`한다면 부모클래스의 이니셜라이저가 `자동으로 상속`된다.**

- **💡 자식클래스에서 프로퍼티 기본값을 모두 제공한다고 가정할 때**, 다음 두 가지 규칙에 따라 이니셜라이저가 자동으로 상속된다.
  - *`규칙 1`* : 자식클래스에서 별도의 지정 이니셜라이저를 구현하지 않는다면, 부모클래스의 지정 이니셜라이저가 자동으로 상속된다.
  - *`규칙 2`* : 만약 *`규칙 1`* 에 따라 자식클래스에서 부모클래스의 지정 이니셜라이저를 자동으로 상속받은 경우 또는 부모클래스의 지정 이니셜라이저를 모두 재정의하여 부모클래스와 동일한 지정 이니셜라이저를 모두 사용할 수 있는 상황이라면 부모클래스의 편의 이니셜라이저가 모두 자동으로 상속된다.

    ``` Swift
    // [ 이니셜라이저 자동 상속 ]

    class Person {
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        convenience init() {
            self.init(name: "Unknown")
        }
    }

    class Student: Person {
        var major: String = "Swift" // 기본값 있음
    }

    // 부모클래스의 지정 이니셜라이저 자동 상속
    let rei: Person = Person(name: "rei")
    let son: Student = Student(name: "son")
    print(rei.name) // rei
    print(son.name) // son

    // 부모클래스의 편의 이니셜라이저 자동 상속
    let jisung: Person = Person()
    let minjae: Student = Student()
    print(jisung.name)  // Unknown
    print(minjae.name)  // Unknown
    ```

    ``` Swift
    // [ 편의 이니셜라이저 자동 상속 ]

    class Person {
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        convenience init() {
            self.init(name: "Unknown")
        }
    }

    class Student: Person {
        // 기본값이 없더라도 이니셜라이저에서 적절히 초기화했고, 부모클래스의 지정 이니셜라이저를 모두 재정의했기 때문에
        // 부모 클래스의 지정 이니셜라이저와 동일한 이니셜라이저를 모두 사용할 수 있는 상황
        // 👉 규칙1에 부합 👉 편의 이니셜라이저가 자동으로 상속
        var major: String
        
        override init(name: String) {
            self.major = "Unknown"
            super.init(name: name)
        }
        
        init(name: String, major: String) {
            self.major = major
            super.init(name: name)
        }
    }

    // 부모클래스의 편의 이니셜라이저 자동 상속
    let jisung: Person = Person()
    let minjae: Student = Student()
    print(jisung.name)  // Unknown
    print(minjae.name)  // Unknown

    ```

    ``` Swift
    // [ 편의 이니셜라이저 자동 상속 2 ]

    class Person {
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        convenience init() {
            self.init(name: "Unknown")
        }
    }

    class Student: Person {
        var major: String
        
        // 자신만의 편의 이니셜라이저 (편의 이니셜라이저 자동 상속에는 아무 영향을 미치지 x)
        convenience init(major: String) {
            self.init()
            self.major = major
        }
        
        // 부모 클래스의 지정 이니셜라이저를 자식클래스의 편의 이니셜라이저로 구현하더라도 부모의 지정 이니셜라이저를 모두 사용할 수 있음
        // 👉 규칙2를 충족 👉 편의 이니셜라이저가 자동으로 상속
        override convenience init(name: String) {
            self.init(name: name, major: "Unknown")
        }
        
        init(name: String, major: String) {
            self.major = major
            super.init(name: name)
        }
    }

    // 부모클래스의 편의 이니셜라이저 자동 상속
    let jisung: Person = Person()
    let minjae: Student = Student(major: "Swift")
    print(jisung.name)  // Unknown
    print(minjae.name)  // Unknown
    print(minjae.major) // Swift
    ```

    ``` Swift
    // [ 편의 이니셜라이저 자동 상속 3 ]

    class UniversityStudent: Student {
        var grade: String = "A+" // 기본값 있음
        var description: String {
            return "\(self.name) \(self.major) \(self.grade)"
        }
        
        // 자신만의 편의 이니셜라이저를 구현 👉 자동 상속에는 영향을 미치지 않는다.
        convenience init(name: String, major: String, grade: String) {
            self.init(name: name, major: major)
            self.grade = grade
        }
        
        // 별도의 지정 이니셜라이저를 구현하지 않음
        // 👉 규칙1를 충족 👉 부모클래스의 이니셜라이저를 모두 자동 상속
        
        // 결과적으로 UniversityStudent 클래스는 상속받은 이니셜라이저와 자신의 편의 이니셜라이저들을 모두 사용할 수 있다.
    }

    let nova: UniversityStudent = UniversityStudent()
    print(nova.description)     // Unknown Unknown A+

    let raon: UniversityStudent = UniversityStudent(name: "raon")
    print(raon.description)     // raon Unknown A+

    let joker: UniversityStudent = UniversityStudent(name: "joker", major: "Programming")
    print(joker.description)    // joker Programming A+

    let chope: UniversityStudent = UniversityStudent(name: "chope", major: "Computer", grade: "C")
    print(chope.description)    // chope Computer C
    ```
---

### 📌 `요구 이니셜라이저`
- `required` 수식어를 클래스 이니셜라이저 앞에 명시해주면 이 클래스를 `상속받은 자식클래스`에서 `반드시 해당 이니셜라이저를 구현`해주어야 한다. (반드시 재정의해줘야 한다. 👉 `override` 대신 `required` 사용)

    ``` Swift
    // [ 요구 이니셜라이저 정의 ]

    class Person {
        var name: String
        
        // 요구 이니셜라이저 정의
        required init() {
            self.name = "Unknown"
        }
    }

    class Student: Person {
        // 프로퍼티에 기본값이 있으며 별다른 지정 이니셜라이저가 없기 때문에 Pereson의 이니셜라이저가 자동으로 상속됨
        // 👉 required init()이 자동으로 상속돼서 따로 구현해줄 필요 x
        var major: String = "Unknown"
    }

    let rei: Student = Student()
    print(rei.name) // Unknown
    ```

    ``` Swift
    // [ 요구 이니셜라이저 재구현 ]

    class Person {
        var name: String
        
        // 요구 이니셜라이저 정의
        required init() {
            self.name = "Unknown"
        }
    }

    class Student: Person {
        var major: String = "Unknown"
        
        // 자신의 지정 이니셜라이저 구현
        init(major: String) {
            self.major = major
            super.init()
        }
        
        // 부모클래스로부터 이니셜라이저가 자동으로 상속되지 않으므로 요구 이니셜라이저를 구현해주어야 한다.
        required init() {
            self.major = "Unknown"
            super.init()
        }
    }

    class UniversityStudent: Student {
        var grade: String
        
        // 자신의 지정 이니셜라이저 구현
        init(grade: String) {
            self.grade = grade
            super.init()
        }
        
        required init() {
            self.grade = "F"
            super.init()
        }
    }

    let jiSoo: Student = Student()
    print("\(jiSoo.name) \(jiSoo.major)")                       // Unknown Unknown

    let rei: Student = Student(major: "Swift")
    print("\(rei.name) \(rei.major)")                           // Unknown Swift

    let juHyun: UniversityStudent = UniversityStudent(grade: "A+")
    print("\(juHyun.name) \(juHyun.major) \(juHyun.grade)")     // Unknown Unknown A+
    ```

- 부모클래스의 일반 이니셜라이저를 `자식클래스에서 요구 이니셜라이저로 변경`할 수도 있다.
  - `required override`를 명시해주어 재정의됨과 동시에 요구 이니셜라이가 된다는 것을 알려줘야 함
- `required convenience`를 명시하면 `편의 이니셜라이저`도 요구 이니셜라이저로 변경될 수 있다.

    ``` Swift
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

    ```