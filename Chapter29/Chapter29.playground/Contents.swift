import Foundation

//// [ 코드를 통해 메모리에 접근하는 유형 ]
//
//// one이 저장될 메모리 위치에 쓰기 접근
//var one: Int = 1
//
//// one이 저장된 메모리 위치에 읽기 접근
//print("숫자 출력 : \(one)")




//// [ 순차적, 순간적 메모리 접근 ]
//
//func oneMore(than number: Int) -> Int {
//    return number + 1
//}
//
//var myNumber: Int = 1
//myNumber = oneMore(than: myNumber)
//print(myNumber)
//// 2



//// 값 타입의 경우
//var number: Int = 100
//print(Unmanaged<AnyObject>.fromOpaque(&number).toOpaque())
//
//// 참조 타입의 경우
//var object: SomeClass = SomeClass()
//print(Unmanaged<AnyObject>.passUnretained(object).toOpaque())





//// [ 입출력 매개변수에서의 메모리 접근 충돌 ]
//
//var step: Int = 1
//
//func increment(_ number: inout Int) {
//    number += step
//}
//
///*
// 👉 step 변수는 increment(_:) 함수의 입출력 매개변수로 전달되었는데
//    함수 내부에서 같은 메모리 공간에 읽기 접근을 하려고 시도하기 때문에 메모리 접근 충돌이 발생한다.
// */
//increment(&step)    // ❌ 오류 발생!!




//// [ 입출력 매개변수에서의 메모리 접근 충돌 ]
//
//var step: Int = 1
//var copyOfStep: Int = step
//
//func increment(_ number: inout Int) {
//    number += copyOfStep
//}
//
//print(step, copyOfStep) // 1 1
//increment(&step)
//print(step, copyOfStep) // 2 1




//// [ 복수의 입출력 매개변수로 하나의 변수를 전달하여 메모리 접근 충돌 ]
//
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
//var playerOneScore: Int = 42
//var playerTwoScore: Int = 30
//balance(&playerOneScore, &playerTwoScore)   // 문제 없음
//balance(&playerOneScore, &playerOneScore)   // ❌ 오류 발생!!
//// 👉 playerOneScore라는 변수의 메모리 위치를 함수가 실행되는 동안 동시에 장기적 메모리 접근을 시도하기 때문에 문제가 발생한다.
//// 👉 이 경우에는 컴파일러에서 미리 컴파일 오류로 알려준다.





// [ 게임 캐릭터를 정의한 GamePlayer 구조체 ]

struct GamePlayer {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth() {
        // 👉 실행 중 인스턴스 자신인 self에 장기적으로 쓰기 접근을 한다.
        // 👉 restoreHealth() 메서드 내부의 코드 중 인스턴스의 다른 프로퍼티를 동시에 접근하는 코드가 없기 때문에 메모리 접근 충돌이 발생하지 않음
        self.health = GamePlayer.maxHealth
    }
    
    mutating func shareHealth(with teammate: inout GamePlayer) {
        // 👉 다른 캐릭터의 인스턴스를 입출력 매개변수로 받기 때문에 메모리 접근 충돌이 발생할 여지가 있다.
        balance(&teammate.health, &health)
    }
}
//
//var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
//var maria: GamePlayer = GamePlayer(name: "Maria", health: 5, energy: 10)
//
//// [ 메모리 접근 충돌이 없는 shareHealth(with:) 메서드 호출 ]
///*
// 👉 teammate 입출력 매개변수로 전달된 maria는 shareHealth(with:) 메서드가 실행되는 중에 쓰기 접근을 하고,
//    가변 메서드를 실행해야 하는 oscar도 쓰기 접근을 한다. 하지만 서로 다른 메모리 위치에 있기 때문에 접근 충돌이 발생하지 x
// */
//oscar.shareHealth(with: &maria)
//
//// [ 메모리 접근 충돌이 발생하는 shareHealth(with:) 메서드 호출 ]
///*
// 👉 teammate 입출력 매개변수로 전달받은 메모리 위치와 oscar 인스턴스의 메모리 위치는 같은 곳이기 때문에
//    동시에 쓰기 접근을 하면 메모리 접근 충돌이 발생한다.
// */
//oscar.shareHealth(with: &oscar) // ❌ 오류 발생!!





//// [ 프로퍼티 접근 중 메모리 접근 충돌 ]
//
//balance(&oscar.health, &oscar.energy)




// 전역변수와 지역변수의 메모리 접근의 차이

func someFunction() {
    var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
    // 👉 balance(_:_:) 함수 안에서만 oscar의 메모리 위치에 접근하기 때문에 문제될 것이 없다.
    balance(&oscar.health, &oscar.energy)
}
