# HandySwift

The goal of this library is to provide handy features that didn't make it to the Swift standard library (yet) due to many different reasons like the Swift community wanting to keep the standard library clean and manageable or simply hasn't finished discussion yet.

## Installation

TODO: Installation instructions are missing. Carthage, Cocoapods and Swift Package Manager support are planned.

## Usage

Please have a look at the UsageExamples.playground for a complete list of features provided.

### IntegerTypeExtension

#### .times

```
3.times{ array.append("Hello World!") }
// => ["Hello World!", "Hello World!", "Hello World!"]
```

```
3.times{ array.append("Hello World #\($0)!") }
// => ["Hello World #1!", "Hello World #2!", "Hello World #3!"]
```

## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. If there's a related discussion on the Swift Evolution mailing list, please also post the thread name with a link.

Pull requests with new features will only be accepted when the following are given:
- The feature is handy but not (yet) part of the Swift standard library.
- Tests for the new feature exist and all tests pass successfully.
- Usage examples of the new feature are given in the Playgrounds.

## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
