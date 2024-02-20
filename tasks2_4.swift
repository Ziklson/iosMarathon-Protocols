import Foundation
protocol GameDice {
    var numberDice: Int { get }
}
extension Int: GameDice {
    var numberDice: Int {
        return self
    }
}
let diceCoub = 4
print("There are \(diceCoub.numberDice) on the dice") 
@objc protocol SomeProtocol {
    func doSomething()
    
    var someValue: Int { get }
    
    @objc optional var someOptionalValue: String? { get }
}

class SomeClass: SomeProtocol {
    func doSomething() {
        print("Doing something")
    }
    
    var someValue: Int
    
    init(someValue: Int) {
        self.someValue = someValue
    }
}
let someClass = SomeClass(someValue: 5)
someClass.doSomething()
/////////////////////////////////////////////////////////////////////////////







