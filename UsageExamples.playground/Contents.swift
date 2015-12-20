import HandySwift

// MARK: -  IntegerTypeExtension

// .times method

//
// `n.times{ someCode }` – Calls someCode n times.
//
var stringArray: [String] = []

3.times{ stringArray.append("Hello World!") }
stringArray

var intArray: [Int] = []
5.times() {
    let randomInt = Int(arc4random_uniform(1000))
    intArray.append(randomInt)
}
intArray