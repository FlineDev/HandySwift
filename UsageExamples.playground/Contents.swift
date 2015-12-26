import HandySwift

// MARK: -  IntExtension

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


// MARK: - SortedArray

//
// `SortedArray(array: unsortedArray)` – Initializes with unsorted array.
//
let unsortedArray = [5, 2, 1, 3, 0, 4]
let sortedArray = SortedArray(array: unsortedArray)

//
// `sortedArray.array` – Gives access to internal sorted array.
//
sortedArray.array

//
// `sortedArray.firstMatchingIndex{ predicate }` – Binary search with predicate.
//
let index = sortedArray.firstMatchingIndex{ $0 > 1 }
index

//
// `sortedArray.subArray(toIndex: index) – Returns beginning part as sorted subarray.
//
let nonMatchingSubArray = sortedArray.subArray(toIndex: index!)
nonMatchingSubArray.array

//
// `sortedArray.subArray(fromIndex: index) – Returns ending part as sorted subarray.
//
let matchingSubArray = sortedArray.subArray(fromIndex: index!)
matchingSubArray.arrays