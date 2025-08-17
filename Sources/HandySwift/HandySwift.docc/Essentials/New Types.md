# New Types

Adding missing types and global functions.

@Metadata {
   @PageImage(purpose: icon, source: "HandySwift")
   @PageImage(purpose: card, source: "NewTypes")
}

## Highlights

In the [Topics](#topics) section below you can find a list of all new types & functions. Click on one to reveal more details.

To get you started quickly, here are the ones I use in nearly all of my apps with a practical usage example for each:

### Gregorian Day & Time

You want to construct a `Date` from year, month, and day? Easy:

```swift
GregorianDay(year: 1960, month: 11, day: 01).startOfDay() // => Date 
```

You have a `Date` and want to store just the day part of the date, not the time? Just use ``GregorianDay`` in your model:

```swift
struct User {
   let birthday: GregorianDay
}

let selectedDate = // coming from DatePicker
let timCook = User(birthday: GregorianDay(date: selectedDate))
print(timCook.birthday.iso8601Formatted)  // => "1960-11-01"
```

You just want today's date without time?

```swift
GregorianDay.today
```

Works also with `.yesterday` and `.tomorrow`. For more, just call:

```swift
let todayNextWeek = GregorianDay.today.advanced(by: 7)
```

> Note: `GregorianDay` conforms to all the protocols you would expect, such as `Codable`, `Hashable`, and `Comparable`. For encoding/decoding, it uses the ISO format as in "2014-07-13".

``GregorianTime`` is the counterpart:

```swift
let iPhoneAnnounceTime = GregorianTime(hour: 09, minute: 41)
let anHourFromNow = GregorianTime.now.advanced(by: .hours(1))

let date = iPhoneAnnounceTime.date(day: GregorianDay.today)  // => Date
```

### Delay & Debounce

Have you ever wanted to delay some code and found this API annoying to remember & type out?

```swift
DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(250)) {
   // your code
}
```

HandySwift introduces a shorter version that's easier to remember:

```swift
delay(by: .milliseconds(250)) {
   // your code
}
```

It also supports different Quality of Service classes like `DispatchQueue` (default is main queue):

```swift
delay(by: .milliseconds(250), qosClass: .background) {
   // your code
}
```

While delaying is great for one-off tasks, sometimes there's fast input that causes performance or scalability issues. For example, a user might type fast in a search field. It's common practice to delay updating the search results and additionally cancelling any older inputs once the user makes a new one. This practice is called "Debouncing". And it's easy with HandySwift:

```swift
@State private var searchText = ""
let debouncer = Debouncer()

var body: some View {
    List(filteredItems) { item in
        Text(item.title)
    }
    .searchable(text: self.$searchText)
    .onChange(of: self.searchText) { newValue in
        self.debouncer.delay(for: .milliseconds(500)) {
            // Perform search operation with the updated search text after 500 milliseconds of user inactivity
            self.performSearch(with: newValue)
        }
    }
    .onDisappear {
        debouncer.cancelAll()
    }
}
```

Note that the ``Debouncer`` was stored in a property so ``Debouncer/cancelAll()`` could be called on disappear for cleanup. But the ``Debouncer/delay(for:id:operation:)-83bbm`` is where the magic happens – and you don't have to deal with the details!

> Note: If you need multiple debouncing operations in one view, you don't need multiple debouncers. Just pass an `id` to the delay function. 

### Networking & Debugging

Building REST API clients is common in modern apps. HandySwift provides ``RESTClient`` to simplify this:

```swift
let client = RESTClient(
    baseURL: URL(string: "https://api.example.com")!,
    baseHeaders: ["Authorization": "Bearer \(token)"],
    errorBodyToMessage: { _ in "Error" }
)

let user: User = try await client.fetchAndDecode(method: .get, path: "users/me")
```

When debugging API issues, choose the appropriate logging plugins based on your platform:

#### For iOS/macOS/tvOS/watchOS Apps (Recommended)

Use OSLog-based plugins for structured, searchable logging:

```swift
let client = RESTClient(
    baseURL: URL(string: "https://api.example.com")!,
    requestPlugins: [LogRequestPlugin(debugOnly: true)],   // Structured request logging
    responsePlugins: [LogResponsePlugin(debugOnly: true)], // Structured response logging
    errorBodyToMessage: { try JSONDecoder().decode(YourAPIErrorType.self, from: $0).message }
)
```

These plugins use the modern OSLog framework for structured logging that integrates with Console.app and Instruments for advanced debugging.

#### For Server-Side Swift (Vapor/Linux)

Use print-based plugins for console output where OSLog is not available:

```swift
let client = RESTClient(
    baseURL: URL(string: "https://api.example.com")!,
    requestPlugins: [PrintRequestPlugin(debugOnly: true)],   // Console request logging
    responsePlugins: [PrintResponsePlugin(debugOnly: true)], // Console response logging
    errorBodyToMessage: { try JSONDecoder().decode(YourAPIErrorType.self, from: $0).message }
)
```

These plugins are particularly helpful when adopting new APIs, providing detailed request/response information to help diagnose issues. The `debugOnly: true` parameter ensures they only operate in DEBUG builds, making them safe to leave in your code.

## Topics

### Collections

- ``FrequencyTable``
- ``SortedArray``

### Date & Time

- ``GregorianDay``
- ``GregorianTime``

### UI Helpers

- ``Debouncer``
- ``OperatingSystem`` (short: ``OS``)

### Networking & Debugging

- ``RESTClient``
- ``LogRequestPlugin`` (for iOS/macOS/tvOS/watchOS apps)
- ``LogResponsePlugin`` (for iOS/macOS/tvOS/watchOS apps)
- ``PrintRequestPlugin`` (for server-side Swift/Vapor)
- ``PrintResponsePlugin`` (for server-side Swift/Vapor)

### Other

- ``delay(by:qosClass:_:)-8iw4f``
- ``delay(by:qosClass:_:)-yedf``
- ``HandyRegex``
