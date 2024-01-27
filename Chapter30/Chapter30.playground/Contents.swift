

// [ 뽑기 상품 프로토콜 정의 ]

// 포장된 상품을 표현
protocol WrappedPrize {
    associatedtype Prize
    
    var wrapColor: String! { get }  // 포장 색상
    var prize: Prize! { get }       // 실제 상품
}



// [ 포장된 상품 프로토콜 정의 ]

protocol Gundam { }
protocol Pokemon { }

struct WrappedGundam: WrappedPrize {
    var wrapColor: String!
    var prize: Gundam!
}

struct WrappedPokemon: WrappedPrize {
    var wrapColor: String!
    var prize: Pokemon!
}



//// [ 뽑기 기계 구조체 정의 ]
//
//struct PrizeMachine {
//    // WrappedPrize 프로토콜의 연관 타입인 Prize를 추론할 힌트를 얻지 못하기 때문에 ❌ 오류 발생!!
//    func dispenseRandomPrize() -> WrappedPrize {
//        return WrappedGundam()
//    }
//}




// [ 뽑기 기계 구조체 개선 ]

struct PrizeMachine {
    // 오류가 발생하지 않는다.
    func dispenseRandomPrize() -> some WrappedPrize {
        return WrappedGundam()
    }
}

let machine: PrizeMachine = PrizeMachine()
let wrappedPrize = machine.dispenseRandomPrize()
