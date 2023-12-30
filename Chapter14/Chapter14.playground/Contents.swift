import Foundation



//// [ 사람의 주소 정보 표현 설계 ]
//
//class Room { // 호실
//    var number: Int             // 호실 번호
//    
//    init(number: Int) {
//        self.number = number
//    }
//}
//
//class Building { // 건물
//    var name: String            // 건물 이름
//    var room: Room?             // 호실 정보
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Address { // 주소
//    var province: String        // 광역시/도
//    var city: String            // 시/군/구
//    var street: String          // 도로명
//    var building: Building?     // 건물
//    var detailAddress: String?  // 건물 외 상세 주소
//}
//
//class Person { // 사람
//    var name: String            // 이름
//    var address: Address?       // 주소
//    
//    init(name: String) {
//        self.name = name
//    }
//}

//let rei: Person = Person(name: "rei")
//
//// 옵셔널 체이닝 & 강제 추출을 사용한 프로퍼티 접근
//let reiRoomViaOptionalChaining: Int? = rei.address?.building?.room?.number // nil
//let reiRoomViaOptionalUnwrapping: Int = rei.address!.building!.room!.number // 오류 발생




//// [ 옵셔널 바인딩의 사용 ]
//
//let rei: Person = Person(name: "rei")
//
//var roomNumber: Int? = nil
//
//if let reiAddress: Address = rei.address {
//    if let reiBuilding: Building = reiAddress.building {
//        if let reiRoom: Room = reiBuilding.room {
//            roomNumber = reiRoom.number
//        }
//    }
//}
//
//if let number: Int = roomNumber {
//    print(number)
//} else {
//    print("Cannot find room number")
//}

//
//// [ 옵셔널 체이니의 사용 ]
//
//let rei: Person = Person(name: "rei")
//
//if let roomNumber: Int = rei.address?.building?.room?.number {
//    print(roomNumber)
//} else {
//    print("Cannot find room number")
//}
//
//
//
//// [ 옵셔널 체이닝을 통한 값 할당 시도 ]
//
//rei.address = Address(province: "충청북도", city: "청주시 청원구", street: "충청대로")
//rei.address?.building = Building(name: "곰굴")
//rei.address?.building?.room = Room(number: 0)
//rei.address?.building?.room?.number = 505
//
//print(rei.address?.building?.room?.number)  // Optional(505)
//
//
//
//// [ 옵셔널 체이닝을 통한 메서드 호출 ]
//
//class Room { // 호실
//    var number: Int             // 호실 번호
//    
//    init(number: Int) {
//        self.number = number
//    }
//}
//
//class Building { // 건물
//    var name: String            // 건물 이름
//    var room: Room?             // 호실 정보
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct Address { // 주소
//    var province: String        // 광역시/도
//    var city: String            // 시/군/구
//    var street: String          // 도로명
//    var building: Building?     // 건물
//    var detailAddress: String?  // 건물 외 상세 주소
//    
//    init(province: String, city: String, street: String) {
//        self.province = province
//        self.city = city
//        self.street = street
//    }
//    
//    func fullAddress() -> String? {
//        var restAddress: String? = nil
//        
//        if let buildingInfo: Building = self.building {
//            restAddress = buildingInfo.name
//        } else if let detail = self.detailAddress {
//            restAddress = detail
//        }
//        
//        if let rest: String = restAddress {
//            var fullAddress: String = self.province
//            
//            fullAddress += " " + self.city
//            fullAddress += " " + self.street
//            fullAddress += " " + rest
//            
//            return fullAddress
//        } else {
//            return nil
//        }
//    }
//    
//    func printAddress() {
//        if let address: String = self.fullAddress() {
//            print(address)
//        }
//    }
//}
//
//rei.address?.fullAddress()?.isEmpty // false
//rei.address?.printAddress()         // 충청북도 청주시 청원구 충청대로 곰굴
//
//class Person { // 사람
//    var name: String            // 이름
//    var address: Address?       // 주소
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//
//
//// [ 옵셔널 체이닝을 통한 서브스크립트 호출 ]
//
//let optionalArray: [Int]? = [1, 2, 3]
//optionalArray?[1]   // 2
//
//var optionalDictionary: [String: [Int]]? = [String: [Int]]()
//optionalDictionary?["numberArray"] = optionalArray
//optionalDictionary?["numberArray"]?[2]  //  3
//
//
//
//// if 구문을 사용한 코드
//for i in 0...3 {
//    if i == 2  {
//        print(i)
//    } else {
//        continue
//    }
//}
//
//// guard 구문을 사용한 코드
//for i in 0...3 {
//    guard i == 2 else {
//        continue
//    }
//    print(i)
//}
//
//
//
//// [ guard 구문의 옵셔널 바인딩 활용 ]
//
//func greet(_ person: [String: String]) {
//    guard let name: String = person["name"] else {
//        return
//    }
//    
//    print("Hello \(name)!")
//    
//    guard let location: String = person["location"] else {
//        print("I hope the weather is nice near you")
//        return
//    }
//    
//    print("I hope the weather is nice in \(location)")
//}
//
//var personInfo: [String: String] = [String: String]()
//personInfo["name"] = "Jenny"
//
//greet(personInfo)
//// Hello Jenny!
//// I hope the weather is nice near you
//
//personInfo["location"] = "Korea"
//
//greet(personInfo)
//// Hello Jenny!
//// I hope the weather is nice in Korea







// [ 메서드 내부에서 guard 구문의 옵셔널 바인딩 활용 ]

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
        
        guard let rest: String = restAddress else {
            return nil
        }
        
        var fullAddress: String = self.province
        fullAddress += " " + self.city
        fullAddress += " " + self.street
        fullAddress += " " + rest
        
        return fullAddress
    }
    
    func printAddress() {
        if let address: String = self.fullAddress() {
            print(address)
        }
    }
}

class Person { // 사람
    var name: String            // 이름
    var address: Address?       // 주소
    
    init(name: String) {
        self.name = name
    }
}




// [ guard 구문에 구체적인 조건을 추가 ]

func enterClub(name: String?, age: Int?) {
    guard let name: String = name, let age: Int = age, age > 19, name.isEmpty == false else {
        print("You are too young to enter the club")
        return
    }
    
    print("Welcome \(name)!")
}



//// [ guard 구문이 사용될 수 없는 경우 ]
//
//let first: Int = 3
//let second: Int = 5
//
//guard first > second else {
//    // 들어올만한 제어문 전환 명령이 없기 때문에 오류
//}
