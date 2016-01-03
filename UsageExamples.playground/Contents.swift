import HandySwift

// MARK: - IntExtension

//
// `init(randomBelow:)` – Initialize random Int value below given positive value.
//
Int(randomBelow: 50)
Int(randomBelow: 1_000_000)


// MARK: -  IntegerTypeExtension

//
// `n.times{ someCode }` – Calls someCode n times.
//
var stringArray: [String] = []

3.times{ stringArray.append("Hello World!") }
stringArray

var intArray: [Int] = []
5.times {
    let randomInt = Int(randomBelow: 1_000)
    intArray.append(randomInt)
}
intArray


// MARK: - StringExtension

//
// `string.strip` – Returns string with whitespace characters stripped from start and end.
//

" \t BB-8 likes Rey \t ".strip

//
// `string.isBlank` – Checks if String contains any characters other than whitespace characters.
//

"".isEmpty
"".isBlank

"  \t  ".isEmpty
"  \t  ".isBlank

//
// `init(randomWithLength:allowedCharactersType:)` – Get random numeric/alphabetic/alphanumeric String of given length.
//

String(randomWithLength: 4, allowedCharactersType: .Numeric)
String(randomWithLength: 6, allowedCharactersType: .Alphabetic)
String(randomWithLength: 8, allowedCharactersType: .AlphaNumeric)
String(randomWithLength: 10, allowedCharactersType: .AllCharactersIn("?!🐲🍏✈️🎎🍜"))


// MARK: - ArrayExtension

//
// `.sample` – Returns a random element within the array or nil if array empty.
//

[1, 2, 3, 4, 5].sample
([] as [Int]).sample

//
// `.sample(size:)` – Returns an array with `size` random elements or nil if array empty.
//

[1, 2, 3, 4, 5].sample(size: 3)
[1, 2, 3, 4, 5].sample(size: 12)
([] as [Int]).sample(size: 3)


// MARK: - SortedArray

//
// `SortedArray(array: unsortedArray)` – Initializes with unsorted array.
//
let sortedArray = SortedArray(array: [5, 2, 1, 3, 0, 4])

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
matchingSubArray.array


// MARK: - FrequencyTable

//
// `FrequencyTable(values: valuesArray){ /* frequencyClosure */ }` – Initialize with values and closure.
//
struct WordFrequency {
    let word: String; let frequency: Int
    init(word: String, frequency: Int) { self.word = word; self.frequency = frequency }
}
let wordFrequencies = [
    WordFrequency(word: "Harry", frequency: 10),
    WordFrequency(word: "Hermione", frequency: 4),
    WordFrequency(word: "Ronald", frequency: 1)
]

let frequencyTable = FrequencyTable(values: wordFrequencies){ $0.frequency }
frequencyTable

//
// `.sample` – Returns a random element with frequency-based probability within the array or nil if array empty.
//

frequencyTable.sample
let randomWord = frequencyTable.sample.map{ $0.word }
randomWord

//
// `.sample(size:)` – Returns an array with `size` frequency-based random elements or nil if array empty.
//

frequencyTable.sample(size: 6)
let randomWords = frequencyTable.sample(size: 6)!.map{ $0.word }
randomWords

