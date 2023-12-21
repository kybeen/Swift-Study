import Foundation

//// [ 옵셔널 변수의 선언 및 nil 할당 ]
//
//var myName: String? = "kybeen"
//print(myName) // Optional("kybeen")
//// 옵셔널 타입의 값을 print함수의 매개변수로 전달하면 컴파일러 경고가 발생할 수 있다.
//
//myName = nil
//print(myName) // Optional(nil)




// [ 암시적 추출 옵셔널의 사용 ]

var myName: String! = "rei"
print(myName) // rei
myName = nil

// 암시적 추출 옵셔널도 옵셔널이므로 바인딩을 사용할 수 있다.
if let name = myName {
    print("My name is \(name)")
} else {
    print("myName == nil")
}
// myName == nil

myName.isEmpty // nil값일 때 접근하면 오류 발생
