# **Chapter 14. 옵셔널 체이닝과 빠른 종료**

## 옵셔널 체이닝
- `옵셔널 체이닝`은 옵셔널에 속해 있는 `nil`일지도 모르는 프로퍼티, 메서드, 서브스크립션 등을 가져오거나 호출할 때 사용할 수 있는 일련의 과정
- 프로퍼티나 메서드 또는 서브스크립트를 호출하고 싶은 옵셔널 변수나 상수 뒤에 `?`를 붙여 표현한다.
  - 옵셔널이 `nil`이 아니라면 정상적으로 호출된다.
  - 중첩된 옵셔널 중 하나라도 값이 존재하지 않으면 최종 결과로는 `nil`이 반환된다.
  - **`옵셔널 체이닝의 반환된 값은 항상 옵셔널임`**
- `?` 대신 `!`를 사용할 수도 있는데 이는 옵셔널 값을 `강제로 추출`해준다. (사용은 지양하는 것이 좋음)
  - `강제 추출 반환 값은 옵셔널이 아님`

``` Swift
// [ 사람의 주소 정보 표현 설계 ]

class Room { // 호실
    var number: Int             // 호실 번호
    
    init(number: Int) {
        self.number = number
    }
}

class Building { // 건물
    var name: String            // 건물 이름
    var room: Room?             // 호실 정보
    
    init(name: String) {
        self.name = name
    }
}

struct Address { // 주소
    var province: String        // 광역시/도
    var city: String            // 시/군/구
    var street: String          // 도로명
    var building: Building?     // 건물
    var detailAddress: String?  // 건물 외 상세 주소
}

class Person { // 사람
    var name: String            // 이름
    var address: Address?       // 주소
    
    init(name: String) {
        self.name = name
    }
}

let rei: Person = Person(name: "rei")

// 옵셔널 체이닝 & 강제 추출을 사용한 프로퍼티 접근
let reiRoomViaOptionalChaining: Int? = rei.address?.building?.room?.number // nil
let reiRoomViaOptionalUnwrapping: Int = rei.address!.building!.room!.number // 오류 발생
```

- 위 예시 코드에서 호실 정보를 가져오는 코드를 `옵셔널 바인딩`을 사용하여 표현하면 아래와 같다.
    ``` Swift
    // [ 옵셔널 바인딩의 사용 ]

    let rei: Person = Person(name: "rei")

    var roomNumber: Int? = nil

    if let reiAddress: Address = rei.address {
        if let reiBuilding: Building = reiAddress.building {
            if let reiRoom: Room = reiBuilding.room {
                roomNumber = reiRoom.number
            }
        }
    }

    if let number: Int = roomNumber {
        print(number)
    } else {
        print("Cannot find room number")
    }
    ```

- `옵셔널 체이닝`을 사용하면 훨씬 간단하게 표현 가능
    ``` Swift
    // [ 옵셔널 체이닝의 사용 ]

    let rei: Person = Person(name: "rei")

    if let roomNumber: Int = rei.address?.building?.room?.number {
        print(roomNumber)
    } else {
        print("Cannot find room number")
    }
    ```

- 옵셔널 체이닝을 통해 값을 받아오는 것 뿐만 아니라 `값을 할당`해줄 수도 있다.
    ``` Swift
    // [ 옵셔널 체이닝을 통한 값 할당 시도 ]

    rei.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
    rei.address?.building = Building(name: "곰굴")
    rei.address?.building?.room = Room(number: 0)
    rei.address?.building?.room?.number = 505

    print(rei.address?.building?.room?.number)  // Optional(505)
    ```

- 옵셔널 체이닝을 통한 `메서드` 호출
    ``` Swift
    // [ 옵셔널 체이닝을 통한 메서드 호출 ]

    struct Address { // 주소
        var province: String        // 광역시/도
        var city: String            // 시/군/구
        var street: String          // 도로명
        var building: Building?     // 건물
        var detailAddress: String?  // 건물 외 상세 주소
        
        init(province: String, city: String, street: String) {
            self.province = province
            self.city = city
            self.street = street
        }
        
        func fullAddress() -> String? {
            var restAddress: String? = nil
            
            if let buildingInfo: Building = self.building {
                restAddress = buildingInfo.name
            } else if let detail = self.detailAddress {
                restAddress = detail
            }
            
            if let rest: String = restAddress {
                var fullAddress: String = self.province
                
                fullAddress += " " + self.city
                fullAddress += " " + self.street
                fullAddress += " " + rest
                
                return fullAddress
            } else {
                return nil
            }
        }
        
        func printAddress() {
            if let address: String = self.fullAddress() {
                print(address)
            }
        }
    }

    rei.address?.fullAddress()?.isEmpty // false
    rei.address?.printAddress()         // 충청북도 청주시 청원구 충청대로 곰굴
    ```

- 옵셔널 체이닝을 통한 `서브스크립트` 호출
  - 서브스크립트 : 인덱스를 통해 값을 넣고 빼올 수 있는 기능
  - 서브스크립트를 가장 많이 사용하는 곳은 `Array`, `Dictionary`
- 옵셔널의 서브스크립트를 사용하고자 할 때에는 `대괄호([])`보다 앞에 `?`를 표기해준다.
    ``` Swift
    // [ 옵셔널 체이닝을 통한 서브스크립트 호출 ]

    let optionalArray: [Int]? = [1, 2, 3]
    optionalArray?[1]   // 2

    var optionalDictionary: [String: [Int]]? = [String: [Int]]()
    optionalDictionary?["numberArray"] = optionalArray
    optionalDictionary?["numberArray"]?[2]  //  3
    ```
---

## 빠른 종료
- `guard` 키워드를 통해 `빠른 종료(Early Exit)`을 수행할 수 있다.
  - `guard` 구문은 `if`구문과 유사하게 `Bool`타입의 값으로 동작하는 기능
- **`guard` 뒤에 따라붙는 코드의 실행 결과과 `true`일 때 코드가 계속 실행된다.**
- `guard` 구문은 항상 `else` 구문이 뒤에 따라와야 한다.
- `guard` 구문 코드 블록을 종료할 때는 `return`, `break`, `continue`, `throw` 등의 제어문 전환 명령을 사용하거나 `fatalError()`와 같은 비반환 함수/메서드를 호출할 수도 있다.
  ``` Swift
  guard Bool 타입 값 else {
    예외사항 실행문
    제어문 전환 명령어
  }
  ```

- 같은 기능을 수행하기 위한 `if` 구문과 `guard` 구문의 비교
    ``` Swift
    // if 구문을 사용한 코드
    for i in 0...3 {
        if i == 2  {
            print(i)
        } else {
            continue
        }
    }

    // guard 구문을 사용한 코드
    for i in 0...3 {
        guard i == 2 else {
            continue
        }
        print(i)
    }
    ```

- `guard` 구문은 `옵셔널 바인딩`의 역할도 할 수 있다.
  - **`guard`에 따라오는 옵셔널 바인딩 표현 시 옵셔널의 값이 있다면, 옵셔널 바인딩된 상수를 `guard` 구문이 실행된 아래 코드부터 `함수 내부의 지역상수처럼 사용`할 수 있다.**
    ``` Swift
    // [ guard 구문의 옵셔널 바인딩 활용 ]

    func greet(_ person: [String: String]) {
        guard let name: String = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location: String = person["location"] else {
            print("I hope the weather is nice near you")
            return
        }
        
        print("I hope the weather is nice in \(location)")
    }

    var personInfo: [String: String] = [String: String]()
    personInfo["name"] = "Jenny"

    greet(personInfo)
    // Hello Jenny!
    // I hope the weather is nice near you

    personInfo["location"] = "Korea"

    greet(personInfo)
    // Hello Jenny!
    // I hope the weather is nice in Korea
    ```

- 위의 예시코드에서 작성했던 `Address` 구조체의 `fullAddress()` 메서드를 `guard` 구문을 사용해서 조금 더 깔끔하게 작성해보았다.
    ``` Swift
    func fullAddress() -> String? {
        var restAddress: String? = nil
        
        if let buildingInfo: Building = self.building {
            restAddress = buildingInfo.name
            
        } else if let detail = self.detailAddress {
            restAddress = detail
        }
        
        guard let rest: String = restAddress else {
            return nil
        }
        
        var fullAddress: String = self.province
        fullAddress += " " + self.city
        fullAddress += " " + self.street
        fullAddress += " " + rest
        
        return fullAddress
    }
    ```
- 더 구체적인 조건을 추가하고 싶다면 `쉼표(,)`를 사용해서 `Bool`의 추가조건을 나열해주면 된다.
  - 쉼표로 추가된 조건은 `AND 논리연산(&&)`과 같은 결과를 준다.
    ``` Swift
    // [ guard 구문에 구체적인 조건을 추가 ]

    func enterClub(name: String?, age: Int?) {
        guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
            print("You are too young to enter the club")
            return
        }
        
        print("Welcome \(name)!")
    }
    ```

- `guard` 구문은 `자신을 감싸는 코드 블록이 없다면`(`return`, `break`, `continue`, `throw` 등의 제어문 전환 명령어를 쓸 수 없는 상황이라면) `사용이 불가능`하다는 한계가 있다.
  - 함수/메서드/반복문 등 특정 블록 내부에 위치하지 않는다면 사용이 불가
    ``` Swift
    // [ guard 구문이 사용될 수 없는 경우 ]

    let first: Int = 3
    let second: Int = 5

    guard first > second else {
        // 들어올만한 제어문 전환 명령이 없기 때문에 오류
    }
    ```