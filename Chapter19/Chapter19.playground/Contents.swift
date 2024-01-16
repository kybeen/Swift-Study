import UIKit

//// [ 실패 가능한 이니셜라이저 ]
//
//var stringValue: String = "123"
//var integerValue: Int? = Int(stringValue)
//
//print(integerValue) // Optional(123)
//
//stringValue = "A123"
//integerValue = Int(stringValue)
//
//print(integerValue) // nil





// [ Coffee 클래스와 Coffee 클래스를 상속받은 Latte와 Americano 클래스 ]

class Coffee {
    let name: String
    let shot: Int
    
    var description: String {
        return "\(shot) shot(s) \(name)"
    }
    
    init(shot: Int) {
        self.shot = shot
        self.name = "coffee"
    }
}

class Latte: Coffee {
    var flavor: String
    
    override var description: String {
        return "\(shot) shot(s) \(flavor) latte"
    }
    
    init(flavor: String, shot: Int) {
        self.flavor = flavor
        super.init(shot: shot)
    }
}

class Americano: Coffee {
    let iced: Bool
    
    override var description: String {
        return "\(shot) shot(s) \(iced ? "iced" : "hot") americano"
    }
    
    init(shot: Int, iced: Bool) {
        self.iced = iced
        super.init(shot: shot)
    }
}





//// [ 데이터 타입 확인 ]
//
let coffee: Coffee = Coffee(shot: 1)
//print(coffee.description)       // 1 shot(s) coffee
//
let myCoffee: Americano = Americano(shot: 2, iced: false)
//print(myCoffee.description)     // 2 shot(s) hot americano
//
let yourCoffee: Latte = Latte(flavor: "green tea", shot: 3)
//print(yourCoffee.description)   // 3 shot(s) green tea latte
//
//print(coffee is Coffee)     // true
//print(coffee is Americano)  // false
//print(coffee is Latte)      // false
//
//print(myCoffee is Coffee)   // true
//print(yourCoffee is Coffee) // true
//
//print(myCoffee is Latte)    // false
//print(yourCoffee is Latte)  // true





//// [ 메타 타입 ]
//
//protocol SomeProtocol { }
//class SomeClass: SomeProtocol { }
//
//let intType: Int.Type = Int.self
//let stringType: String.Type = String.self
//let classType: SomeClass.Type = SomeClass.self
//let protocolProtocol: SomeProtocol.Protocol = SomeProtocol.self
//
//var someType: Any.Type
//
//someType = intType
//print(someType) // Int
//
//someType = stringType
//print(someType) // String
//
//someType = classType
//print(someType) // SomeClass
//
//someType = protocolProtocol
//print(someType) // SomeProtocol





//// [ type(of:) 함수와 .self의 사용 ]
//
//print(type(of: coffee) == Coffee.self)          // true
//print(type(of: coffee) == Americano.self)       // false
//print(type(of: coffee) == Latte.self)           // false
//
//print(type(of: coffee) == Americano.self)       // false
//print(type(of: myCoffee) == Americano.self)     // true
//print(type(of: yourCoffee) == Americano.self)   // false
//
//print(type(of: coffee) == Latte.self)           // false
//print(type(of: myCoffee) == Latte.self)         // false
//print(type(of: yourCoffee) == Latte.self)       // true





//// [ Latte 타입의 인스턴스를 참조하는 Coffee 타입 actingConstant 상수 ]
//
let actingConstant: Coffee = Latte(flavor: "vanilla", shot: 2)
//print(actingConstant.description)   // 2 shot(s) vanilla latte





//// [ 다운캐스팅 ]
//
//// == 만약 coffee가 참조하는 인스턴스가 Americano 타입의 인스턴스라면 actingOne이라는 임시 상수에 할당하라
//if let actingOne: Americano = coffee as? Americano {
//    print("This is Americano")
//} else {
//    print(coffee.description)
//}
//// 1 shot(s) coffee
//
//if let actingOne: Latte = coffee as? Latte {
//    print("This is Latte")
//} else {
//    print(coffee.description)
//}
//// 1 shot(s) coffee
//
//if let actingOne: Coffee = coffee as? Coffee {
//    print("This is Just Coffee")
//} else {
//    print(coffee.description)
//}
//// This is Just Coffee
//
//if let actingOne: Americano = myCoffee as? Americano {
//    print("This is Americano")
//} else {
//    print(coffee.description)
//}
//// This is Americano
//
//if let actingOne: Latte = myCoffee as? Latte {
//    print("This is Latte")
//} else {
//    print(coffee.description)
//}
//// 1 shot(s) coffee
//
//if let actingOne: Coffee = myCoffee as? Coffee {
//    print("This is Just Coffee")
//} else {
//    print(coffee.description)
//}
//// This is Just Coffee
//
//// Success
//let castedCoffee: Coffee = yourCoffee as! Coffee
//
//// 런타임 오류!!! 강제 다운캐스팅 실패!
//let castedAmericano: Americano = coffee as! Americano





//// [ 항상 성공하는 다운캐스팅 ]
//let castedCoffee: Coffee = yourCoffee as Coffee




//// [ AnyObject의 타입 확인 ]
//
//func checkType(of item: AnyObject) {
//    if item is Latte {
//        print("item is Latte")
//    } else if item is Americano {
//        print("item is Americano")
//    } else if item is Coffee {
//        print("item is Coffee")
//    } else {
//        print("Unknown Type")
//    }
//}
//
//checkType(of: coffee)           // item is Coffee
//checkType(of: myCoffee)         // item is Americano
//checkType(of: yourCoffee)       // item is Latte
//checkType(of: actingConstant)   // item is Latte




//// [ AnyObject의 타입캐스팅 ]
//
//func castTypeToAppropriate(item: AnyObject) {
//    if let castedItem: Latte = item as? Latte {
//        print(castedItem.description)
//    } else if let castedItem: Americano = item as? Americano {
//        print(castedItem.description)
//    } else if let castedItem: Coffee = item as? Coffee {
//        print(castedItem.description)
//    } else {
//        print("Unknown Type")
//    }
//}
//
//castTypeToAppropriate(item: coffee)         // 1 shot(s) coffee
//castTypeToAppropriate(item: myCoffee)       // 2 shot(s) hot americano
//castTypeToAppropriate(item: yourCoffee)     // 3 shot(s) green tea latte
//castTypeToAppropriate(item: actingConstant) // 2 shot(s) vanilla latte





// [ Any의 타입캐스팅 ]

func checkAnyType(of item: Any) {
    switch item {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    case let latte as Latte:
        print(latte.description)
    case let stringConverter as (String) -> String:
        print(stringConverter("rei"))
    default:
        print("something else : \(type(of: item))")
    }
}

checkAnyType(of: 0)             // zero as an Int
checkAnyType(of: 0.0)           // zero as a Double
checkAnyType(of: 42)            // an integer value of 42
checkAnyType(of: 3.14159)       // a positive double value of 3.14159
checkAnyType(of: -0.25)         // some other double value that I don't want to print
checkAnyType(of: "hello")       // a string value of "hello"
checkAnyType(of: (3.0, 5.0))    // an (x, y) point at 3.0, 5.0
checkAnyType(of: yourCoffee)    // 3 shot(s) green tea latte
checkAnyType(of: coffee)        // something else : Coffee
checkAnyType(of: { (name: String) -> String in "Hello, \(name)" })  // Hello, rei

