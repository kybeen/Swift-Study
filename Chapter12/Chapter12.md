# **Chapter 12. 접근제어**
- 객체지향에서 `은닉화`는 중요한 개념 중 하나이며, `접근제어`를 통해 이를 구현할 수 있다.

## 접근제어란
- 코드끼리 상호작용을 할 때 파일/모듈 간에 접근을 제한하는 것

### `모듈과 소스파일`
- 스위프트의 접근제어는 모듈과 소스파일을 기반으로 설계되었음
  - **`모듈(Module)`** : 배포할 코드의 묶음 단위
    - ex) 프레임워크, 라이브러리, 애플리케이션...
    - `import` 키워드로 불러온다.
  - **`소스파일`** : 하나의 스위프트 소스 코드 파일을 의미
---

## 접근수준
- **접근제어는 `접근수준(Access Level)` 키워드를 통해 구현할 수 있다.**
  - 각 타입에 특정 접근수준을 지정할 수 있다.
  - 타입 뿐만 아니라 타입 내부의 프로퍼티, 메서드, 이니셜라이저 등에도 접근수준을 지정할 수 있다.
- `스위프트의 접근수준은 모듈과 소스파일에 따라 구분한다.`

    | 접근수준 | 키워드 | 접근도 | 범위 | 비고 |
    | :--- | :--- | :--- | :--- | :--- |
    | 개방 접근수준 | `open` | 높음 | 모듈 외부까지 | 클래스에서만 사용
    | 공개 접근수준 | `public` | ⬆️ | 모듈 외부까지 |  |
    | 내부 접근수준 | `Internal` | ⏹ | 모듈 내부 |  |
    | 파일외부비공개 접근수준 | `fileprivate` | ⬇️ | 파일 내부 |  |
    | 비공개 접근수준 | `private` | 낮음 | 기능 정의 내부  |  |
---

### ✔️ `공개 접근수준 - public`
- **`어디서든 쓰일 수 있다.`**
- `public(공개 접근수준)`은 주로 프레임워크에서 외부와 연결된 인터페이스를 구현하는데 많이 쓰인다.
- 사용하는 스위프트의 기본 요소는 모두 `public`으로 구현되어있다고 보면 된다.
    ``` Swift
    // [ 스위프트 표준 라이브러리에 정의되어 있는 Bool 타입 ]

    /// A value type whose instance are either 'true' or 'false'.
    public struct Bool {
        /// Default-initialized Boolean value to 'false'.
        public init()
    }
    ```


### ✔️ `개방 접근수준 - open`
- **`public 이상으로 높은 접근수준`** 이며, 클래스와 클래스의 멤버에서만 사용할 수 있다.
- 기본적으로 `public`과 비슷하지만 몇 가지 차이가 있다.
  - `open`을 제외한 다른 모든 접근수준의 클래스는 그 클래스가 정의된 모듈 안에서만 상속할 수 있다.
  - `open`을 제외한 다른 모든 접근수준의 클래스 멤버는 해당 멤버가 정의된 모듈 안에서만 재정의할 수 있다.
  - **`open`의 클래스는 `그 클래스가 정의된 모듈 밖의 다른 모듈에서도 상속`할 수 있다.**
  - **`open`의 클래스 멤버는 `해당 멤버가 정의된 모듈 밖에 다른 모듈에서도 재정의`할 수 있다.**
- 클래스를 `open`으로 명시하는 것은 그 클래스를 다른 모듈에서도 부모클래스로 사용하겠다는 목적으로 클래스를 설계하고 코드를 작성했음을 의미한다.
    ``` Swift
    // [ Foundation 프레임워크에 정의되어 있는 개방 접근수준의 NSString 클래스 ]

    open class NSString : NSObject, NSCopying, NSMutableCopying, NSSecureCoding {
        open var length: Int { get }
        open func character(at index: Int) -> unichar
        public init()
        public init?(coder: NSCoder)
    }
    ```


### ✔️ `내부 접근수준 - internal`
- **`기본적으로 모든 요소에 암묵적으로 지정하는 기본 접근수준`**
- **`소스파일에 속해 있는 모듈 어디서든 쓰일 수 있다.`**
  - 그 모듈을 가져다 쓰는 외부 모듈에서는 접근할 수 X


### ✔️ `파일외부비공개 접근수준 - fileprivate`
- **`구현된 소스파일 내부에서만 사용할 수 있다.`**


### ✔️ `비공개 접근수준 - private`
- 가장 한정적인 범위
- **`그 기능을 정의하고 구현한 범위 내에서만 사용할 수 있다.`**
---

## 접근제어 구현
- 접근제어는 접근수준을 지정해서 구현할 수 있다.
- `internal`은 기본 접근수준이기 때문에 굳이 표기할 필요 X

``` Swift
// [ 접근수준을 명기한 각 요소들의 예 ]

open class OpenClass {
    open var openProperty: Int = 0
    public var publicProperty: Int = 0
    internal var internalProperty: Int = 0
    fileprivate var fileprivateProperty: Int = 0
    private var privateProperty: Int = 0
    
    open func openMethod() {}
    public func publicMethod() {}
    internal func internalMethod() {}
    fileprivate func fileprivateMethod() {}
    private func privateMethod() {}
}

public class PublicClass {}
public struct PublicStruct {}
public enum PublicEnum {}
public var publicVariable = 0
public let publicConstant = 0
public func publicFunction() {}

internal class InternalClass {}     // internal 키워드는 생략 가능
internal struct InternalStruct {}
internal enum InternalEnum {}
internal var internalVariable = 0
internal let internalConstant = 0
internal func internalFunction() {}

fileprivate class FileprivateClass {}
fileprivate struct FileprivateStruct {}
fileprivate enum FileprivateEnum {}
fileprivate var fileprivateVariable = 0
fileprivate let fileprivateConstant = 0
fileprivate func fileprivateFunction() {}

private class PrivateClass {}
private struct PrivateStruct {}
private enum PrivateEnum {}
private var privateVariable = 0
private let privateConstant = 0
private func privateFunction() {}
```
---

## 접근제어 구현 참고사항
- **`'상위 요소보다 하위 요소가 더 높은 접근수준을 가질 수 없다'`** 는 모든 타입에 적용되는 접근수준의 규칙이다.

``` Swift
// [ 잘못된 접근수준 부여 ]

private class AClass {
    // 공개 접근수준을 부여해도 AClass의 접근수준이 비공개 접근수준이므로
    // 이 메서드의 접근수준도 비공개 접근수준으로 취급된다.
    public func someMethod() {
        // ...
    }
}

// AClass의 접근수준이 비공개 접근수준이므로
// 공개 접근수준 함수의 매개변수나 반환 값 타입으로 사용할 수 없다.
public func someFuction(a: AClass) -> AClass { // 오류 발생
    return a
}
```

``` Swift
// [ 튜플의 접근수준 부여 ]

internal class InternalClass {} // 내부 접근수준 클래스
private struct PrivateStruct {} // 비공개 접근수준 구조체

// 요소로 사용되는 InternalClass와 PrivateStruct 접근수준이
// publicTuple보다 낮기 때문에 사용할 수 없다.
public var publicTuple: (first: InternalClass, second: PrivateStruct) = (InternalClass(), PrivateStruct())

// 요소로 사용되는 InternalClass와 PrivateStruct 접근수준이
// privateTuple과 같거나 높기 때문에 사용할 수 있다.
private var privateTuple: (first: InternalClass, second: PrivateStruct) = (InternalClass(), PrivateStruct())
```

``` Swift
// [ 접근수준에 따른 결과 ]

// AClass.swift파일과 Common.swift 파일이 같은 모듈에 속해 있을 경우

// AClass.swift 파일
class AClass {
    func internalMethod() {}
    fileprivate func fileprivateMethod() {}
    var internalProperty = 0
    fileprivate var fileprivateProperty = 0
}

// Common.swift 파일
let aInstance: AClass = AClass()
aInstance.internalMethod()          // 같은 모듈이므로 호출 가능
aInstance.fileprivateMethod()       // 다른 파일이므로 호출 불가능 - 오류
aInstance.internalProperty = 1      // 같은 모듈이므로 접근 가능
aInstance.fileprivateProperty = 1   // 다른 파일이므로 접근 불가 - 오류
```
- 따라서 `프레임워크를 만들 때`는 다른 모듈에서 특정 기능에 접근할 수 있도록 API로 사용할 기능을 `public(공개 접근수준)`으로 지정해주어야 한다.

- `열거형`의 접근수준을 구현할 때 열거형 내부의 각 `case`별로 따로 접근수준을 부여할 수는 없다.
  - 각 `case`의 접근수준은 열거형 자체의 접근수준을 따른다.

    ``` Swift
    // [ 열거형의 접근수준 ]

    private typealias PointValue = Int

    // 오류 - PointValue가 Point보다 접근수준이 낮기 때문에 원시 값으로 사용할 수 없다.
    enum Point: PointValue {
        case x, y
    }
    ```
---

## private와 fileprivate
- 같은 파일 내부에서 `private`과 `fileprivate` 접근수준을 사용할 때 분명한 차이가 존재한다.
  - **`fileprivate` 접근수준으로 지정한 요소는 `같은 파일 내부라면 어떤 코드에서도 접근`할 수 있다.**
  - **`private` 접근수준으로 지정한 요소는 `같은 파일 내부에 다른 타입의 코드에서는 접근이 불가능`하다.**
    - 익스텐션 코드가 같은 파일에 존재하는 경우에는 접근 가능

``` Swift
// [ 같은 파일에서의 private과 fileprivate의 동작 ]

public struct SomeType {
    private var privateVariable = 0
    fileprivate var fileprivateVariable = 0
}

// 같은 타입의 익스텐션에서는 private 요소에 접근 가능
extension SomeType {
    public func publicMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    private func privateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    fileprivate func fileprivateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
}

struct AnotherType {
    var someInstance: SomeType = SomeType()
    
    mutating func someMethod() {
        // public 접근수준에는 어디서든 접근 가능
        self.someInstance.publicMethod()    // 0, 0
        
        // 같은 파일에 속해 있는 코드이므로 fileprivate 접근수준 요소에 접근 가능
        self.someInstance.fileprivateVariable = 100
        self.someInstance.fileprivateMethod()   // 0, 100
        
        // 다른 타입 내부의 코드이므로 private 요소에 접근 불가 - 오류
        // self.someInstance.privateVariable = 100
        // self.someInstance.privateMethod()
    }
}

var anotherInstance = AnotherType()
anotherInstance.someMethod()
```
---

## 읽기 전용 구현
- **다음과 같은 상황 등에서 `설정자(Setter)`만 더 낮은 접근수준을 갖도록 제한함으로써 `읽기 전용 구현`을 할 수 있다.**
  - 값을 변경할 수 없도록 구현하고 싶을 때
  - 서브스크립트도 읽기만 가능하도록 제한하고 싶을 때
  - 등...
- 요소의 접근수준 키워드 뒤에 아래 처럼 표현하면 `설정자의 접근수준만 더 낮도록 지정`해줄 수 있다.
  > **`접근수준(set)`**
- 설정자 접근수준 제한은 `프로퍼티`, `서브스크립트`, `변수` 등에 적용될 수 있으며, `해당 요소의 접근수준보다 같거나 낮은 수준`으로 제한해주어야 한다.

``` Swift
// [ 설정자의 접근수준 지정 ]

public struct SomeType {
    // 비공개 접근수준 저장 프로퍼티 count
    private var count: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicStoredProperty
    public var publicStoredProperty: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicGetOnlyStoredProperty
    // 설정자는 비공개 접근수준
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    // 내부 접근수준 연산 프로퍼티 internalComputedProperty
    internal var internalComputedProperty: Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
    
    // 내부 접근수준 연산 프로퍼티 internalGetOnlyComputedProperty
    // 설정자는 비공개 접근수준
    internal private(set) var internalGetOnlyComputedProperty: Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    public subscript() -> Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    // 설정자는 내부 접근수준
    public internal(set) subscript(some: Int) -> Int {
        get {
            return count
        }
        
        set {
            count += 1
        }
    }
}

var someInstance: SomeType = SomeType()

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance.publicStoredProperty)
someInstance.publicStoredProperty = 100                 // 0

// 외부에서 접근자만 사용 가능
print(someInstance.publicGetOnlyStoredProperty)         // 0
//someInstance.publicGetOnlyStoredProperty = 100        // 오류 발생

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance.internalComputedProperty)            // 0
someInstance.internalComputedProperty = 100

// 외부에서 접근자만 사용 가능
print(someInstance.internalGetOnlyComputedProperty)     // 1
//someInstance.internalGetOnlyComputedProperty = 100    // 오류 발생

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance[])                                   // 1
someInstance[] = 100

// 외부에서 접근자만, 같은 모듈 내에서는 설정자도 사용 가능
print(someInstance[0])                                  // 2
someInstance[0] = 100

```