# **Chapter 11. 인스턴스 생성 및 소멸**

## 인스턴스 생성
- `인스턴스 초기화` 과정에서는 새로운 인스턴스를 사용할 준비가 수행된다. ex) 저장 프로퍼티 초깃값 설정 등...
- `이니셜라이저(Initializer)`를 정의하면 초기화 과정을 직접 구현할 수 있다.
  - 스위프트의 이니셜라이저는 반환 값이 없다.
  - `func` 키워드를 사용하지 않고 `init` 키워드를 사용한다.
    - `init 메서드`는 클래스, 구조체, 열거형 등의 구현부 또는 해당 타입의 익스텐션 구현부에 위치한다.
    - 다만 `클래스의 지정 이니셜라이저`는 익스텐션에서 구현해줄 수 없다.

``` Swift
// [ 클래스, 구조체, 열거형의 기본적인 형태의 이니셜라이저 ]

class SomeClass {
    init() {
        // 초기화할 때 필요한 코드
    }
}

struct SomeStruct {
    init() {
        // 초기화할 때 필요한 코드
    }
}

enum SomeEnum {
    case someCase
    
    init() {
        // 열거형은 초기화할 때 반드시 case 중 하나가 되어야 함
        self = .someCase
        // 초기화할 때 필요한 코드
    }
}
```
---

### `프로퍼티 기본값`
- **`구조체와 클래스의 인스턴스`는 처음 생성할 때 옵셔널 저장 프로퍼티를 제외한 모든 `저장 프로퍼티`에 적절한 `초깃값(Initial Value)`을 할당해야 한다.**
- 프로퍼티를 정의할 때 프로퍼티 **`기본값(Default Value)`** 을 할당하면 이니셜라이저에서 따로 초깃값을 할당해주지 않아도 된다.
  > 💡 이니셜라이저를 통해 초깃값을 할당하거나, 프로퍼티 기본값을 통해 처음의 저장 프로퍼티가 초기화될 때는 감시자 메서드가 호출되지 않는다.

- 그 밖에도 초기화 시에는 `이니셜라이저의 매개변수`, `옵셔널 프로퍼티`, `상수 프로퍼티의 값 할당` 등 다양한 패턴을 활용할 수 있다.

    ``` Swift
    // [ Area 구조체와 이니셜라이저 ]

    struct Area {
        var squareMeter: Double
        
        init() {
            squareMeter = 0.0 // squareMeter의 초깃값 할당
        }
    }

    let room: Area = Area()
    print(room.squareMeter) // 0.0
    ```

    ``` Swift
    // [ 프로퍼티 기본값 지정 ]

    struct Area {
        var squareMeter: Double = 0.0 // 프로퍼티 기본값 할당
    }

    let room: Area = Area()
    print(room.squareMeter) // 0.0
    ```
---

### `이니셜라이저 매개변수`
- `이니셜라이저의 매개변수`를 통해 `인스턴스를 초기화하는 과정에 필요한 값을 전달`받을 수 있다.
- `사용자 정의 이니셜라이저`를 만들면 `기존의 기본 이니셜라이저 init()`은 별도로 구현하지 않는 이상 사용할 수 X
- 💡 스위프트의 기본 타입들의 정의를 찾아보면 다양하게 구현된 이니셜라이저를 찾아볼 수 있다.

    ``` Swift
    // [ 이니셜라이저 매개변수 ]

    struct Area {
        var squareMeter: Double
        
        init(fromPy py: Double) {                   // 첫 번째 이니셜라이저
            squareMeter = py * 3.3058
        }
        
        init(fromSquareMeter squareMeter: Double) { // 두 번째 이니셜라이저
            self.squareMeter = squareMeter
        }
        
        init(value: Double) {                       // 세 번째 이니셜라이저
            squareMeter = value
        }
        
        init(_ value: Double) {                     // 네 번째 이니셜라이저
            squareMeter = value
        }
    }

    let roomOne: Area = Area(fromPy: 15.0)
    print(roomOne.squareMeter)  // 49.587

    let roomTwo: Area = Area(fromSquareMeter: 33.06)
    print(roomTwo.squareMeter)  // 33.06

    let roomThree: Area = Area(value: 30.0)
    let roomFour: Area = Area(55.0)

    Area() // 오류
    ```
---

### `옵셔널 프로퍼티 타입`
- 초기화 과정에서 값을 초기화하지 않아도 되거나, 초기화 과정에서 값을 지정해주기 어려운 저장 프로퍼티가 있다면 `옵셔널`로 선언할 수 있다.
  - 옵셔널로 선언한 프로퍼티는 값을 할당해주기 전까지는 `nil`값을 갖는다.

    ``` Swift
    // [ Person 클래스 ]

    class Person {
        var name: String
        var age: Int?
        
        init(name: String) {
            self.name = name
        }
    }

    let rei: Person = Person(name: "rei")
    print(rei.name) // rei
    print(rei.age)  // nil

    rei.age = 99
    print(rei.age)  // Optional(99)
    ```
---

### `상수 프로퍼티`
- `상수로 선언된 저장 프로퍼티`는 `인스턴스를 초기화하는 과정에서만 값을 할당`할 수 있다.
- 처음 할당된 이후로는 `값을 변경할 수 없다.`
    > **💡 상수 프로퍼티와 상속**
    > 
    > 클래스 인스턴스의 상수 프로퍼티는 `프로퍼티가 정의된 클래스에서만 초기화`할 수 있다.
    > 해당 클래스를 상속받은 자식클래스의 이니셜라이저에서는 `부모클래스의 상수 프로퍼티 값을 초기화할 수 없다.`

    ``` Swift
    // [ 상수 프로퍼티의 초기화 ]

    class Person {
        let name: String
        var age: Int?
        
        init(name: String) {
            self.name = name
        }
    }

    let rei: Person = Person(name: "rei")
    rei.name = "reiKim" // 오류 발생
    ```
---

### `기본 이니셜라이저와 멤버와이즈 이니셜라이저`
- 사용자 정의 이니셜라이저를 정의해주지 않으면 클래스나 구조체는 `모든 프로퍼티에 기본값이 지정되어 있다는 전제`하에 **`기본 이니셜라이저`** 를 사용한다.
  - 프로퍼티 기본값으로 프로퍼티를 초기화해서 인스턴스를 생성

- **✅ `구조체`는 사용자 정의 이니셜라이저를 구현하지 않으면 프로퍼티의 이름으로 매개변수를 갖는 이니셜라이저인 `멤버와이즈 이니셜라이저를 기본으로 제공`한다.**
    - `클래스`는 `멤버와이즈 이니셜라이저를 지원하지 않기 때문에` 옵셔널이 아니고 기본값이 없는 저장 프로퍼티가 있다면 이니셜라이저를 별도로 구현해주어야 한다.

    ``` Swift
    // [ Point 구조체와 Size 구조체의 선언과 멤버와이즈 이니셜라이저의 사용 ]

    struct Point {
        var x: Double = 0.0
        var y: Double = 0.0
    }

    struct Size {
        var width: Double = 0.0
        var height: Double = 0.0
    }

    let point: Point = Point(x: 0, y: 0)
    let size: Size = Size(width: 50.0, height: 50.0)

    // 구조체의 저장 프로퍼티에 기본값이 있다면 필요한 매개변수만 사용해서 초기화하는 것도 가능
    let somePoint: Point = Point()
    let someSize: Size = Size(width: 50)
    let anotherPoint: Point = Point(y: 100)
    ```
---

### `초기화 위임`
- **✅ `값 타입인 구조체와 열거형`은 코드의 중복을 피하기 위해 이니셜라이저가 다른 이니셜라이저에게 일부 초기화를 위임하는 `초기화 위임`을 간단하게 구현할 수 있다.**
  - `클래스`는 상속을 지원하기 때문에 `초기화 위임을 할 수 없다.`
- 값 타입에서 이니셜라이저가 다른 이니셜라이저를 호출하려면 `self.init`을 사용한다.
  - `self.init`은 이니셜라이저 안에서만 사용 가능
  - 초기화 위임을 하려면 최소 두 개 이상의 사용자 정의 이니셜라이저를 정의해야 함 (사용자 정의 이니셜라이저를 정의하면 기본/멤버와이즈 이니셜라이저는 사용할 수 없기 때문에)
  > #### 💡 사용자 정의 이니셜라이저를 정의할 때도 기본/멤버와이즈 이니셜라이저를 사용하고 싶다면
  > 👉 `익스텐션`을 사용하여 사용자 정의 이니셜라이저를 구현하면 된다.
- 초기화 위임을 사용하면 코드를 중복으로 쓰지 않고도 효율적으로 `다양한 패턴의 이니셜라이저를 만들 수 있다.`
  
    ``` Swift
    // [ Student 열거형과 초기화 위임 ]

    enum Student {
        case elementary, middle, high
        case none
        
        // 사용자 정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 사용할 수 있다.
        init() {
            self = .none
        }
        
        init(koreanAge: Int) {                  // 첫 번째 사용자 정의 이니셜라이저
            switch koreanAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                self = .none
            }
        }
        
        init(bornAt: Int, currentYear: Int) {   // 두 번째 사용자 정의 이니셜라이저
            self.init(koreanAge: currentYear - bornAt + 1)
        }
    }

    var younger: Student = Student(koreanAge: 16)
    print(younger)  // middle

    younger = Student(bornAt: 1998, currentYear: 2016)
    print(younger)  // high
    ```
---

### `실패 가능한 이니셜라이저`
- 이니셜라이저의 전달 인자로 잘못된 값이 전달되었을 때와 같은 상황에서 `인스턴스 초기화에 실패`할 수도 있다.
- 실패 가능성을 내포한 이니셜라이저를 `실패 가능한 이니셜라이저(Failable initializer)`라고 한다.
  - 클래스, 구조체, 열거형 등에 모두 정의할 수 있음
  - `init` 대신 **`init?`** 키워드를 사용
  - 실패 시 `nil`을 반환하기 때문에 `반환 타입이 옵셔널`로 지정된다.
    - 💡 그렇다고 실패 가능한 이니셜라이저가 실제로 특정 값을 반환하는 것은 아니다. 초기화 실패 시에는 `return nil`을, 초기화 성공 시에는 `return`을 적어 초기화의 성공과 실패를 표현만 할 뿐이다.

    ``` Swift
    // [ 실패 가능한 이니셜라이저 ]

    class Person {
        let name: String
        var age: Int?
        
        init?(name: String) {
            
            if name.isEmpty {
                return nil
            }
            self.name = name
        }
        
        init?(name: String, age: Int) {
            if name.isEmpty || age < 0 {
                return nil
            }
            self.name = name
            self.age = age
        }
    }

    let rei: Person? = Person(name: "rei", age: 99)

    if let person: Person = rei {
        print(person.name)
    } else {
        print("Person wasn't initialized")
    }
    // rei

    let steve: Person? = Person(name: "steve", age: -10)

    if let person: Person = steve {
        print(person.name)
    } else {
        print("Person wasn't initialized")
    }
    // Person wasn't initialized
    ```

- ✅ 특히 열거형에서 유용하게 사용할 수 있다.
  - 특정 `case`에 맞지 않는 값이 들어오면 생성에 실패하도록 할 수 있다.
  - `rawValue`로 초기화 시 잘못된 `rawValue`가 들어올 때도 생성에 실패하도록 할 수 있다.
    - `rawValue`를 통한 이니셜라이저는 `기본적으로 실패 가능한 이니셜라이저로 제공`된다.

    ``` Swift
    // [ 열거형의 실패 가능한 이니셜라이저 ]

    enum Student: String {
        case elementary = "초등학생", middle = "중학생", high = "고등학생"
        
        init?(koreanAge: Int) {
            switch koreanAge {
            case 8...13:
                self = .elementary
            case 14...16:
                self = .middle
            case 17...19:
                self = .high
            default:
                return nil
            }
        }
        
        init?(bornAt: Int, currentYear: Int) {
            self.init(koreanAge: currentYear - bornAt + 1)
        }
    }

    var younger: Student? = Student(koreanAge: 20)
    print(younger)  // nil

    younger = Student(bornAt: 1998, currentYear: 2023)
    print(younger)  // nil

    younger = Student(rawValue: "대학생")
    print(younger)  // nil

    younger = Student(rawValue: "고등학생")
    print(younger)  // high
    ```
---

### `함수를 사용한 프로퍼티 기본값 설정`
- **사용자 정의 연산을 통해 저장 프로퍼티 기본값을 설정하고자 한다면 `클로저나 함수를 사용하여 프로퍼티 기본값을 제공`할 수 있다.**
- 인스턴스를 초기화할 때나 함수/클로저가 호출되면서 연산 결괏값을 프로퍼티 기본값으로 제공해준다.
- 🚧 프로퍼티 기본값을 설정해주기 위해 `클로저`를 사용하는 경우, **`클로저 내부에서는 인스턴스의 다른 프로퍼티를 사용할 수 없다.`**
  - 클로저가 실행되는 시점은 **`초기화할 때 인스턴스의 다른 프로퍼티 값이 설정되기 전`** 이기 때문
  - 다른 프로퍼티에 기본값이 있어도 안됨
  - `self` 프로퍼티와 인스턴스 메서드도 사용할 수 없음

    ``` Swift
    // [ 클로저를 통한 프로퍼티 기본값 설정 ]

    class SomeClass {
        let someProperty: SomeType = {
            // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해준다.
            // 반환되는 값의 타입은 SomeType과 같은 타입이어야 함
            return someValue
        }()
    }
    ```

- `클로저 뒤에 소괄호가 붙어 클로저를 실행한 결괏값은 프로퍼티의 기본값이 된다.`
  - 소괄호를 붙여주지 않으면 프로퍼티의 기본값은 클로저 그 자체가 돼버린다.
    ``` Swift
    // [ 클로저를 통한 Student 프로퍼티 기본값 설정 ]

    struct Student {
        var name: String?
        var number: Int?
    }

    class SchoolClass {
        var students: [Student] = {
            var arr: [Student] = [Student]()
            
            for num in 1...15 {
                var student: Student = Student(name: nil, number: num)
                arr.append(student)
            }
            
            return arr
        }()
    }

    let myClass: SchoolClass = SchoolClass()
    print(myClass.students.count) // 15
    ```
---

## 인스턴스 소멸
- **`클래스의 인스턴스`는 `디이니셜라이저(Deinitializer)`를 구현할 수 있다.**
  - 디이니셜라이저는 `클래스 인스턴스가 메모리에서 소멸되기 바로 직전에 호출`된다.
  - `deinit` 키워드로 구현
  - **🚧 디이니셜라이저는 클래스의 인스턴스에만 구현 가능**
> 스위프트는 인스턴스가 더 이상 필요하지 않으면 `자동으로 메모리에서 소멸`시기 때문에 대부분의 인스턴스는 디이니셜라이저로 별도의 메모리 관리 작업을 해 줄 필요는 없다.
> 
> 하지만 인스턴스에 저장된 데이터를 인스턴스가 소멸하기 전에 다른 곳에 저장하는 등 필요한 작업이 있을 때 디이니셜라이저를 유용하게 사용할 수 있다.

- 클래스에 디이니셜라이저는 `단 하나만 구현 가능`하다.
- `매개변수`를 갖지 않으며, `소괄호`도 적지 않는다.
- 자동으로 호출되기 때문에 `별도로 호출할 필요도 없다.`
- 인스턴스 소멸 직전 호출되기 때문에 `인스턴스의 모든 프로퍼티에 접근할 수 있다.`

``` Swift
// [ 디이니셜라이저의 구현 ]

class SomeClass {
    deinit {
        print("Instance will be deallocated immediately")
    }
}

var instance: SomeClass? = SomeClass()
instance = nil // Instance will be deallocated immediately
```

``` Swift
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
    
    // 인스턴스 사용이 끝난 후에는 파일의 변경사항을 저장한 뒤, 파일을 닫아준다.
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
```