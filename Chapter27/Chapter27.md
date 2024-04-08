# **Chapter 27. ARC**
- 전달할 때마다 값을 복사하는 값 타입과는 달리 `참조 타입`은 `하나의 인스턴스`가 `참조`를 통해 여러 곳에서 접근하기 때문에 **`메모리에서 언제 해제되는지가 중요`** 하다.
- **`인스턴스를 적절한 시점에 메모리에서 해제`** 시켜줘야 한정적인 메모리 자원의 낭비를 막을 수 있다.
- **스위프트는 메모리 관리 기법으로 `ARC`를 사용하고 있다.**
---

## ARC(Automatic Reference Counting) 란?
- 자동으로 메모리를 관리해주는 방식
- 더 이상 필요하지 않은 클래스의 인스턴스를 메모리에서 해제해주는 방식으로 동작한다.

### 📌 `가비지 컬렉션(Garbage Collection) 기법과의 차이`
- 가장 큰 차이는 참조를 `계산(Count)하는 시점`
  - ARC는 인스턴스가 언제 메모리에서 해제되어야 할지를 **`컴파일과 동시에 결정`** 한다.

  | 메모리 관리 기법 | ARC | 가비지 컬렉션 |
  | :--- | :--- | :--- |
  | **참조 카운팅 시점** | 컴파일 시 | 프로그램 동작 중 |
  | **장점** | 🟢 컴파일 당시 이미 인스턴스의 해제 시점이<br>정해져 있어서 인스턴스가 언제 메모리에서<br>해제될지 예측할 수 있다.<br>🟢 컴파일 당시 이미 인스턴스의 해제 시점이<br>정해져 있어서 메모리 관리를 위한 시스템<br>자원을 추가할 필요가 없다. | 🟢 상호 참조 상황 등의 복잡한 상황에서도<br>인스턴스를 해제할 수 있는 가능성이<br>더 높다.<br>🟢 특별히 규칙에 신경 쓸 필요가 x |
  | **단점** | 🔴 ARC의 작동 규칙을 모르고 사용하면<br>인스턴스가 메모리에서 영원히 해제되지<br>않을 가능성이 있다. | 🔴 프로그램 동작 외에 메모리 감시를 위한<br>추가 자원이 필요하므로 한정적인 자원<br>환경에서는 성능 저하가 발생할 수 있음<br>🔴 명확한 규칙이 없기 때문에 인스턴스가<br>정확히 언제 메모리에서 해제될지 예측하기<br>어렵다. |
---

- ARC를 이용해 자동으로 메모리 관리를 받기 위해서는 몇 가지 규칙을 알아야 한다.
  - 원하는 방향으로 메모리 관리가 이루어지도록 하려면 ARC에 **명확한 힌트**를 제공해야 한다.

- 클래스의 인스턴스를 생성할 때마다 ARC는 인스턴스에 대한 정보를 저장하기 위한 메모리 공간을 할당하고, 이후 인스턴스가 필요 없는 상태가 되면 메모리에서 인스턴스를 없앤다.
  - 👉 **만약 아직 더 사용해야 하는 인스턴스를 메모리에서 해제시킨다면 인스턴스와 관련된 프로퍼티 접근과 메서드 호출이 불가해지고, 잘돗된 메모리 접근으로 프로그램이 강제 종료될 수 있다.**
- 👉 인스턴스가 지속적으로 필요한 상황에 메모리에서 해제되지 않도록 **`ARC는 인스턴스 참조 여부를 계속 추적`** 한다.
  - 다른 곳에서 `해당 인스턴스를 참조하는 곳이 있다면` ARC가 해당 인스턴스를 메모리에서 해제하지 않고 유지시켜야 하는 명분이 된다.
---


## 강한참조
- 인스턴스가 계속해서 메모리에 남아있어야 하는 명분을 만들어 주는 것이 👉 **`강한참조(Strong Reference)`**
- ✅ 인스턴스는 참조 횟수가 `0`이 되는 순간 `메모리에서 해제`된다.
- ✅ 인스턴스를 다른 인스턴스의 프로퍼티, 변수, 상수 등에 할당 시 강한참조를 사용하면 `참조 횟수가 1 증가`한다.
- ✅ 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 `nil`을 할당해주면 인스턴스 `참조 횟수가 1 감소`한다.
- 기본적으로 참조 시에는 `강한 참조`로 선언된다.

``` Swift
// [ 강한참조의 참조 횟수 확인 ]

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "rei") // 인스턴스의 참조 횟수 : 1
// rei is being initialized

reference2 = reference1 // 인스턴스의 참조 횟수 : 2
reference3 = reference1 // 인스턴스의 참조 횟수 : 3

reference3 = nil // 인스턴스의 참조 횟수 : 2
reference2 = nil // 인스턴스의 참조 횟수 : 1
reference1 = nil // 인스턴스의 참조 횟수 : 0
// rei is being deinitialized
/// 👉 참조 횟수가 0이 되는 순간 인스턴스는 ARC의 규칙에 의해 메모리에서 해제되며 메모리에서 해제되기 직전에 디이니셜라이저를 호출한다.
```

``` Swift
// [ 강한참조 지역변수(상수)의 참조 횟수 확인 ]

func foo() {
    let rei: Person = Person(name: "rei")   // 인스턴스의 참조 횟수 : 1
    // rei is being initialized
    
    // 함수 종료 시점
    // 인스턴스의 참조 횟수 : 0
    // rei is being initialized

    /// 👉 강한참조 지역변수(상수)가 사용된 범위의 코드 실행이 종료되면 그 지역변수(상수)가 참조하던 인스턴스의 참조 횟수가 1 감소한다.
}
foo()
```

``` Swift
// [ 강한참조 지역변수(상수)의 참조 횟수 확인과 전역변수 ]

var globalReference: Person?

func foo() {
    let rei: Person = Person(name: "rei")   // 인스턴스의 참조 횟수 : 1
    // rei is being initialized
    
    globalReference = rei   // 인스턴스의 참조 횟수 : 2
    
    // 함수 종료 시점
    // 인스턴스의 참조 횟수 : 1
    
    /// 👉 인스턴스 참조 횟수가 여전히 1이므로 메모리에서 해제되지 않는다.
}
foo()
```


### 📌 `강한참조 순환 문제`
- 인스턴스끼리 서로가 서로를 강함참조를 하게 되는 상황을 `강한참조 순환(Strong Reference Cycle)`이라고 한다.
    ``` Swift
    // [ 강한참조 순환 문제 ]

    class Person {
        let name: String
        
        init(name: String) {
            self.name = name
        }
        
        var room: Room?
        
        deinit {
            print("\(name) is being deinitialized")
        }
    }

    class Room {
        let number: String
        
        init(number: String) {
            self.number = number
        }
        
        var host: Person?
        
        deinit {
            print("Room \(number) is being deinitialized")
        }
    }

    var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
    var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1

    room?.host = rei    // Person 인스턴스의 참조 횟수 : 2
    rei?.room = room    // Room 인스턴스의 참조 횟수 : 2

    rei = nil   // Person 인스턴스의 참조 횟수 : 1
    room = nil  // Room 인스턴스의 참조 횟수 : 1

    /*
    Person 인스턴스를 참조할 방법을 상실했지만 메모리에는 남아 있음
    Room 인스턴스를 참조할 방법을 상실했지만 메모리에는 남아 있음
    👉 Person과 Room의 디이니셜라이저가 호출되지 않는 것을 확인할 수 있다.
    👉 메모리 누수 발생 ‼️
    */
    ```

- 강한참조를 하고 있는 프로퍼티에 모두 `nil`을 할당해주면 참조 횟수를 0으로 만들어서 인스턴스를 메모리에서 해제시킬 수 있기는 할 것이다.
- 하지만 일일이 찾아서 해줘야 하기 때문에 깔끔한 방식은 아니다.
  - **`약한 참조(Weak)`** 와 **`미소유참조(Unowned)`** 를 통해 더 명확하게 순환참조 문제를 해결할 수 있다.
  ``` Swift
  // [ 강한참조 순환 문제를 수동으로 해결 ]
  
  var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
  var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1
  
  room?.host = rei    // Person 인스턴스의 참조 횟수 : 2
  rei?.room = room    // Room 인스턴스의 참조 횟수 : 2
  
  rei?.room = nil     // Room 인스턴스의 참조 횟수 : 1
  rei = nil           // Person 인스턴스의 참조 횟수 : 1
  
  room?.host = nil    // Person 인스턴스의 참조 횟수 : 0
  // rei is being deinitialized
  
  room = nil          // Room 인스턴스의 참조 횟수 : 0
  // Room 505 is being deinitialized
  ```
---


## 약한참조 (Weak Reference)
- `약한참조(Weak Reference)`는 강한참조와 다르게 자신이 참조하는 **`인스턴스의 참조 횟수를 증가시키지 않는다.`**
- ✅ 참조 타입의 프로퍼티나 변수의 선언 앞에 `weak` 키워드를 붙여준다.
- 약한참조는 참조 횟수를 증가시키지 않았기 때문에 `해당 인스턴스를 강한 참조하던 다른 프로퍼티나 변수에서 참조 횟수를 감소시켜서 0이 되면 메모리에서 해제된다.`
  - ➡️ 약한참조를 사용한다면 참조하는 인스턴스가 메모리에서 해제될 수도 있다는 것을 예상할 수 있어야 한다.
> 🚧 메모리에서 해제될 경우 `nil`이 할당될 수 있어야 하기 때문에 약한참조는 **`상수` 에서 쓰일 수 없고, 항상 `옵셔널`이어야 한다.**

``` Swift
// [ 강한참조 순환 문제를 약한참조로 해결 ]

class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var room: Room?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Room {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    // 약한참조를 하도록 weak 키워드와 함께 정의
    weak var host: Person?
    
    deinit {
        print("Room \(number) is being deinitialized")
    }
}

var rei: Person? = Person(name: "rei")  // Person 인스턴스의 참조 횟수 : 1
var room: Room? = Room(number: "505")   // Room 인스턴스의 참조 횟수 : 1

room?.host = rei    // Person 인스턴스의 참조 횟수 : 1 👉 host 프로퍼티는 약한참조를 하기 때문에 참조 횟수가 증가하지 않는다.
rei?.room = room    // Room 인스턴스의 참조 횟수 : 2

rei = nil   // Person 인스턴스의 참조 횟수 : 0, Room 인스턴스의 참조 횟수 : 1 👉 Person 인스턴스의 room 프로퍼티가 강한참조를 하고 있던 Room 인스턴스의 참조 횟수도 감소한다.
// rei is being deinitialized
print(room?.host)   // nil 👉 host 프로퍼티는 약한참조를 하고 있었기 때문에 자신이 참조하는 인스턴스가 메모리에서 해제되면 자동으로 nil을 할당

room = nil  // Room 인스턴스의 참조 횟수 : 0
// Room 505 is being deinitialized
```
---


## 미소유참조 (Unowned Reference)
- 약한 참조와 마찬가지로 **`미소유참조(Unowned Reference)`** 는 인스턴스의 참조 횟수를 증가시키지 않는다.
- **미소유참조는 약한참조와 다르게 `자신이 참조하는 인스턴스가 항상 메모리에 존재할 것이라는 전제`를 기반으로 동작한다.**
  - 자신이 참조하는 인스턴스가 메모리에서 해제되더라도 스스로 `nil`을 할당해주지 않는다.
  - 👉 그렇기 때문에 미소유참조를 하는 변수나 프로퍼티는 `옵셔널이나 변수가 아니어도 된다.`
  > 🚧 하지만 메모리에서 해제된 인스턴스에 접근 시 런타임 오류가 발생하기 때문에 미소유참조는 **참조하는 동안 해당 인스턴스가 메모리에서 해제되지 않는다는 확신이 있을 때만** 사용해야 한다.

- ✅ `unowned` 키워드를 사용하여 미소유참조를 할 수 있다.

  ---
📌 `예시코드 - 사람과 신용카드`
- 사람과 신용카드의 관계
  - 사람은 신용카드를 소지하지 않을 수도 있다.
  - 신용카드는 명의자가 꼭 있어야 한다.
  ``` Swift
  // [ 미소유참조 ]
  
  class Person {
      let name: String
      
      /*
       - 카드를 소지할 수도, 소지하지 않을 수도 있기 때문에 옵셔널로 정의한다.
       - 카드를 한 번 가진 후 잃어버리면 안 되기 때문에 강한참조를 해야 한다.
       */
      var card: CreditCard?
      
      init(name: String) {
          self.name = name
      }
      
      deinit { print("\(name) is being deinitialized") }
  }
  
  class CreditCard {
      let number: UInt
      unowned let owner: Person   // 카드는 소유자가 분명히 존재해야 한다.
      
      init(number: UInt, owner: Person) {
          self.number = number
          self.owner = owner
      }
      
      deinit {
          print("Card #\(number) is being deinitialized")
      }
  }
  
  var rei: Person? = Person(name: "rei") // Person 인스턴스의 참조 횟수 : 1
  
  if let person: Person = rei {
      // CreditCard의 인스턴스 참조 횟수 : 1
      person.card = CreditCard(number: 1004, owner: person)
      // Person 인스턴스의 참조 횟수 : 1 👉 owner는 미소유참조를 하기 때문에 Person 인스턴스의 참조 횟수가 증가하지 않는다.
  }
  
  rei = nil   // Person 인스턴스의 참조 횟수 : 0
  // CreditCard 인스턴스의 참조 횟수 : 0 👉 card 프로퍼티는 강한참조를 하고 있었기 때문에 CreditCard 인스턴스의 참조 횟수도 1 감소된다.
  // rei is being deinitialized
  // Card #1004 is being deinitialized
  ```
---


## 미소유 옵셔널 참조
- 클래스를 참조하는 옵셔널을 미소유로 표시할 수 있다. 
- `미소유 옵셔널 참조`와 `약한참조`를 같은 상황에 사용할 수 있다.
  - 다만 미소유 옵셔널 참조는 항상 유효한 객체를 가리키거나 그렇지 않으면 `nil`을 할당해 주도록 직접 관리를 해주어야 한다.
``` Swift
// [ 미소유 옵셔널 참조의 사용 ]

class Department {
    var name: String
    var subjects: [Subject] = [] // 학과에서 운영하는 각 과목을 배열에 담아 강한참조
    init(name: String) {
        self.name = name
    }
}

class Subject {
    var name: String
    unowned var department: Department  // 학과 (과목은 반드시 특정 학과에 속해야 하기 때문에 옵셔널x)
    unowned var nextSubject: Subject?   // 학생이 수강해야 하는 다음 과목 (모든 과목이 다음 차례의 과목을 갖고 있는 것은 아니기 때문에 옵셔널)
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextSubject = nil
    }
}

let department = Department(name: "Computer Science")

let intro = Subject(name: "Computer Architecture", in: department)
let intermediate = Subject(name: "Swift Language", in: department)
let advanced = Subject(name: "iOS App Programming", in: department)

/*
 - intro, intermediate 과목은 다음 수강 과목을 미소유 옵셔널 참조로 nextSubject 프로퍼티에 저장한다.
 - 옵셔널 값인 클래스의 인스턴스가 메모리에서 해제될 때 ARC에 의해 보호받지 못한다. → 이는 미소유참조와 동일하지만, 미소유 옵셔널 참조는 nil이 될 수 있다는 점이 다르다.
 */
intro.nextSubject = intermediate
intermediate.nextSubject = advanced
department.subjects = [intro, intermediate, advanced]
/*
 - 옵셔널이 아닌 미소유참조와 같이 nextSubject가 항상 메모리에서 해제되지 않고 살아 있는 과목의 인스턴스를 참조하도록 신경 써주어야 한다.
    - ex) department.subjects에서 한 과목을 제거한다면, 그 과목을 nextSubject로 참조하고 있느 인스턴스에서 nextSubject의 참조를 제거해 줘야 한다.
 */
```

> 💡 `옵셔널(Optional)`은 표준 라이브러리에 열거형으로 정의된 `값 타입`이다. 원래 값 타입은 참조 타입이 아니기 때문에 `unowned` 등으로 참조 관리를 할 수 없다. **그러나 옵셔널은 값 타입일지라도 예외적으로 `unowned` 등을 활용해 참조 관리를 하는 것이 가능하다.**
>
> 그리고 클래스를 감싸는 옵셔널은 참조 횟수 계산을 하지 않기 때문에 강한참조로 관리할 필요가 없다.
---


## 미소유참조와 암시적 추출 옵셔널 프로퍼티
- 서로 참조해야 하는 프로퍼티에 값이 꼭 있어야 하면서도 한번 초기화되면 그 이후에는 `nil`을 할당할 수 없는 조건을 갖추어야 하는 경우가 있다.

### 📌 `예시 코드`
- Company의 인스턴스를 생성할 때는 꼭 CEO가 있어야 한다.
- Company가 존재하는 한 ceo 프로퍼티에는 꼭 CEO 인스턴스가 존재해야 한다.
- CEO의 인스턴스는 회사가 있는 경우에만 초기화할 수 있다.
  
    ---
- 회사가 사라지면 CEO가 있을 의미가 없기 때문에 `강한참조`를 사용하지 않는다. 👉 참조 카운트를 증가시키지 않고, 옵셔널도 아니어야 함
- Company의 ceo 프로퍼티에 `암시적 추출 옵셔널`을 사용한 이유 👉 **`Company 타입의 인스턴스를 초기화할 때, CEO 타입의 인스턴스를 생성하는 과정에서 자기 자신을 참조하도록 보내줘야 하기 때문`**
  - 암시적 추출 옵셔널이 아닌 일반 프로퍼티로 사용한다면 Company 자신의 init 메서드가 끝난 후에만 CEO(name: ceoName, company: self)와 같은 코드를 호출할 수 있다.

> 👉 **`암시적 추출 옵셔널 프로퍼티`** : [이니셜라이저의 2단계 초기화](https://github.com/kybeen/Swift-Study/blob/main/Chapter18/Chapter18.md#-2단계-초기화) 조건을 충족시키기 위해 사용 (자기 자신의 인스턴스 생성 과정에서 `self` 키워드로 자기 자신을 참조하도록 보내줘야 하기 때문)
>
> 👉 **`미소유참조(unowned) 프로퍼티`** : company가 없으면 CEO는 의미가 없기 때문에 강한참조를 사용하지 않음+옵셔널 아님 | 상수 프로퍼티여야 함

``` Swift
// [ 미소유참조와 암시적 추출 옵셔널 프로퍼티의 활용 ]

class Company {
    let name: String
    // 암시적 추출 옵셔널 프로퍼티 (강한참조)
    var ceo: CEO!
    
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    // 미소유참조 상수 프로퍼티 (미소유참조)
    unowned let company: Company
    
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    
    func introduce() {
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}

let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce()     // 무한상사의 CEO는 김태호입니다.
company.ceo.introduce() // 김태호는 무한상사의 CEO입니다.
```
---


## 클로저의 강한참조 순환
- `강한참조 순환 문제`는 두 인스턴스끼리의 참조일 때만 발생하는 것 외에도 `클로저가 인스턴스의 프로퍼티일 때`나, `클로저의 값 획득 특성` 때문에 발생할 수도 있다.
  > 👉 클로저 내부에서 `self.someProperty`와 같이 인스턴스의 프로퍼티에 접근할 때나
  > 👉 클로저 내부에서 `self.someMethod()`처럼 인스턴스의 메서드를 호출할 때
  >
  > [`값 획득`](https://github.com/kybeen/Swift-Study/blob/main/Chapter13/Chapter13.md#값-획득)이 발생할 수 있는데, 두 경우 모두 클로저가 `self`를 획득하므로 **`강한참조 순환이 발생`** 한다.

- 💡 **클로저는 클래스와 같은 `참조 타입`이기 때문에 클로저를 클래스 인스턴스의 프로퍼티로 할당하면 클로저의 참조가 할당된다.** 이 때 `참조 타입과 참조 타입이 서로 강한참조`를 하기 때문에 **`강한참조 순환 문제`가 발생**하는 것이다.

- **✅ 클로저의 강한참조 순환 문제는 `클로저의 획득 목록`을 통해 해결할 수 있다.**
    
    ---
### 📌 `클로저의 강한참조 순환 문제가 발생하는 예시`
- 자기소개를 하기 위해 `introduce` 프로퍼티를 통해 클로저를 호출하면 그 때 `클로저는 자신의 내부에 있는 참조 타입 변수 등을 획득`한다.
  - **👉 클로저는 자신이 호출되면 언제든지 자신 내부의 참조들을 사용할 수 있도록 `참조 횟수를 증가시켜 메모리에서 해제되는 것을 방지`하는데, 이때 자신을 프로퍼티로 갖는 인스턴스의 참조 횟수도 증가시킨다.**
  - **‼️ 이렇게 강한참조 순환이 발생하면 `자신을 강한참조 프로퍼티로 갖는 인스턴스가 메모리에서 해제될 수 없는 문제가 발생`한다.**
  > 💡 클로저 내부에서 `self` 프로퍼티를 여러 번 호출하여 접근해도 참조 횟수는 한 번만 증가한다.

  ``` Swift
  // [ 클로저의 강한참조 순환 문제 ]
  
  class Person {
      let name: String
      let hobby: String?
      
      // introduce는 지연 저장 프로퍼티로 선언되어 있기 대문에 할당된 클로저 내부에서 self 프로퍼티를 사용할 수 있다.
      lazy var introduce: () -> String = {
          
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
  print(rei?.introduce()) // My name is rei. My hobby is eating.
  rei = nil
  /*
   rei 변수에 nil을 할당했지만 deinit이 호출되지 않음 👉 메모리 누수 발생
   */
  ```
    ---

### 📌 `획득목록`
- **클로저의 강한참조 순환 문제는 `획득목록(Capture list)`을 통해 해결할 수 있다.**
- 획득목록은 `클로저 내부에서 참조 타입을 획득하는 규칙을 제시해줄 수 있는 기능`이다.
  - 👉 클로저 내부의 `self` 참조를 `약한참조`로 지정할 수도, `강한참조`로 지정할 수도 있다.

- **✅ 획득목록은 클로저 내부 매개변수 목록 이전 위치에 작성해준다.**
- **✅ 참조 방식과 참조할 대상을 `[]`로 둘러싼 목록 형식으로 작성하며, 획득목록 뒤에는 `in` 키워드를 작성해준다.**
 
- 👉 획득목록에 명시한 요소가 `값 타입`이라면(참조 타입이 아니라면) `해당 요소들은 클로저가 생성될 때 초기화`된다.
    ``` Swift
    // [ 획득목록을 통한 값 획득 ]

    /*
    - 변수 a는 획득목록을 통해 클로저가 생성될 때 값 0을 획득했지만 b는 따로 값을 획득하지 않았다.
        👉 a 변수는 클로저가 생성됨과 동시에 획득목록 내에서 다시 a라는 이름의 상수로 초기화된 것임
        👉 외부에서 a의 값을 변경하더라도 클로저의 획득목록으로 획득한 a와는 별개가 된다.
        👉 b의 경우에는 클로저의 내/외부 상관없이 값이 변하는대로 반영된다.
    */
    var a = 0
    var b = 0
    let closure = { [a] in
        print(a, b)
        b = 20
    }

    a = 10
    b = 10
    closure() // a는 클로저 생성 시 획득한 값을 갖지만, b는 변경된 값을 사용한다.
    // 0 10
    print(b)
    // 20
    ```

- 👉 획득목록에 해당하는 요소가 `참조 타입`인 경우 획득목록에서 어떤 방식으로 참조할 것인지를 정해줄 수 있다.
  - `강한획득(Strong Capture)` | `약한획득(Weak Capture)` | `미소유획득(Unowned Capture)`
  - 또한 `획득의 종류에 따라 참조 횟수를 증가시킬지도 결정`할 수 있다.
    - **🚧 `약한획득`을 하게 되면 획득목록에서 획득하는 상수가 `옵셔널 상수로 지정`된다. (해당 참조 대상이 메모리에서 해제된 상태일 수 있기 때문에)**

  ``` Swift
  // [ 참조 타입의 획득목록 동작 ]
  
  /*
   - 변수 x는 획득목록을 통해 값을 획득했고 y는 획득목록에 별도로 명시되지 않았지만, 두 변수 모두 참조 타입의 인스턴스가 있기 때문에 서로 동작은 같다.
   */
  class SimpleClass {
      var value: Int = 0
  }
  
  var x = SimpleClass()
  var y = SimpleClass()
  
  let closure = { [x] in
      print(x.value, y.value)
  }
  x.value = 10
  y.value = 10
  
  closure() // 10 10
  ```

  ``` Swift
  // [ 획득목록의 획득 종류 명시 ]
  
  class SimpleClass {
      var value: Int = 0
  }
  
  var x: SimpleClass? = SimpleClass()
  var y = SimpleClass()
  
  // 획득목록에서 x를 약한참조로, y를 미소유참조하도록 지정
  let closure = { [weak x, unowned y] in
      // x는 약한참조이므로 클로저 내부에서 사용하더라도 x가 참조하는 인스턴스의 참조 횟수를 증가시키지 않는다.
      print(x?.value, y.value)
  }
  
  x = nil
  y.value = 10
  
  closure() // nil 10
  /*
   👉 클로저의 x가 참조하는 인스턴스가 메모리에서 해제되어 클로저 내부에서도 더 이상 참조가 불가능
   👉 y는 미소유참조를 했기 때문에 클로저가 참조 횟수를 증가시키지는 않지만, 만약 메모리에서 해제된 상태에서 사용 시 오류가 발생한다.
   */
  ```
  ---

### 📌 `클로저의 강한참조 순환 문제가 발생하는 예시` 해결 코드
- 위의 [📌 `클로저의 강한참조 순환 문제가 발생하는 예시`](https://github.com/kybeen/Swift-Study/edit/main/Chapter27/Chapter27.md#-클로저의-강한참조-순환-문제가-발생하는-예시) 코드에서 확인했던 클로저의 강한참조 순환 문제는 아래와 같이 해결할 수 있다.
- 👉 `introduce` 프로퍼티의 클로저가 `self를` 미소유참조하도록 획득목록에 명시함으로써 참조 카운트가 증가하지 않는다.
  - **💡 `미소유참조`로 지정한 이유는** 👉 해당 인스턴스가 존재하지 않는다면 프로퍼티도 호출할 수 없기 때문에 `self`를 미소유참조 하더라도 실행 중에 오류를 발생시킬 가능성이 거의 없다고 볼 수 있기 때문
    > 🚧 하지만 프로퍼티로 사용하던 클로저를 다른 곳에서 참조하게 된 후 인스턴스가 메모리에서 해제된다면 잘못된 메모리 접근으로 오류가 발생할 수 있다.
    >
    > **💡 따라서 미소유참조는 신중하게 사용해야 하고, 문제가 될 소지가 있다면 `약한참조(weak)`를 사용해주자**

  ``` Swift
  // [ 획득목록을 통한 클로저의 강한참조 순환 문제 해결 ]
  
  class Person {
      let name: String
      let hobby: String?
      
      // 👉 self를 미소유참조하도록 획득목록에 명시
      lazy var introduce: () -> String = { [unowned self] in
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
  print(rei?.introduce()) // My name is rei. My hobby is eating.
  
  rei = nil   // rei is being deinitialized
  // 👉 의도한 대로 인스턴스가 메모리에서 해제된다.
  ```

- 📌 `미소유참조로 인한 문제상황 예시`
    ``` Swift
    // [ 획득목록의 미소유참조로 인한 차후 접근 문제 발생 ]

    var rei: Person? = Person(name: "rei", hobby: "eating")
    var son: Person? = Person(name: "son", hobby: "football")

    // son의 introduce 프로퍼티에 rei의 introduce 프로퍼티 클로저의 참조 할당
    son?.introduce = rei?.introduce ?? {" "}

    print(rei?.introduce()) // My name is rei. My hobby is eating.

    rei = nil   // rei is being deinitialized
    print(son?.introduce()) // 🚧 이미 메모리에서 해제된 인스턴스(rei) 참조를 시도하게 되면서 오류 발생!!
    ```
    <img width="1000" alt="스크린샷 2024-01-24 오전 3 16 01" src="https://github.com/kybeen/Swift-Study/assets/89764127/078a8082-89c6-4dae-93b7-11863e06ebb8">

- `미소유참조로 인한 문제상황`이 발생할 여지가 있자면 `약한참조`로 변경하여 `옵셔널`로 사용해도 무방하다.
    ``` Swift
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
    ```
