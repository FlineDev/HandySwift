import HandySwift

// MARK: -  IntegerTypeExtension

// .times method

//
// `n.times{ someCode }` – Calls someCode n times.
//
var array: [String] = []

3.times{ array.append("Hello World!") }
array

array = []
3.times{ array.append("Hello World #\($0)!") }
array



