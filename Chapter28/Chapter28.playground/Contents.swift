

// [ 자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형 ]

enum VendingMachineError: Error {
    case invalidSelection                       // 유효하지 않은 선택
    case insufficientFunds(coinsNeeded: Int)    // 자금 부족 - 필요한 동전 개수
    case outOfStock                             // 품절
}




// [ 자판기 동작 도중 발생한 오류 던지기 ]

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Biscuit": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    // throws 👉 오류를 던질 수 있는 메서드
    func vend(itemNamed name: String) throws {
        // 👉 오류 발생 시 흐름을 제어하기 위해 guard를 통한 빠른 종료 구문을 사용
        
        // 유효한 아이템을 선택했는지 확인
        guard let item = self.inventory[name] else {
            // 👉 특정 조건이 충족되지 않는다면 throw 키워드를 통해 오류를 던져서 오류가 발생했다는 것을 알림
            throw VendingMachineError.invalidSelection
        }
        
        // 선택한 아이템이 품절인지 확인
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        // 투입한 동전이 아이템을 살 수 있는 가격인지 확인
        guard item.price <= self.coinsDeposited else {
            throw VendingMachineError.insufficientFunds(
                coinsNeeded: item.price - self.coinsDeposited)
        }
        
        // 남은 동전 계산
        self.coinsDeposited -= item.price
        
        // 아이템 개수 수정
        var newItem = item
        newItem.count - 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom": "Chips",
    "jinsung": "Biscuit",
    "heejin": "Chocolate"
]
//
//// 👉 vend(itemNamed:) 메서드가 오류를 던질 가능성이 있으므로 vend(itemNamed:) 메서드를 호출하는 함수 또한 오류를 던질 수 있어야 한다.
//func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
//    let snackName = favoriteSnacks[person] ?? "Candy Bar"
//    try vendingMachine.vend(itemNamed: snackName)
//}
//
//struct PurchasedSnack {
//    let name: String
//    init(name: String, vendingMachine: VendingMachine) throws {
//        try vendingMachine.vend(itemNamed: name)
//        self.name = name
//    }
//}
//
//let machine: VendingMachine = VendingMachine()
//machine.coinsDeposited = 30
//
//var purchase: PurchasedSnack = try PurchasedSnack(name: "Biscuit", vendingMachine: machine)
//// Biscuit 제공
//
//print(purchase.name)    // Biscuit
//
//for (person, favoriteSnack) in favoriteSnacks {
//    print(person, favoriteSnack)
//    /*
//     👉 오류가 발생할 수 있는 메서드와 함수를 호출하면서도 try로 시도만 할 뿐 오류가 발생했을 때 처리할 수 있는 코드는 작성되어 있지 않기 때문에
//     오류 발생 후 다음 코드는 정상적으로 동작하지 않는다.
//     */
//    try buyFavoriteSnack(person: person, vendingMachine: machine)
//}
//// jinsung Biscuit
//// Biscuit 제공
//// yagom Chips
//// Chips 제공
//// heejin Chocolate
//// 오류 발생!!







//// [ do-catch 구문을 사용하여 던져진 오류를 처리 ]
//
//func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) {
//    let snackName = favoriteSnacks[person] ?? "Candy Bar"
//    tryingVend(itemNamed: snackName, vendingMachine: vendingMachine)
//}
//
//struct PurchasedSnack {
//    let name: String
//    init(name: String, vendingMachine: VendingMachine) {
//        tryingVend(itemNamed: name, vendingMachine: vendingMachine)
//        self.name = name
//    }
//}
//
//func tryingVend(itemNamed: String, vendingMachine: VendingMachine) {
//    do {
//        try vendingMachine.vend(itemNamed: itemNamed)
//    } catch VendingMachineError.invalidSelection {
//        print("유효하지 않은 선택")
//    } catch VendingMachineError.outOfStock {
//        print("품절")
//    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
//        print("자금 부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
//    } catch {
//        print("그 외 오류 발생 : ", error)
//    }
//}
//
//let machine: VendingMachine = VendingMachine()
//machine.coinsDeposited = 20
//
//var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)
//// Biscuit 제공
//print(purchase.name)    // Biscuit
//
//purchase = PurchasedSnack(name: "Ice Cream", vendingMachine: machine)
//// 유효하지 않은 선택
//print(purchase.name)    // Ice Cream
//
//for (person, favoriteSnack) in favoriteSnacks {
//    print(person, favoriteSnack)
//    try buyFavoriteSnack(person: person, vendingMachine: machine)
//}
//// heejin Chocolate
//// 유효하지 않은 선택
//// jinsung Biscuit
//// Biscuit 제공
//// yagom Chips
//// 자금 부족 - 동전 4개를 추가로 지급해주세요.







//// [ 옵셔널 값으로 오류를 처리 ]
//
//func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
//    if shouldThrowError {
//        enum SomeError: Error {
//            case justSomeError
//        }
//        
//        throw SomeError.justSomeError
//    }
//    
//    return 100
//}
//
//// 📌 someThrowingFunction(shouldThrowError:)의 반환 타입이 Int라도 try? 표현을 사용하면 반환 타입이 옵셔널이 된다.
//let x: Optional = try? someThrowingFunction(shouldThrowError: true)
//print(x)    // nil
//
//let y: Optional = try? someThrowingFunction(shouldThrowError: false)
//print(y)    // Optional(100)




//// [ 옵셔널 값으로 오류를 처리하는 방법과 기존 옵셔널 반환 타입과의 결합 ]
//
//// 👉 데이터를 디스크에서 가져오지 못하면 서버에서 가져오는 것을 시도해보고 그조차 없으면 nil을 반환
//func fetchData() -> Data? {
//    if let data = try? fetchDataFromDisk() {
//        return data
//    }
//    if let data = try? fetchDataFromServer() {
//        return data
//    }
//    return nil
//}





//// [ 오류가 발생하지 않음을 확신하여 오류처리 ]
//
//func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
//    if shouldThrowError {
//        enum SomeError: Error {
//            case justSomeError
//        }
//        
//        throw SomeError.justSomeError
//    }
//    
//    return 100
//}
//
//let y: Int = try! someThrowingFunction(shouldThrowError: false)
//print(y)    // 100
//
//let x: Int = try! someThrowingFunction(shouldThrowError: true)  // 런타임 오류!!





//// [ 오류의 다시 던지기 ]
//
//// 오류를 던지는 함수
//func someThrowingFunction() throws {
//    enum SomeError: Error {
//        case justSomeError
//    }
//    
//    throw SomeError.justSomeError
//}
//
//// 다시 던지기 함수
//func someFunction(callback: () throws -> Void) rethrows {
//    try callback()  // 다시 던지기 함수는 오류를 다시 던질 뿐 따로 처리하지는 않는다.
//}
//
//do {
//    try someFunction(callback: someThrowingFunction)
//} catch {
//    print(error)
//}
//// justSomeError




//// [ 다시 던지기 함수의 오류 던지기 ]
//
//// 오류를 던지는 함수
//func someThrowingFunction() throws {
//    enum SomeError: Error {
//        case justSomeError
//    }
//    
//    throw SomeError.justSomeError
//}
//
//// 다시 던지기 함수
//func someFunction(callback: () throws -> Void) rethrows {
//    enum AnotherError: Error {
//        case justAnotherError
//    }
//    
//    /*
//     다시 던지기 함수나 메서드가 오류를 던지는 함수를 do-catch 구문 내부에서 호출하고
//     catch 절 내부에서 다른 오류를 던짐으로써 오류를 던지는 함수에서 발생한 오류를 제어할 수 있다.
//     */
//    do {
//        // 매개변수로 전달한 오류 던지기 함수이므로 catch 절에서 제어할 수 있다.
//        try callback()
//    } catch {
//        throw AnotherError.justAnotherError
//    }
//    
//    do {
//        // 매개변수로 전달한 오류 던지기 함수가 아니므로 catch 절에서 제어할 수 없다.
//        try someThrowingFunction()
//    } catch {
//        // ❌ 오류 발생!
//        throw AnotherError.justAnotherError
//    }
//    
//    // ❌ catch 절 외부에서 단독으로 오류를 던질 수는 없다. 오류 발생 !!
//    throw AnotherError.justAnotherError
//}






//// [ 프로토콜과 상속에서 던지기 함수와 다시 던지기 함수 ]
//
//protocol SomeProtocol {
//    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
//    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
//}
//
//class SomeClass: SomeProtocol {
//    func someThrowingFunction(callback: () throws -> Void) throws { }
//    func someFunction(callback: () throws -> Void) rethrows { }
//    
//    // 던지기 메서드는 다시 던지기 메서드를 요구하는 프로토콜을 충족할 수 없다.
//    // ❌ 오류 발생!!
//    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) throws {
//    }
//    
//    // 다시 던지기 메서드는 던지기 메서드를 요구하는 프로토콜의 요구사항에 부합한다.
//    func someThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows {
//    }
//    
//}
//
//class SomeChildClass: SomeClass {
//    // 부모클래스의 던지기 메서드는 자식클래스에서 다시 던지기 메서드로 재정의할 수 있다.
//    override func someThrowingFunction(callback: () throws -> Void) rethrows { }
//    
//    // 부모클래스의 다시 던지기 메서드는 자식클래스에서 던지기 메서드로 재정의할 수 없다.
//    // ❌ 오류 발생!!
//    override func someFunction(callback: () throws -> Void) throws { }
//}






//for i in 0...2 {
//    defer {
//        print("A", terminator: " ")
//    }
//    print(i, terminator: " ")
//    
//    if i % 2 == 0 {
//        defer {
//            print("", terminator: "\n")
//        }
//        
//        print("It's even", terminator: " ")
//    }
//}
//// 0 It's even
//// A 1 A 2 It's even
//// A





//// [ 파일쓰기 예제에서 defer 구문 활용 ]
//
///*
// 👉 함수 내에서 파일을 열어 사용하다가 오류가 발생하여 코드가 블록을 빠져나가더라도
//    파일을 정상적으로 닫아 메모리에서 해제할 수 있도록 해준다.
// */
//func writeData() {
//    let file = openFile()
//    
//    // 함수 코드 블록을 빠져나가기 직전 무조건 실행되어 파일을 잊지 않고 닫아준다.
//    defer {
//        closeFile(file)
//    }
//    
//    if ... {
//        return
//    }
//    
//    if ... {
//        return
//    }
//    
//    // 처리 끝
//}




//// [ defer 구문의 실행 순서 ]
//
//func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
//    defer {
//        print("First")
//    }
//    
//    if shouldThrowError {
//        enum SomeError: Error {
//            case justSomeError
//        }
//        
//        throw SomeError.justSomeError
//    }
//    
//    defer {
//        print("Second")
//    }
//    
//    defer {
//        print("Third")
//    }
//    
//    return 100
//}
//
//try? someThrowingFunction(shouldThrowError: true)
//// First
//// 👉 오류를 던지기 직전까지 작성된 defer 구문까지만 실행된다.
//
//try? someThrowingFunction(shouldThrowError: false)
//// Third
//// Second
//// First





// [ 복합적인 defer 구문의 실행 순서 ]
func someFunction() {
    print("1")
    
    defer {
        print("2")
    }
    
    do {
        defer {
            print("3")
        }
        print("4")
    }
    
    defer {
        print("5")
    }
    
    print("6")
}

someFunction()
// 1
// 4
// 3
// 6
// 5
// 2
