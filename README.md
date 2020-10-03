<p align="center">
    <img src="https://raw.githubusercontent.com/Flinesoft/HandySwift/main/Logo.png"
      width=600>
</p>

<p align="center">
    <a href="https://github.com/Flinesoft/HandySwift/actions?query=branch%3Amain">
        <img src="https://github.com/Flinesoft/HandySwift/workflows/CI/badge.svg"
             alt="CI">
    </a>
    <a href="https://codecov.io/gh/Flinesoft/HandySwift">
        <img src="https://codecov.io/gh/Flinesoft/HandySwift/branch/main/graph/badge.svg"
             alt="Coverage"/>
    </a>
    <a href="https://github.com/Flinesoft/HandySwift/releases">
        <img src="https://img.shields.io/badge/Version-3.2.1-blue.svg"
             alt="Version: 3.2.1">
    </a>
    <img src="https://img.shields.io/badge/Swift-5.1-FFAC45.svg" alt="Swift: 5.1">
    <img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20Linux-FF69B4.svg"
        alt="Platforms: iOS | tvOS | macOS | Linux">
    <a href="https://github.com/Flinesoft/HandySwift/blob/main/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
              alt="License: MIT">
    </a>
    <br />
    <a href="https://paypal.me/Dschee/5EUR">
        <img src="https://img.shields.io/badge/PayPal-Donate-orange.svg"
             alt="PayPal: Donate">
    </a>
    <a href="https://github.com/sponsors/Jeehut">
        <img src="https://img.shields.io/badge/GitHub-Become a sponsor-orange.svg"
             alt="GitHub: Become a sponsor">
    </a>
    <a href="https://patreon.com/Jeehut">
        <img src="https://img.shields.io/badge/Patreon-Become a patron-orange.svg"
             alt="Patreon: Become a patron">
    </a>
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="#donation">Donation</a>
  • <a href="https://github.com/Flinesoft/HandySwift/issues">Issues</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>


# HandySwift

The goal of this library is to **provide handy features** that didn't make it to the Swift standard library (yet) due to many different reasons. Those could be that the Swift community wants to keep the standard library clean and manageable or simply hasn't finished discussion on a specific feature yet.

If you like this, please also checkout [HandyUIKit](https://github.com/Flinesoft/HandyUIKit) for handy UI features that we feel should have been part of the UIKit frameworks in the first place.

> If you are **upgrading from a previous major version** of HandySwift (e.g. 1.x to 2.x) then checkout the [releases section on GitHub](https://github.com/Flinesoft/HandySwift/releases) and look out for the release notes of the last major releas(es) (e.g. 2.0.0) for an overview of the changes made. It'll save you time as hints are on how best to migrate are included there.

## Installation

Currently the recommended way of installing this library is via [Swift Package Manager](https://github.com/apple/swift-package-manager). [Carthage](https://github.com/Carthage/Carthage) & [Cocoapods](https://github.com/CocoaPods/CocoaPods) are supported, too.

You can of course also just include this framework manually into your project by downloading it or by using git submodules.

## Usage

Please have a look at the UsageExamples.playground for a complete list of features provided.
Open the Playground from within the `.xcworkspace` in order for it to work.

---
#### Feature Overview

- [Globals](#globals)
- Extensions
  - [IntExtension](#intextension)
  - [IntegerTypeExtension](#integertypeextension)
  - [StringExtension](#stringextension)
  - [NSRangeExtension](#nsrangeextension)
  - [CollectionExtension](#collectionextension)
  - [ArrayExtension](#arrayextension)
  - [DictionaryExtension](#dictionaryextension)
  - [DispatchTimeIntervalExtension](#dispatchtimeintervalextension)
- New types
  - [SortedArray](#sortedarray)
  - [FrequencyTable](#frequencytable)
  - [Regex](#regex)
  - [Weak](#weak)
  - [Unowned](#unowned)

---

### Globals
Some global helpers.

#### delay(bySeconds:) { ... }
Runs a given closure after a delay given in seconds. Dispatch queue can be set optionally, defaults to Main thread.

``` Swift
delay(by: .milliseconds(1_500)) { // Runs in Main thread by default
    date = NSDate() // Delayed by 1.5 seconds: 2016-06-07 05:38:05 +0000
}
delay(by: .seconds(5), dispatchLevel: .userInteractive) {
    date = NSDate() // Delayed by 5 seconds: 2016-06-07 05:38:08 +0000
}
```

### IntExtension

#### init(randomBelow:)

Initialize random Int value below given positive value.

``` Swift
Int(randomBelow: 50)! // => 26
Int(randomBelow: 1_000_000)! // => 208041
```

#### .times

Repeat some code block a given number of times.

``` Swift
3.times { print("Hello World!") }
// => prints "Hello World!" 3 times
```

#### .timesMake

Makes array by adding closure's return value n times.

``` Swift
let intArray = 5.timesMake { Int(randomBelow: 1_000)! }
// => [481, 16, 680, 87, 912]
```

### ComparableExtension

#### clamped(to:)

Apply a limiting range as the bounds of a `Comparable`.
Supports `ClosedRange` (`a ... b`), `PartialRangeFrom` (`a...`) and `PartialRangeThrough` (`...b`) as the `limits`.

``` Swift
let myNum = 3
myNum.clamped(to: 0 ... 6) // => 3
myNum.clamped(to: 0 ... 2) // => 2
myNum.clamped(to: 4 ... 6) // => 4
myNum.clamped(to: 5...) // => 4
myNum.clamped(to: ...2) // => 2

let myString = "d"
myString.clamped(to: "a" ... "g") // => "d"
myString.clamped(to: "a" ... "c") // => "c"
myString.clamped(to: "e" ... "g") // => "e"
myString.clamped(to: "f"...) // => "f"
myString.clamped(to: ..."c") // => "c"
```

#### clamp(to:)

In-place `mutating` variant of `clamped(to:)`

``` Swift
var myNum = 3
myNum.clamp(to: 0...2)
myNum // => 2
```

### StringExtension

#### .stripped()

Returns string with whitespace characters stripped from start and end.

``` Swift
" \n\t BB-8 likes Rey \t\n ".stripped()
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
String(randomWithLength: 4, allowedCharactersType: .numeric) // => "8503"
String(randomWithLength: 6, allowedCharactersType: .alphabetic) // => "ysTUzU"
String(randomWithLength: 8, allowedCharactersType: .alphaNumeric) // => "2TgM5sUG"
String(randomWithLength: 10, allowedCharactersType: .allCharactersIn("?!🐲🍏✈️🎎🍜"))
// => "!🍏🐲✈️🎎🐲🍜??🍜"
```

#### .fullRange

Get the full `Range` on a `String` object.

``` Swift
let unicodeString = "Hello composed unicode symbols! 👨‍👩‍👧‍👦👨‍👨‍👦‍👦👩‍👩‍👧‍👧"
unicodeString[unicodeString.fullRange] // => same string
```

### NSRangeExtension

#### init(_:in:)

Converting from `NSRange` to `Range<String.Index>` became simple in Swift 4:

``` Swift
let string = "Hello World!"
let nsRange = NSRange(location: 0, length: 10)
let swiftRange = Range(nsRange, in: string)
```

The opposite is now also possible with this extension:

``` Swift
let string = "Hello World!"
let swiftRange: Range<String.Index> = string.fullRange
let nsRange = NSRange(swiftRange, in: string)
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

#### .combinations(with:)

Combines each element with each element of a given other array.

``` Swift
[1, 2, 3].combinations(with: ["A", "B"])
// => [(1, "A"), (1, "B"), (2, "A"), (2, "B"), (3, "A"), (3, "B")]
```

### DictionaryExtension
#### init?(keys:values:)

Initializes a new `Dictionary` and fills it with keys and values arrays or returns nil if count of arrays differ.

``` Swift
let structure = ["firstName", "lastName"]
let dataEntries = [["Harry", "Potter"], ["Hermione", "Granger"], ["Ron", "Weasley"]]
Dictionary(keys: structure, values: dataEntries[0]) // => ["firstName": "Harry", "lastName": "Potter"]

dataEntries.map { Dictionary(keys: structure, values: $0) }
// => [["firstName": "Harry", "lastName": "Potter"], ["firstName": "Hermione", "lastName": "Grange"], ...]

Dictionary(keys: [1,2,3], values: [1,2,3,4,5]) // => nil
```

#### .merge(Dictionary)

Merges a given `Dictionary` into an existing `Dictionary` overriding existing values for matching keys.

``` Swift
var dict = ["A": "A value", "B": "Old B value"]
dict.merge(["B": "New B value", "C": "C value"])
dict // => ["A": "A value", "B": "New B value", "C": "C value"]
```

#### .merged(with: Dictionary)
Create new merged `Dictionary` with the given `Dictionary` merged into a `Dictionary` overriding existing values for matching keys.

``` Swift
let immutableDict = ["A": "A value", "B": "Old B value"]
immutableDict.merged(with: ["B": "New B value", "C": "C value"])
// => ["A": "A value", "B": "New B value", "C": "C value"]
```

### DispatchTimeIntervalExtension
#### .timeInterval

Returns a `TimeInterval` object from a `DispatchTimeInterval`.

``` Swift
DispatchTimeInterval.milliseconds(500).timeInterval // => 0.5
```

### TimeIntervalExtension
#### Unit based pseudo-initializers
Returns a `TimeInterval` object with a given value in a the specified unit.

``` Swift
TimeInterval.days(1.5) // => 129600
TimeInterval.hours(1.5) // => 5400
TimeInterval.minutes(1.5) // => 90
TimeInterval.seconds(1.5) // => 1.5
TimeInterval.milliseconds(1.5) // => 0.0015
TimeInterval.microseconds(1.5) // => 1.5e-06
TimeInterval.nanoseconds(1.5) // => 1.5e-09
```

#### Unit based getters
Returns a double value with the time interval converted to the specified unit.

``` Swift
let timeInterval: TimeInterval = 60 * 60 * 6

timeInterval.days // => 0.25
timeInterval.hours // => 6
timeInterval.minutes // => 360
timeInterval.seconds // => 21600
timeInterval.milliseconds // => 21600000
timeInterval.microseconds // => 21600000000
timeInterval.nanoseconds // => 21600000000000
```


### SortedArray

The main purpose of this wrapper is to provide speed improvements for specific actions on sorted arrays.

#### init(array:) & .array

``` Swift
let unsortedArray = [5, 2, 1, 3, 0, 4]
let sortedArray = SortedArray(unsortedArray)
sortedArray.array   // => [0, 1, 2, 3, 4, 5]
```

#### .index

Finds the lowest index matching the given predicate using binary search for an improved performance (`O(log n)`).

``` Swift
SortedArray([5, 2, 1, 3, 0, 4]).index { $0 > 1 }
// => 2
```

#### .prefix(upTo:) / .prefix(through:)

``` Swift
SortedArray([5, 2, 1, 3, 0, 4]).prefix(upTo: 2)
// => [0, 1]
```

#### .suffix(from:)

``` Swift
SortedArray([5, 2, 1, 3, 0, 4]).suffix(from: 2)
// => [2, 3, 4, 5]
```

### FrequencyTable

#### FrequencyTable(values: valuesArray) { valueToFrequencyClosure }

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

let frequencyTable = FrequencyTable(values: wordFrequencies) { $0.frequency }
// => HandySwift.FrequencyTable<WordFrequency>
```

#### .sample

Returns a random element with frequency-based probability within the array or nil if array empty.

``` Swift
frequencyTable.sample
let randomWord = frequencyTable.sample.map { $0.word }
// => "Harry"
```

#### .sample(size:)

Returns an array with `size` frequency-based random elements or nil if array empty.

``` Swift
frequencyTable.sample(size: 6)
let randomWords = frequencyTable.sample(size: 6)!.map { $0.word }
// => ["Harry", "Ronald", "Harry", "Harry", "Hermione", "Hermione"]
```


### Regex

`Regex` is a swifty regex engine built on top of the `NSRegularExpression` API.

#### init(_:options:)

Initialize with pattern and, optionally, options.

``` swift
let regex = try Regex("(Phil|John), [\\d]{4}")

let options: Regex.Options = [.ignoreCase, .anchorsMatchLines, .dotMatchesLineSeparators, .ignoreMetacharacters]
let regexWithOptions = try Regex("(Phil|John), [\\d]{4}", options: options)
```

#### regex.matches(_:)

Checks whether regex matches string

``` swift
regex.matches("Phil, 1991") // => true
````

#### regex.matches(in:)

Returns all matches

``` swift
regex.matches(in: "Phil, 1991 and John, 1985")  
// => [Match<"Phil, 1991">, Match<"John, 1985">]
```

#### regex.firstMatch(in:)

Returns first match if any

``` swift
regex.firstMatch(in: "Phil, 1991 and John, 1985")
// => Match<"Phil, 1991">
```

#### regex.replacingMatches(in:with:count:)

Replaces all matches in a string with a template string, up to the a maximum of matches (count).

``` swift
regex.replacingMatches(in: "Phil, 1991 and John, 1985", with: "$1 was born in $2", count: 2)
// => "Phil was born in 1991 and John was born in 1985"
```

#### match.string

Returns the captured string

``` swift
match.string // => "Phil, 1991"
```

#### match.range

Returns the range of the captured string within the base string

``` swift
match.range // => Range
```

#### match.captures

Returns the capture groups of a match

``` swift
match.captures // => ["Phil", "1991"]
```

#### match.string(applyingTemplate:)

Replaces the matched string with a template string

``` swift
match.string(applyingTemplate: "$1 was born in $2")
// => "Phil was born in 1991"
```

### Weak

`Weak` is a wrapper to store weak references to a `Wrapped` instance.

#### Weak(_:)

Initialize with an object reference.

``` swift
let text: NSString = "Hello World!"
var weak = Weak(text)
```

#### Accessing inner Reference

Access the inner wrapped reference with the `value` property.

``` swift
print(weak.value!)
```

#### NilLiteralExpressible Conformance

Create a `Weak` wrapper by assigning nil to the value.
``` swift
var weakWrappedValue: Weak<AnyObject> = nil
```

### Unowned

`Unowned` is a wrapper to store unowned references to a `Wrapped` instance.

#### Unowned(_:)

Initialize with an object reference.
``` swift
var unowned = Unowned(text)
```

#### Accessing inner Reference

Access the inner wrapped reference with the `value` property.
``` swift
print(unowned.value)
```

### CollectionExtension

#### [try:]

Returns an element with the specified index or nil if the element does not exist .
``` swift
let testArray = [0, 1, 2, 3, 20]
testArray[try: 4]  // => Optional(20)
testArray[try: 20] // => nil
```

#### .sum()
Returns the sum of all elements. The return type is determined by the numeric elements, e.g. Int for [Int].
NOTE: Only available for `Numeric` types.
``` swift
[0, 1, 2, 3, 4].sum() // => 10
[0.5, 1.5, 2.5].sum() // => 4.5
```

#### .average()
Returns the average of all elements as a Double value.
NOTE: Only available for `Int` and `Double` collections.
``` swift
[10, 20, 30, 40].average() // => 25.0
[10.75, 20.75, 30.25, 40.25].average() // => 25.5
```

### Withable
Simple protocol to make constructing and modifying objects with multiple properties more pleasant (functional, chainable, point-free). Supported by all `NSObject` subclasses by default.

``` swift
struct Foo: Withable {
    var bar: Int
    var isEasy: Bool = false
}

let defaultFoo = Foo(bar: 5)
let customFoo = Foo(bar: 5).with { $0.isEasy = true }

foo.isEasy // => false
foo2.isEasy // => true
```


## Donation

BartyCrouch was brought to you by [Cihat Gündüz](https://github.com/Jeehut) in his free time. If you want to thank me and support the development of this project, please **make a small donation on [PayPal](https://paypal.me/Dschee/5EUR)**. In case you also like my other [open source contributions](https://github.com/Flinesoft) and [articles](https://medium.com/@Jeehut), please consider motivating me by **becoming a sponsor on [GitHub](https://github.com/sponsors/Jeehut)** or a **patron on [Patreon](https://www.patreon.com/Jeehut)**.

Thank you very much for any donation, it really helps out a lot! 💯


## Contributing

Contributions are welcome. Feel free to open an issue on GitHub with your ideas or implement an idea yourself and post a pull request. If you want to contribute code, please try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)). Also, please make sure to add an entry to the `CHANGELOG.md` file which explains your change.


## License

This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
