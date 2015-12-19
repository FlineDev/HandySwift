# HandySwift

The goal of this library is to provide handy features that didn't make it to the Swift standard library (yet) due to many different reasons. Those could be that the Swift community wants to keep the standard library clean and manageable or simply hasn't finished discussion on a specific feature yet.

## Installation

### Carthage

Simply add this line to you Cartfile:

```
github "Flinesoft/HandySwift"   ~> 0.1
```

And run `carthage update`. Then drag & drop the HandySwift.framework in the Carthage/build folder to your project. Now you can `import HandySwift` in each class you want to use its features.

TODO: Installation instructions for CocoaPods and Swift Package Manager are missing.

## Usage

Please have a look at the UsageExamples.playground for a complete list of features provided.

### IntegerTypeExtension

#### .times

``` Swift
3.times{ array.append("Hello World!") }
// => ["Hello World!", "Hello World!", "Hello World!"]
```

## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. If there's a related discussion on the Swift Evolution mailing list, please also post the thread name with a link.

Pull requests with new features will only be accepted when the following are given:
- The feature is **handy** but not (yet) part of the Swift standard library.
- **Tests** for the new feature exist and all tests pass successfully.
- **Usage examples** of the new feature are given in the Playgrounds.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
