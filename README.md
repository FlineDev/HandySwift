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
github "Flinesoft/HandySwift" ~> 0.2
```

And run `carthage update`. Then drag & drop the HandySwift.framework in the Carthage/build folder to your project. Now you can `import HandySwift` in each class you want to use its features.

## Usage

Please have a look at the UsageExamples.playground for a complete list of features provided.
Open the Playground from within the `.xcworkspace` in order for it to work.

### IntExtension

#### .times

Repeat some code block a given number of times.

``` Swift
3.times{ array.append("Hello World!") }
// => ["Hello World!", "Hello World!", "Hello World!"]

5.times() {
  let randomInt = Int(arc4random_uniform(1000))
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
SortedArray(array: [5, 2, 1, 3, 0, 4]).subArray(toIndex: Array<Int>.Index(2))
// => [2, 3, 4, 5]
```


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. If there's a related discussion on the Swift Evolution mailing list, please also post the thread name with a link.

Pull requests with new features will only be accepted when the following are given:
- The feature is **handy** but not (yet) part of the Swift standard library.
- **Tests** for the new feature exist and all tests pass successfully.
- **Usage examples** of the new feature are given in the Playgrounds.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
