import Foundation

extension Sequence {
   /// Returns the elements of the sequence, sorted using the `Comparable` value of the given keypath.
   ///
   /// Example:
   /// ```swift
   /// struct Person { let name: String; let age: Int }
   /// let people = [Person(name: "Alice", age: 30), Person(name: "Bob", age: 25)]
   /// let sortedByAge = people.sorted(byKeyPath: \.age)
   /// // Results in [Person(name: "Bob", age: 25), Person(name: "Alice", age: 30)]
   /// ```
   ///
   /// - Parameter keyPath: A keypath that specifies the property to compare.
   /// - Returns: An array of elements sorted based on the value of the specified keypath.
   public func sorted(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> [Self.Element] {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
   }

   /// Returns the maximum element in the sequence, sorted using the `Comparable` value of the given keypath.
   ///
   /// Example:
   /// ```swift
   /// struct Person { let name: String; let age: Int }
   /// let people = [Person(name: "Alice", age: 30), Person(name: "Bob", age: 25)]
   /// let oldest = people.max(byKeyPath: \.age)
   /// // Results in Person(name: "Alice", age: 30)
   /// ```
   ///
   /// - Parameter keyPath: A keypath that specifies the property to compare.
   /// - Returns: The maximum element in the sequence, or `nil` if the sequence is empty.
   public func max(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> Self.Element? {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }.last
   }

   /// Returns the minimum element in the sequence, sorted using the `Comparable` value of the given keypath.
   ///
   /// Example:
   /// ```swift
   /// struct Person { let name: String; let age: Int }
   /// let people = [Person(name: "Alice", age: 30), Person(name: "Bob", age: 25)]
   /// let youngest = people.min(byKeyPath: \.age)
   /// // Results in Person(name: "Bob", age: 25)
   /// ```
   ///
   /// - Parameter keyPath: A keypath that specifies the property to compare.
   /// - Returns: The minimum element in the sequence, or `nil` if the sequence is empty.
   public func min(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> Self.Element? {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }.first
   }
}

extension Sequence {
   /// Returns the number of elements in the sequence that satisfy the given predicate.
   ///
   /// You can use this method to count the number of elements that pass a test.
   /// For example, this code finds the number of names that are fewer than
   /// five characters long:
   ///
   ///     let names = ["Jacqueline", "Ian", "Amy", "Juan", "Soroush", "Tiffany"]
   ///     let shortNameCount = names.count(where: { $0.count < 5 })
   ///     // shortNameCount == 3
   ///
   /// To find the number of times a specific element appears in the sequence,
   /// use the equal-to operator (`==`) in the closure to test for a match.
   ///
   ///     let birds = ["duck", "duck", "duck", "duck", "goose"]
   ///     let duckCount = birds.count(where: { $0 == "duck" })
   ///     // duckCount == 4
   ///
   /// The sequence must be finite.
   ///
   /// - Parameter predicate: A closure that takes each element of the sequence
   ///   as its argument and returns a Boolean value indicating whether
   ///   the element should be included in the count.
   /// - Returns: The number of elements in the sequence that satisfy the given
   ///   predicate.
   public func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
      try self.reduce(into: 0) { count, element in
         if try predicate(element) {
            count += 1
         }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have an Equatable keypath value equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements equal to the provided value.
   public func count<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] == otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have an Equatable keypath value not equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements not equal to the provided value.
   public func count<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] != otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that begins with the specified prefix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefix: The prefix to match.
   /// - Returns: The count of elements with a string keypath value that begins with the specified prefix.
   public func count(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> Int {
      self.count { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that begins with one of the specified prefixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefixes: The prefixes to match against.
   /// - Returns: The count of elements with a string keypath value that begins with one of the specified prefixes.
   public func count(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> Int {
      self.count { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that contains the specified substring.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substring: The substring to search for.
   /// - Returns: The count of elements with a string keypath value that contains the specified substring.
   public func count(where keyPath: KeyPath<Element, String>, contains substring: String) -> Int {
      self.count { $0[keyPath: keyPath].contains(substring) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that contains one of the specified substrings.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substrings: The substrings to search for.
   /// - Returns: The count of elements with a string keypath value that contains one of the specified substrings.
   public func count(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> Int {
      self.count { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that ends with the specified suffix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffix: The suffix to match.
   /// - Returns: The count of elements with a string keypath value that ends with the specified suffix.
   public func count(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> Int {
      self.count { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that ends with one of the specified suffixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffixes: The suffixes to match against.
   /// - Returns: The count of elements with a string keypath value that ends with one of the specified suffixes.
   public func count(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> Int {
      self.count { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have a value greater than the provided value for the given keypath.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements greater than the provided value.
   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] > otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have a value greater than or equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements greater than or equal to the provided value.
   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] >= otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have a value less than the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements less than the provided value.
   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] < otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have a value less than or equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The count of elements less than or equal to the provided value.
   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] <= otherValue }
   }
}

extension Sequence {
   /// Returns an array containing the elements of the sequence that have a keypath value equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose keypath value is equal to the provided value.
   public func filter<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] == otherValue }
   }

   /// Returns an array containing the elements of the sequence that have a keypath value not equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose keypath value is not equal to the provided value.
   public func filter<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] != otherValue }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value prefixed by the specified prefix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefix: The prefix to match.
   /// - Returns: An array of elements whose string keypath value begins with the specified prefix.
   public func filter(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value prefixed by one of the specified prefixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefixes: The prefixes to match against.
   /// - Returns: An array of elements whose string keypath value begins with one of the specified prefixes.
   public func filter(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> [Element] {
      self.filter { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value containing the specified substring.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substring: The substring to search for.
   /// - Returns: An array of elements whose string keypath value contains the specified substring.
   public func filter(where keyPath: KeyPath<Element, String>, contains substring: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].contains(substring) }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value containing one of the specified substrings.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substrings: The substrings to search for.
   /// - Returns: An array of elements whose string keypath value contains one of the specified substrings.
   public func filter(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> [Element] {
      self.filter { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value suffixed by the specified suffix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffix: The suffix to match.
   /// - Returns: An array of elements whose string keypath value ends with the specified suffix.
   public func filter(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   /// Returns an array containing the elements of the sequence that have a string keypath value suffixed by one of the specified suffixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffixes: The suffixes to match against.
   /// - Returns: An array of elements whose string keypath value ends with one of the specified suffixes.
   public func filter(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> [Element] {
      self.filter { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   /// Returns an array containing the elements of the sequence that have a keypath value greater than the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose keypath value is greater than the provided value.
   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] > otherValue }
   }

   /// Returns an array containing the elements of the sequence that have a keypath value greater than or equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose keypath value is greater than or equal to the provided value.
   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] >= otherValue }
   }

   /// Returns an array containing the elements of the sequence that have a keypath value less than the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose keypath value is less than the provided value.
   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] < otherValue }
   }

   /// Returns an array containing the elements of the sequence that have a value less than or equal to the specified value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: An array of elements whose value, specified by the keypath, is less than or equal to the provided value.
   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] <= otherValue }
   }
}

extension Sequence {
   /// Returns the first element in the sequence that satisfies the given predicate.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence that matches the given value, or `nil` if no elements match.
   public func first<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] == otherValue }
   }

   /// Returns the first element in the sequence that does not satisfy the given predicate.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence that does not match the given value, or `nil` if all elements match.
   public func first<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] != otherValue }
   }

   /// Returns the first element in the sequence that has a string keypath value prefixed by the specified prefix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefix: The prefix to search for.
   /// - Returns: The first element in the sequence with a string keypath value that begins with the specified prefix, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> Element? {
      self.first { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   /// Returns the first element in the sequence that has a string keypath value prefixed by one of the specified prefixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - prefixes: The prefixes to search for.
   /// - Returns: The first element in the sequence with a string keypath value that begins with one of the specified prefixes, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> Element? {
      self.first { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   /// Returns the first element in the sequence that has a string keypath value containing the specified substring.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substring: The substring to search for.
   /// - Returns: The first element in the sequence with a string keypath value that contains the specified substring, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, contains substring: String) -> Element? {
      self.first { $0[keyPath: keyPath].contains(substring) }
   }

   /// Returns the first element in the sequence that has a string keypath value containing one of the specified substrings.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - substrings: The substrings to search for.
   /// - Returns: The first element in the sequence with a string keypath value that contains one of the specified substrings, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> Element? {
      self.first { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   /// Returns the first element in the sequence that has a string keypath value suffixed by the specified suffix.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffix: The suffix to search for.
   /// - Returns: The first element in the sequence with a string keypath value that ends with the specified suffix, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> Element? {
      self.first { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   /// Returns the first element in the sequence that has a string keypath value suffixed by one of the specified suffixes.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - suffixes: The suffixes to search for.
   /// - Returns: The first element in the sequence with a string keypath value that ends with one of the specified suffixes, or `nil` if no such element is found.
   public func first(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> Element? {
      self.first { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   /// Returns the first element in the sequence that satisfies the given comparison condition.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence that matches the given comparison condition, or `nil` if no such element is found.
   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] > otherValue }
   }

   /// Returns the first element in the sequence that satisfies the given comparison condition.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence that matches the given comparison condition, or `nil` if no such element is found.
   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] >= otherValue }
   }

   /// Returns the first element in the sequence that satisfies the given comparison condition.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence that matches the given comparison condition, or `nil` if no such element is found.
   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] < otherValue }
   }

   /// Returns the first element in the sequence where the value of the specified keypath is less than or equal to the provided value.
   ///
   /// - Parameters:
   ///   - keyPath: A keypath that specifies the property to compare.
   ///   - otherValue: The value to compare against.
   /// - Returns: The first element in the sequence where the value of the specified keypath is less than or equal to the provided value, or `nil` if no such element is found.
   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] <= otherValue }
   }
}

extension Sequence where Element == String {
   /// Returns the number of elements in the sequence with a string value that begins with the specified prefix.
   ///
   /// - Parameter prefix: The prefix to match.
   /// - Returns: The count of elements with a string value that begins with the specified prefix.
   public func count(prefixedBy prefix: String) -> Int {
      self.count { $0.hasPrefix(prefix) }
   }

   /// Returns the number of elements in the sequence with a string value that ends with the specified suffix.
   ///
   /// - Parameter suffix: The suffix to match.
   /// - Returns: The count of elements with a string value that ends with the specified suffix.
   public func count(suffixedBy suffix: String) -> Int {
      self.count { $0.hasSuffix(suffix) }
   }

   /// Returns the number of elements in the sequence with a string value that contains the specified substring.
   ///
   /// - Parameter substring: The substring to search for.
   /// - Returns: The count of elements with a string value that contains the specified substring.
   public func count(contains substring: String) -> Int {
      self.count { $0.contains(substring) }
   }

   /// Returns the number of elements in the sequence with a string value that begins with one of the specified prefixes.
   ///
   /// - Parameter prefixes: The prefixes to match against.
   /// - Returns: The count of elements with a string value that begins with one of the specified prefixes.
   public func count(prefixedByOneOf prefixes: [String]) -> Int {
      self.count { string in
         prefixes.contains { string.hasPrefix($0) }
      }
   }

   /// Returns the number of elements in the sequence with a string value that ends with one of the specified suffixes.
   ///
   /// - Parameter suffixes: The suffixes to match against.
   /// - Returns: The count of elements with a string value that ends with one of the specified suffixes.
   public func count(suffixedByOneOf suffixes: [String]) -> Int {
      self.count { string in
         suffixes.contains { string.hasSuffix($0) }
      }
   }

   /// Returns the number of elements in the sequence with a string value that contains one of the specified substrings.
   ///
   /// - Parameter substrings: The substrings to search for.
   /// - Returns: The count of elements with a string value that contains one of the specified substrings.
   public func count(containsOneOf substrings: [String]) -> Int {
      self.count { string in
         substrings.contains { string.contains($0) }
      }
   }

   /// Returns an array containing the elements of the sequence with a string value that begins with the specified prefix.
   ///
   /// - Parameter prefix: The prefix to match.
   /// - Returns: An array containing the elements with a string value that begins with the specified prefix.
   public func filter(prefixedBy prefix: String) -> [Element] {
      self.filter { $0.hasPrefix(prefix) }
   }

   /// Returns an array containing the elements of the sequence with a string value that ends with the specified suffix.
   ///
   /// - Parameter suffix: The suffix to match.
   /// - Returns: An array containing the elements with a string value that ends with the specified suffix.
   public func filter(suffixedBy suffix: String) -> [Element] {
      self.filter { $0.hasSuffix(suffix) }
   }

   /// Returns an array containing the elements of the sequence with a string value that contains the specified substring.
   ///
   /// - Parameter substring: The substring to search for.
   /// - Returns: An array containing the elements with a string value that contains the specified substring.
   public func filter(contains substring: String) -> [Element] {
      self.filter { $0.contains(substring) }
   }

   /// Returns an array containing the elements of the sequence with a string value that begins with one of the specified prefixes.
   ///
   /// - Parameter prefixes: The prefixes to match against.
   /// - Returns: An array containing the elements with a string value that begins with one of the specified prefixes.
   public func filter(prefixedByOneOf prefixes: [String]) -> [Element] {
      self.filter { string in
         prefixes.contains { string.hasPrefix($0) }
      }
   }

   /// Returns an array containing the elements of the sequence with a string value that ends with one of the specified suffixes.
   ///
   /// - Parameter suffixes: The suffixes to match against.
   /// - Returns: An array containing the elements with a string value that ends with one of the specified suffixes.
   public func filter(suffixedByOneOf suffixes: [String]) -> [Element] {
      self.filter { string in
         suffixes.contains { string.hasSuffix($0) }
      }
   }

   /// Returns an array containing the elements of the sequence with a string value that contains one of the specified substrings.
   ///
   /// - Parameter substrings: The substrings to search for.
   /// - Returns: An array containing the elements with a string value that contains one of the specified substrings.
   public func filter(containsOneOf substrings: [String]) -> [Element] {
      self.filter { string in
         substrings.contains { string.contains($0) }
      }
   }
}

extension Sequence where Element: Comparable {
   /// Returns the number of elements in the sequence that are greater than the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: The count of elements greater than the specified value.
   public func count(greaterThan otherValue: Element) -> Int {
      self.count { $0 > otherValue }
   }

   /// Returns the number of elements in the sequence that are greater than or equal to the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: The count of elements greater than or equal to the specified value.
   public func count(greaterThanOrEqual otherValue: Element) -> Int {
      self.count { $0 >= otherValue }
   }

   /// Returns the number of elements in the sequence that are less than the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: The count of elements less than the specified value.
   public func count(lessThan otherValue: Element) -> Int {
      self.count { $0 < otherValue }
   }

   /// Returns the number of elements in the sequence that are less than or equal to the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: The count of elements less than or equal to the specified value.
   public func count(lessThanOrEqual otherValue: Element) -> Int {
      self.count { $0 <= otherValue }
   }

   /// Returns an array containing the elements in the sequence that are greater than the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: An array containing the elements greater than the specified value.
   public func filter(greaterThan otherValue: Element) -> [Element] {
      self.filter { $0 > otherValue }
   }

   /// Returns an array containing the elements in the sequence that are greater than or equal to the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: An array containing the elements greater than or equal to the specified value.
   public func filter(greaterThanOrEqual otherValue: Element) -> [Element] {
      self.filter { $0 >= otherValue }
   }

   /// Returns an array containing the elements in the sequence that are less than the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: An array containing the elements less than the specified value.
   public func filter(lessThan otherValue: Element) -> [Element] {
      self.filter { $0 < otherValue }
   }

   /// Returns an array containing the elements in the sequence that are less than or equal to the specified value.
   ///
   /// - Parameter otherValue: The value to compare against.
   /// - Returns: An array containing the elements less than or equal to the specified value.
   public func filter(lessThanOrEqual otherValue: Element) -> [Element] {
      self.filter { $0 <= otherValue }
   }
}

extension Sequence where Element: AdditiveArithmetic {
   /// Returns the sum of all elements.
   ///
   /// - Returns: The sum of all elements in the sequence.
   ///
   /// Example:
   /// ```swift
   /// let numbers = [1, 2, 3, 4, 5]
   /// let totalSum = numbers.sum() // Result: 15
   /// ```
   @inlinable
   public func sum() -> Element {
      reduce(.zero, +)
   }
}

extension Sequence {
   /// Returns the sum of all elements mapped to a numeric value.
   ///
   /// - Parameter mapToNumeric: A closure that maps each element to a numeric value.
   /// - Returns: The sum of all elements after mapping to a numeric value.
   ///
   /// Example:
   /// ```swift
   /// let words = ["apple", "banana", "orange"]
   /// let totalStringLength = words.sum(\.count) // Result: 16
   /// ```
   @inlinable
   public func sum<T: AdditiveArithmetic>(mapToNumeric: (Element) -> T) -> T {
      self.reduce(into: .zero) { $0 += mapToNumeric($1) }
   }
}
