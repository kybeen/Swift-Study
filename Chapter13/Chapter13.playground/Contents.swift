import Foundation

// 정렬에 사용될 이름 배열
let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

//// 정렬을 위한 함수 전달
//func backwards(first: String, second: String) -> Bool {
//    print("\(first) \(second) 비교중")
//    return first > second
//}
//
//let reversed: [String] = names.sorted(by: backwards)
//print(reversed) // ["yagom", "wizplan", "jenny", "eric"]



//// [ sorted(by:) 메서드에 클로저 전달 ]
//
//// backwards(first:second:) 함수 대신에 sorted(by:) 메서드의 전달인자로 클로저를 직접 전달
//let reversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
//    return first > second
//})
//print(reversed) // ["yagom", "wizplan", "jenny", "eric"]




//// [ 후행 클로저 표현 ]
//
//// 후행 클로저의 사용
//let reversed: [String] = names.sorted() { (first: String, second: String) -> Bool in
//    return first > second
//}
//
//// sorted(by:) 메서드의 소괄호까지 생략 가능
//let reversed: [String] = names.sorted { (first: String, second: String) -> Bool in
//    return first > second
//}
//
//func doSomething(do: (String) -> Void,
//                 onSuccess: (Any) -> Void,
//                 onFailure: (Error) -> Void) {
//    // do something...
//}
//
//// 다중 후행 클로저의 사용
//doSomething { (something: String) in
//    // do closure
//} onSuccess: { (result: Any) in
//    // success closure
//} onFailure: { (error: Error) in
//    // failure closure
//}




//// [ 클로저의 타입 유추 ]
//let reversed: [String] = names.sorted { (first, second) in
//    return first > second
//}


//// [ 단축 인자 이름 사용 ]
//let reversed: [String] = names.sorted {
//    return $0 > $1
//}


//// [ 암시적 반환 표현의 사용 ]
//let reversed: [String] = names.sorted { $0 > $1 }


//// [ 클로저로서의 연산자 함수 사용 ]
//let reversed: [String] = names.sorted(by: >)





// [ makeIncrementer(forIncrement:) 함수 ]
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

//// [ incrementByTwo 상수에 함수 할당 ]
//
//let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
//
//let first: Int = incrementByTwo()   // 2
//let second: Int = incrementByTwo()  // 4
//let third: Int = incrementByTwo()   // 6


//// [ 각각의 incrementer의 동작 ]
//
//let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
//let incrementByTwo2: (() -> Int) = makeIncrementer(forIncrement: 2)
//let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)
//
//let first: Int = incrementByTwo()       // 2
//let second: Int = incrementByTwo()      // 4
//let third: Int = incrementByTwo()       // 6
//
//let first2: Int = incrementByTwo2()     // 2
//let second2: Int = incrementByTwo2()    // 4
//let third2: Int = incrementByTwo2()     // 6
//
//let ten: Int = incrementByTen()         // 10
//let twenty: Int = incrementByTen()      // 20
//let thirty: Int = incrementByTen()      // 30



//// [ 참조 타입인 클로저 ]
//
//let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)
//let sameWithIncrementByTwo: (() -> Int) = incrementByTwo
//
//let first: Int = incrementByTwo()           // 2
//let second: Int = sameWithIncrementByTwo()  // 4





//// [ 탈출 클로저를 매개변수로 갖는 함수 ]
//
//var completionHandlers: [() -> Void] = []
//
//func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
//    completionHandlers.append(completionHandler)
//}




//// [ 함수를 탈출하는 클로저의 예 ]
//
//typealias VoidVoidClosure = () -> Void
//let firstClosure: VoidVoidClosure = {
//    print("ClosureA")
//}
//let secondClosure: VoidVoidClosure = {
//    print("Closure B")
//}
//
//// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저임
//func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
//    // 전달인자로 전달받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저임
//    return shouldReturnFirstClosure ? first : second
//}
//
//// 함수에서 반환한 클로저가 함수 외부의 상수에 저장됨
//let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)
//
//returnedClosure()   // Closure A
//
//var closures: [VoidVoidClosure] = []
//
//// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저임
//func appendClosure(closure: @escaping VoidVoidClosure) {
//    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출
//    closures.append(closure)
//}



//// [ 클래스 인스턴스 메서드에 사용되는 탈출, 비탈출 클로저 ]
//
//typealias VoidVoidClosure = () -> Void
//
//func functionWithNoescapeClosure(closure: VoidVoidClosure) {
//    closure()
//}
//
//func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
//    return completionHandler
//}
//
//class SomeClass {
//    var x = 10
//    
//    func runNoescapeClosure() {
//        // 비탈출 클로저에서 self 키워드 사용은 선택 사항
//        functionWithNoescapeClosure {
//            x = 200
//        }
//    }
//    
//    func runEscapingClosure() -> VoidVoidClosure {
//        // 탈출 클로저에는 명시적으로 self를 사용해야 한다.
//        return functionWithEscapingClosure {
//            self.x = 100
//        }
//    }
//}
//
//let instance: SomeClass = SomeClass()
//instance.runNoescapeClosure()
//print(instance.x)   // 200
//
//let returnredClosure: VoidVoidClosure = instance.runEscapingClosure()
//returnredClosure()
//print(instance.x)   // 100




//// [ 오류가 발생하는 hasElements 함수 ]
//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return (array.lazy.filter { predicate($0) }.isEmpty == false )
//}



//// [ withoutActuallyEscaping(_:do:) 함수의 활용 ]
//
//let numbers: [Int] = [2, 4, 6, 8]
//
//let evenNumberPredicate = { (number: Int) -> Bool in
//    return number % 2 == 0
//}
//
//let oddNumberPredicate = { (number: Int) -> Bool in
//    return number % 2 == 1
//}
//
//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return withoutActuallyEscaping(predicate, do: { escapablePredicate in
//        return (array.lazy.filter { escapablePredicate($0) }.isEmpty == false)
//    })
//}
//
//let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
//let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)
//
//print(hasEvenNumber)    // true
//print(hasOddNumber)     // false




//// [ 클로저를 이용한 연산 지연 ]
//
//// 대기 중인 손님들
//var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]
//print(customersInLine.count)    // 4
//
//// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있는다.
//let customerProvider: () -> String = {
//    return customersInLine.removeFirst()
//}
//print(customersInLine.count)    // 4
//
//// 실제로 실행
//print("Now serving \(customerProvider())!") // "Now serving Messi!"
//print(customersInLine.count)    // 3



//// [ 함수의 전달인자로 전달하는 클로저 ]
//
//var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]
//
//func serveCustomer(_ customerProvider: () -> String) {
//    print("Now serving \(customerProvider())!") // 암시적 반환 표현으로 return 생략
//}
//
//serveCustomer( { customersInLine.removeFirst() } )  // "Now serving Messi!"




//// [ 자동 클로저의 사용 ]
//
//var customersInLine: [String] = ["Messi", "Ronaldo", "Neymar", "Bale"]
//
//func serveCustomer(_ customerProvider: @autoclosure () -> String) {
//    print("Now serving \(customerProvider())!")
//}
//
//serveCustomer(customersInLine.removeFirst())    // "Now serving Messi!"



// [ 자동 클로저의 탈출 ]

var customersInLine: [String] = ["Gerrard", "Torress", "Suarez"]

func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
    return customerProvider
}
let customerProvider: () -> String = returnProvider(customersInLine.removeFirst())
print("Now serving \(customerProvider())!") // "Now serving Gerrard!"
