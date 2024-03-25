# Extensions

Making existing types more convenient to use.

@Metadata {
   @PageImage(purpose: icon, source: "HandySwift")
   @PageImage(purpose: card, source: "Extensions")
}

## Highlights

In the [Topics](#topics) section below you can find a list of all extension properties & functions. Click on one to reveal more details.

To get you started quickly, here are the ones I use in nearly all of my apps with a practical usage example for each:

#### Safe Index Access

![](MusicPlayer)

In [FocusBeats][FocusBeats] I'm accessing an array of music tracks using an index. With ``Swift/Collection/subscript(safe:)`` I avoid out of bounds crashes:

```swift
var nextEntry: ApplicationMusicPlayer.Queue.Entry? {
   guard let nextEntry = playerQueue.entries[safe: currentEntryIndex + 1] else { return nil }
   return nextEntry
}
```

You can use it on every type that conforms to ``Swift/Collection`` including `Array`, `Dictionary`, and `String`. Instead of calling the subscript `array[index]` which returns a non-Optional but crashes when the index is out of bounds, use the safer `array[safe: index]` which returns `nil` instead of crashing in those cases.

#### Blank Strings vs Empty Strings

![](APIKeys)

A common issue with text fields that are required to be non-empty is that users accidentally type a whitespace or newline character and don't recognize it. If the validation code just checks for `.isEmpty` the problem will go unnoticed. That's why in [String Catalog Translator][SCTranslator] when users enter an API key I make sure to first strip away any newlines and whitespaces from the beginning & end of the String before doing the `.isEmpty` check. And because this is something I do very often in many places, I wrote a helper:

```Swift
Image(systemName: self.deepLAuthKey.isBlank ? "xmark.circle" : "checkmark.circle")
   .foregroundStyle(self.deepLAuthKey.isBlank ? .red : .green)
```

Just use ``Swift/String/isBlank`` instead of `isEmpty` to get the same behavior!

#### Readable Time Intervals

![](PremiumPlanExpires)

Whenever I used an API that expects a `TimeInterval` (which is just a typealias for `Double`), I missed the unit which lead to less readable code because you have to actively remember that the unit is "seconds". Also, when I needed a different unit like minutes or hours, I had to do the calculation manually. Not with HandySwift!

Intead of passing a plain `Double` value like `60 * 5`, you can just pass `.minutes(5)`. For example in [String Catalog Translator][SCTranslator] to preview the view when a user unsubscribed I use this:

```swift
#Preview("Expiring") {
   ContentView(
      hasPremiumAccess: true, 
      premiumExpiresAt: Date.now.addingTimeInterval(.days(3))
   )
}
```

You can even chain multiple units with a `+` sign to create a day in time like "09:41 AM":

```swift
let startOfDay = Calendar.current.startOfDay(for: Date.now)
let iPhoneRevealedAt = startOfDay.addingTimeInterval(.hours(9) + .minutes(41))
```

Note that this API design is in line with ``Swift/Duration`` and ``Dispatch/DispatchTimeInterval`` which both already support things like `.milliseconds(250)`. But they stop at the seconds level, they don't go higher. HandySwift adds minutes, hours, days, and even weeks for those types, too. So you can write something like this:

```swift
try await Task.sleep(for: .minutes(5))
```

> Warning: Advancing time by intervals does not take into account complexities like daylight saving time. Use a `Calendar` for that.

#### Calculate Averages

![](CrosswordGeneration)

In the crossword generation algorithm within [CrossCraft][CrossCraft] I have a health function on every iteration that calculates the overall quality of the puzzle. Two different aspects are taken into consideration: 

```swift
/// A value between 0 and 1.
func calculateQuality() -> Double {
   let fieldCoverage = Double(solutionBoard.fields) / Double(maxFillableFields)
   let intersectionsCoverage = Double(solutionBoard.intersections) / Double(maxIntersections)
   return [fieldCoverage, intersectionsCoverage].average()
}
```

In previous versions I played around with different weights, for example giving intersections double the weight compared to field coverage. I could still achieve this using ``Swift/Collection/average()-3g44u`` like this in the last line:

```swift
return [fieldCoverage, intersectionsCoverage, intersectionsCoverage].average()
```

#### Round Floating-Point Numbers

![](ProgressBar)

When solving a puzzle in [CrossCraft][CrossCraft] you can see your current progress at the top of the screen. I use the built-in percent formatter (`.formatted(.percent)`) for numerics, but it requires a `Double` with a value between 0 and 1 (1 = 100%). Passing an `Int` like `12` unexpectedly renders as `0%`, so I can't simply do this:
```swift
Int(fractionCompleted * 100).formatted(.percent)  // => "0%" until "100%"
```

And just doing `fractionCompleted.formatted(.percent)` results in sometimes very long text such as `"0.1428571429"`. 

Instead, I make use of ``Swift/Double/rounded(fractionDigits:rule:)`` to round the `Double` to 2 significant digits like so:

```swift
Text(fractionCompleted.rounded(fractionDigits: 2).formatted(.percent))
```

> Note: There's also a mutating ``Swift/Double/round(fractionDigits:rule:)`` functions if you want to change a variable in-place.

#### Symmetric Data Cryptography

![](SharePuzzle)

Before uploading a crossword puzzle in [CrossCraft][CrossCraft] I make sure to encrypt it so tech-savvy people can't easily sniff the answers from the JSON like so:

```swift
func upload(puzzle: Puzzle) async throws {
   let key = SymmetricKey(base64Encoded: "<base-64 encoded secret>")!
   let plainData = try JSONEncoder().encode(puzzle)
   let encryptedData = try plainData.encrypted(key: key)
   
   // upload logic
}
```

Note that the above code makes use of two extensions, first ``CryptoKit/SymmetricKey/init(base64Encoded:)`` is used to initialize the key, then ``Foundation/Data/encrypted(key:)`` encrypts the data using safe ``CryptoKit`` APIs internally you don't need to deal with.

When another user downloads the same puzzle, I decrypt it with ``Foundation/Data/decrypted(key:)`` like so:

```swift
func downloadPuzzle(from url: URL) async throws -> Puzzle {
   let encryptedData = // download logic
   
   let key = SymmetricKey(base64Encoded: "<base-64 encoded secret>")!
   let plainData = try encryptedPuzzleData.decrypted(key: symmetricKey)
   return try JSONDecoder().decode(Puzzle.self, from: plainData)
}
```

> Note: HandySwift also conveniently ships with ``Swift/String/encrypted(key:)`` and ``Swift/String/decrypted(key:)`` functions for `String` which return a base-64 encoded String representation of the encrypted data. Use it when you're dealing with String APIs.


## Topics

### CaseIterable

- ``Swift/CaseIterable/allCasesPrefixedByNil``
- ``Swift/CaseIterable/allCasesSuffixedByNil``

### Collection

- ``Swift/Collection/subscript(safe:)``
- ``Swift/Collection/average()-3g44u``
- ``Swift/Collection/average()-rtqg``

### Comparable

- ``Swift/Comparable/clamped(to:)-5ky9b``
- ``Swift/Comparable/clamped(to:)-4dzn7``
- ``Swift/Comparable/clamped(to:)-8mqt8``
- ``Swift/Comparable/clamp(to:)-4djv3``
- ``Swift/Comparable/clamp(to:)-7bpgp``
- ``Swift/Comparable/clamp(to:)-4ohw5``

### Data

- ``Foundation/Data/encrypted(key:)``
- ``Foundation/Data/decrypted(key:)``

### Date

- ``Foundation/Date/reversed(by:)``

### Dictionary

- ``Swift/Dictionary/init(keys:values:)``

### DispatchTimeInterval

- ``Dispatch/DispatchTimeInterval/timeInterval``

### Double

- ``Swift/Double/round(fractionDigits:rule:)``
- ``Swift/Double/rounded(fractionDigits:rule:)``

### Duration

- ``Swift/Duration/timeInterval``
- ``Swift/Duration/weeks(_:)``
- ``Swift/Duration/days(_:)``
- ``Swift/Duration/hours(_:)``
- ``Swift/Duration/minutes(_:)``
- ``Swift/Duration/autoscaleFormatted()``
- ``Swift/Duration/multiplied(by:)-49cn7``
- ``Swift/Duration/multiplied(by:)-6knjk``
- ``Swift/Duration/divided(by:)-1h9df``
- ``Swift/Duration/divided(by:)-2lwae``
- ``Swift/Duration/divided(by:)-5s60j``

### Float

- ``Swift/Float/round(fractionDigits:rule:)``
- ``Swift/Float/rounded(fractionDigits:rule:)``

### Int

- ``Swift/Int/times(_:)``
- ``Swift/Int/timesMake(_:)``

### RandomAccessCollection

- ``Swift/RandomAccessCollection/randomElements(count:)``

### Sequence

- ``Swift/Sequence/sorted(byKeyPath:)``
- ``Swift/Sequence/max(byKeyPath:)``
- ``Swift/Sequence/min(byKeyPath:)``
- ``Swift/Sequence/sum()``
- ``Swift/Sequence/sum(mapToNumeric:)``
- ``Swift/Sequence/count(where:)``
- ``Swift/Sequence/count(where:equalTo:)``
- ``Swift/Sequence/count(where:notEqualTo:)``
- ``Swift/Sequence/count(where:prefixedBy:)``
- ``Swift/Sequence/count(where:prefixedByOneOf:)``
- ``Swift/Sequence/count(where:contains:)``
- ``Swift/Sequence/count(where:containsOneOf:)``
- ``Swift/Sequence/count(where:suffixedBy:)``
- ``Swift/Sequence/count(where:suffixedByOneOf:)``
- ``Swift/Sequence/count(where:greaterThan:)``
- ``Swift/Sequence/count(where:greaterThanOrEqual:)``
- ``Swift/Sequence/count(where:lessThan:)``
- ``Swift/Sequence/count(where:lessThanOrEqual:)``
- ``Swift/Sequence/filter(where:equalTo:)``
- ``Swift/Sequence/filter(where:notEqualTo:)``
- ``Swift/Sequence/filter(where:prefixedBy:)``
- ``Swift/Sequence/filter(where:prefixedByOneOf:)``
- ``Swift/Sequence/filter(where:contains:)``
- ``Swift/Sequence/filter(where:containsOneOf:)``
- ``Swift/Sequence/filter(where:suffixedBy:)``
- ``Swift/Sequence/filter(where:suffixedByOneOf:)``
- ``Swift/Sequence/filter(where:greaterThan:)``
- ``Swift/Sequence/filter(where:greaterThanOrEqual:)``
- ``Swift/Sequence/filter(where:lessThan:)``
- ``Swift/Sequence/filter(where:lessThanOrEqual:)``
- ``Swift/Sequence/first(where:equalTo:)``
- ``Swift/Sequence/first(where:notEqualTo:)``
- ``Swift/Sequence/first(where:prefixedBy:)``
- ``Swift/Sequence/first(where:prefixedByOneOf:)``
- ``Swift/Sequence/first(where:contains:)``
- ``Swift/Sequence/first(where:containsOneOf:)``
- ``Swift/Sequence/first(where:suffixedBy:)``
- ``Swift/Sequence/first(where:suffixedByOneOf:)``
- ``Swift/Sequence/first(where:greaterThan:)``
- ``Swift/Sequence/first(where:greaterThanOrEqual:)``
- ``Swift/Sequence/first(where:lessThan:)``
- ``Swift/Sequence/first(where:lessThanOrEqual:)``
- ``Swift/Sequence/count(prefixedBy:)``
- ``Swift/Sequence/count(prefixedByOneOf:)``
- ``Swift/Sequence/count(contains:)``
- ``Swift/Sequence/count(containsOneOf:)``
- ``Swift/Sequence/count(suffixedBy:)``
- ``Swift/Sequence/count(suffixedByOneOf:)``
- ``Swift/Sequence/count(greaterThan:)``
- ``Swift/Sequence/count(greaterThanOrEqual:)``
- ``Swift/Sequence/count(lessThan:)``
- ``Swift/Sequence/count(lessThanOrEqual:)``
- ``Swift/Sequence/filter(prefixedBy:)``
- ``Swift/Sequence/filter(prefixedByOneOf:)``
- ``Swift/Sequence/filter(contains:)``
- ``Swift/Sequence/filter(containsOneOf:)``
- ``Swift/Sequence/filter(suffixedBy:)``
- ``Swift/Sequence/filter(suffixedByOneOf:)``
- ``Swift/Sequence/filter(greaterThan:)``
- ``Swift/Sequence/filter(greaterThanOrEqual:)``
- ``Swift/Sequence/filter(lessThan:)``
- ``Swift/Sequence/filter(lessThanOrEqual:)``

### String

- ``Swift/String/isBlank``
- ``Swift/String/fullRange``
- ``Swift/String/fullNSRange``
- ``Swift/String/init(randomWithLength:allowedCharactersType:)``
- ``Swift/String/randomElements(count:)``
- ``Swift/String/encrypted(key:)``
- ``Swift/String/decrypted(key:)``

### StringProtocol

- ``Swift/StringProtocol/firstUppercased``
- ``Swift/StringProtocol/firstLowercased``

### SymmetricKey

- ``CryptoKit/SymmetricKey/base64EncodedString``
- ``CryptoKit/SymmetricKey/init(base64Encoded:)``

### TimeInterval

- ``Swift/Double/days``
- ``Swift/Double/hours``
- ``Swift/Double/minutes``
- ``Swift/Double/seconds``
- ``Swift/Double/milliseconds``
- ``Swift/Double/microseconds``
- ``Swift/Double/nanoseconds``
- ``Swift/Double/days(_:)``
- ``Swift/Double/hours(_:)``
- ``Swift/Double/minutes(_:)``
- ``Swift/Double/seconds(_:)``
- ``Swift/Double/milliseconds(_:)``
- ``Swift/Double/microseconds(_:)``
- ``Swift/Double/nanoseconds(_:)``
- ``Swift/Double/duration()``


[SCTranslator]: https://apps.apple.com/app/apple-store/id6476773066?pt=549314&ct=swiftpackageindex.com&mt=8
[CrossCraft]: https://apps.apple.com/app/apple-store/id6472669260?pt=549314&ct=swiftpackageindex.com&mt=8
[FocusBeats]: https://apps.apple.com/app/apple-store/id6477829138?pt=549314&ct=swiftpackageindex.com&mt=8
[Guided Guest Mode]: https://apps.apple.com/app/apple-store/id6479207869?pt=549314&ct=swiftpackageindex.com&mt=8
[Posters]: https://apps.apple.com/app/apple-store/id6478062053?pt=549314&ct=swiftpackageindex.com&mt=8
