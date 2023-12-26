import Foundation

//struct BasicInformation {
//    var name: String
//    var age: Int
//}
//
//var reiInfo: BasicInformation = BasicInformation(name: "rei", age: 25)
//reiInfo.age = 100 // 변경 가능
//reiInfo.name = "레이" // 변경 가능

//let ybInfo: BasicInformation = BasicInformation(name: "yb", age: 25)
//ybInfo.age = 100 // 변경 불가 - 오류
//ybInfo.name = "영빈" // 변경 불가 - 오류


//// [ Person 클래스 정의 ]
//class Person {
//    var height: Float = 0.0
//    var weight: Float = 0.0
//}
//
//// [ Person 클래스의 인스턴스 생성 및 사용 ]
//
//// Person 클래스의 프로퍼티는 기본값이 지정되어 있기 때문에 따로 초깃값을 전달해줄 필요X
//var rei: Person = Person()
//rei.height = 200
//rei.weight = 100
//
//let yb: Person = Person()
//yb.height = 200
//yb.weight = 100


//// [ Person 클래스의 인스턴스 생성 및 소멸 ]
//
//class Person {
//    var height: Float = 0.0
//    var weight: Float = 0.0
//    
//    deinit {
//        print("Person 클래스의 인스턴스가 소멸됩니다.")
//    }
//}
//
//var rei: Person? = Person()
//rei = nil // Person 클래스의 인스턴스가 소멸됩니다.



// [ 값 타입과 참조 타입의 차이 ]

struct BasicInformation {
    let name: String
    var age: Int
}

//var reiInfo: BasicInformation = BasicInformation(name: "rei", age: 99)
//reiInfo.age = 100
//
//// reiInfo의 값을 복사하여 할당
//var friendInfo: BasicInformation = reiInfo
//
//print("rei's age: \(reiInfo.age)") // 100
//print("friend's age: \(friendInfo.age)") // 100
//
//friendInfo.age = 999
//
//print("rei's age: \(reiInfo.age)") // 100 - 변동X
//print("friend's age: \(friendInfo.age)") // 999 - reiInfo의 값을 복사해왔기 때문에 별개의 값을 갖는다.

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

//var rei: Person = Person()
//var friend: Person = rei
//
//print("rei's height: \(rei.height)") // 0.0
//print("friend's height: \(friend.height)") // 0.0
//
//friend.height = 185.5
//print("rei's height: \(rei.height)") // 185.5 - friend는 rei를 참조하기 때문에 값이 변동된다.
//print("friend's height: \(friend.height)") // 185.5 - rei와 friend가 참조하는 곳이 같음을 알 수 있다.
//
//func changeBasicInfo(_ info: BasicInformation) {
//    var copiedInfo: BasicInformation = info
//    copiedInfo.age = 1
//}
//func changePersonInfo(_ info: Person) {
//    info.height = 155.3
//}
//
//// changeBasicInfo(_:)로 전달되는 전달인자는 값이 복사되어 전달되기 때문에 reiInfo의 값만 전달된다.
//changeBasicInfo(reiInfo)
//print("rei's age: \(reiInfo.age)") // 100
//
//// changePersonInfo(_:)의 전달인자로 rei의 참조가 전달되었기 때문에 rei가 참조하는 값들에 변화가 생긴다.
//changePersonInfo(rei)
//print("rei's height: \(rei.height)") // 155.3


// [ 식별 연산자의 사용 ]

var rei: Person = Person()
let friend: Person = rei                // rei의 참조를 할당
let anotherFriend: Person = Person()    // 새로운 인스턴스를 생성

print(rei === friend)           // true
print(rei === anotherFriend)    // false
print(friend !== anotherFriend) // true
