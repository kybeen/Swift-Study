import Foundation

//// [ 비반환 함수의 정의와 사용 ]
//
//func crashAndBurn() -> Never {
//    fatalError("Something very, very bad happened")
//}
//
////crashAndBurn() // 프로세스 종료 후 오류 보고
//
//func someFunction(isAllIsWell: Bool) {
//    guard isAllIsWell else {
//        print("마을에 도둑이 들었습니다!")
//        crashAndBurn()
//    }
//    print("All is well")
//}
//
//someFunction(isAllIsWell: true)     // All is well
//someFunction(isAllIsWell: false)    // 마을에 도둑이 들었습니다!
//// 프로세스 종료 후 오류 보고




// [ @discardableResult 선언 속성 사용 ]

func say(_ something: String) -> String {
    print(something)
    return something
}

@discardableResult func discardableResultSay(_ something: String) -> String {
    print(something)
    return something
}

// 반환 값을 사용하지 않았으므로 컴파일러가 경고를 표시할 수 있다.
say("hello") // hello

// 반환 값을 사용하지 않아도 경고하지 않음
discardableResultSay("hello") // hello
