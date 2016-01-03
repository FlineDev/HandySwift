# HandySwift

The goal of this library is to provide handy features that didn't make it to the Swift standard library (yet) due to many different reasons. Those could be that the Swift community wants to keep the standard library clean and manageable or simply hasn't finished discussion on a specific feature yet.

## Installation

Currently the recommended way of installing this library is via [Carthage](https://github.com/Carthage/Carthage).
[Cocoapods](https://github.com/CocoaPods/CocoaPods) isn't supported yet (contributions welcome!).
[Swift Package Manager](https://github.com/apple/swift-package-manager) was targeted but didn't work in my tests.

You can of course also just include this framework manually into your project by downloading it or by using git submodules.

### Carthage

Simply add this line to your Cartfile:

```
github "Flinesoft/HandySwift"
```

And run `carthage update`. Then drag & drop the HandySwift.framework in the Carthage/build folder to your project. Now you can `import HandySwift` in each class you want to use its features.

## Usage

Please have a look at the UsageExamples.playground for a complete list of features provided.
Open the Playground from within the `.xcworkspace` in order for it to work.

### IntExtension

### init(randomBelow:)

Initialize random Int value below given positive value.

``` Swift
Int(randomBelow: 50) // => 26
Int(randomBelow: 1_000_000) // => 208041
```

### IntegerTypeExtension

#### .times

Repeat some code block a given number of times.

``` Swift
3.times{ array.append("Hello World!") }
// => ["Hello World!", "Hello World!", "Hello World!"]

5.times {
  let randomInt = Int(randomBelow: 1_000)
  intArray.append(randomInt)
}
// => [481, 16, 680, 87, 912]
```

### StringExtension

#### .strip

Returns string with whitespace characters stripped from start and end.

``` Swift
" \t BB-8 likes Rey \t ".strip
// => "BB-8 likes Rey"
```

#### .isBlank

Checks if String contains any characters other than whitespace characters.

``` Swift
"  \t  ".isBlank
// => true
```

#### init(randomWithLength:allowedCharactersType:)

Get random numeric/alphabetic/alphanumeric String of given length.

``` Swift
String(randomWithLength: 4, allowedCharactersType: .Numeric) // => "8503"
String(randomWithLength: 6, allowedCharactersType: .Alphabetic) // => "ysTUzU"
String(randomWithLength: 8, allowedCharactersType: .AlphaNumeric) // => "2TgM5sUG"
String(randomWithLength: 10, allowedCharactersType: .AllCharactersIn("?!🐲🍏✈️🎎🍜"))
// => "!🍏🐲✈️🎎🐲🍜??🍜"
```

### ArrayExtension

#### .sample

Returns a random element within the array or nil if array empty.

``` Swift
[1, 2, 3, 4, 5].sample // => 4
([] as [Int]).sample // => nil
```

#### .sample(size:)

Returns an array with `size` random elements or nil if array empty.

``` Swift
[1, 2, 3, 4, 5].sample(size: 3) // => [2, 1, 4]
[1, 2, 3, 4, 5].sample(size: 8) // => [1, 4, 2, 4, 3, 4, 1, 5]
([] as [Int]).sample(size: 3) // => nil
```

### SortedArray

The main purpose of this wrapper is to provide speed improvements for specific actions on sorted arrays.

#### init(array:) & .array

``` Swift
let unsortedArray = [5, 2, 1, 3, 0, 4]
let sortedArray = SortedArray(array: unsortedArray)
sortedArray.array   // => [0, 1, 2, 3, 4, 5]
```

#### .firstMatchingIndex

Finds the lowest index matching the given predicate using binary search for an improved performance (`O(log n)`).

``` Swift
SortedArray(array: [5, 2, 1, 3, 0, 4]).firstMatchingIndex{ $0 > 1 }
// => 2
```

#### .subArray(toIndex:)

``` Swift
SortedArray(array: [5, 2, 1, 3, 0, 4]).subArray(toIndex: Array<Int>.Index(2))
// => [0, 1]
```

#### .subArray(fromIndex:)

``` Swift
SortedArray(array: [5, 2, 1, 3, 0, 4]).subArray(fromIndex: Array<Int>.Index(2))
// => [2, 3, 4, 5]
```

### FrequencyTable

#### FrequencyTable(values: valuesArray){ valueToFrequencyClosure }

Initialize with values and closure.

``` Swift
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
// => HandySwift.FrequencyTable<WordFrequency>
```


#### .sample

Returns a random element with frequency-based probability within the array or nil if array empty.

``` Swift
frequencyTable.sample
let randomWord = frequencyTable.sample.map{ $0.word }
// => "Harry"
```

#### .sample(size:)

Returns an array with `size` frequency-based random elements or nil if array empty.

``` Swift
frequencyTable.sample(size: 6)
let randomWords = frequencyTable.sample(size: 6)!.map{ $0.word }
// => ["Harry", "Ronald", "Harry", "Harry", "Hermione", "Hermione"]
```


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. If there's a related discussion on the Swift Evolution mailing list, please also post the thread name with a link.

Pull requests with new features will only be accepted when the following are given:
- The feature is **handy** but not (yet) part of the Swift standard library.
- **Tests** for the new feature exist and all tests pass successfully.
- **Usage examples** of the new feature are given in the Playgrounds.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
