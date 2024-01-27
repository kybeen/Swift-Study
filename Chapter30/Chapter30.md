# **Chapter 30. 불명확 타입**
- 반환 타입에 **`불명확 타입(Opaque Types)`** 을 사용하면 `반환할 타입의 정확한 타입을 알려주지 않은 채로 반환`하겠다는 것을 의미한다.
- **✅ 프로퍼티나 서브스크립트의 선언 혹은 함수의 반환 타입 위치에 프로토콜을 쓰면서 앞에 `some`을 붙이면, `'어떤 프로토콜을 따르는 타입을 반환할 것인데 그 타입이 명확히 뭔지는 알려주지 않겠다'`는 뜻을 나타낸다.**
  - `제네릭`과 비슷하지만 서로 다른 뜻을 나타낸다.
    - **👉 `제네릭`은 정의해줄 때 `정확히 어떤 타입이 들어올지 모르기 때문에` 플레이스 홀더를 만들어줌으로써 `외부에서 타입을 지정해주도록` 하는 것이다.**
    - **👉 `불명확 타입`은 반대로 `어떤 타입이 반환될지 외부에서는 모르기 때문에` `내부에서 타입을 정해서 내보내도록` 하는 것이다.**
      - 그렇기 때문에 `역제네릭 타입(Reverse Generic Tyoes)`이라고 표현하기도 한다.


### 📌 `뽑기 기계와 포장된 상품을 통한 불명확 타입 활용 예시`
- 여러 종류의 피규어를 임의로 배출하는 뽑기 기계가 있다.
- 뽑기는 포장을 열어보기 전까지는 어떤 상품이 들어있는 지 알 수 없다.
    ``` Swift
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
    ```

- 뽑기 기계의 구조체를 아래와 같이 정의해보면
  - WrappedPrize는 `제네릭 타입 제약이 있어야만 사용할 수 있는 타입`이기 때문에 `WrappedPrize 자체 만으로는 반환 타입이 될 수 없어 오류가 발생`한다.
  - 👉 WrappedPrize 프로토콜의 `연관 타입인 Prize를 추론할 힌트를 얻지 못하기 때문`
    ``` Swift
    // [ 뽑기 기계 구조체 정의 ]
    
    struct PrizeMachine {
        // WrappedPrize 프로토콜의 연관 타입인 Prize를 추론할 힌트를 얻지 못하기 때문에 ❌ 오류 발생!!
        func dispenseRandomPrize() -> WrappedPrize {
            return WrappedGundam()
        }
    }
    ```

- ✅ 반환 타입에 `some` 키워드를 붙여서 `불명확 타입으로 지정`해줌으로써 이를 해결할 수 있다.
    ``` Swift
    // [ 뽑기 기계 구조체 개선 ]

    struct PrizeMachine {
        // 오류가 발생하지 않는다.
        func dispenseRandomPrize() -> some WrappedPrize {
            return WrappedGundam()
        }
    }

    let machine: PrizeMachine = PrizeMachine()
    let wrappedPrize = machine.dispenseRandomPrize()
    ```

>💡 `외부에서는 정확한 타입은 알 수 없지만 해당 프로토콜을 준수하는 어떤 타입을 반환한다는 약속`을 불명확 타입으로 표현할 수 있다.
> 
>💡 불명확 타입은 함수(메서드)의 반환 타입뿐만 아니라 `프로퍼티나 서브스크립트의 타입에도 사용할 수 있다.`