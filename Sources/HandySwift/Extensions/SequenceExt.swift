import Foundation

extension Sequence {
   /// Returns the elements of the sequence, sorted using the ``Comparable`` value of the given keypath.
   public func sorted(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> [Self.Element] {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
   }

   /// Returns the maximum element in the sequence, sorted using the ``Comparable`` value of the given keypath.
   public func max(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> Self.Element? {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }.last
   }

   /// Returns the maximum element in the sequence, sorted using the ``Comparable`` value of the given keypath.
   public func min(byKeyPath keyPath: KeyPath<Element, some Comparable>) -> Self.Element? {
      self.sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }.first
   }

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
   public func count<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] == otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have an Equatable keypath value not equal to the provided value.
   public func count<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] != otherValue }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that begins with the specified prefix.
   public func count(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> Int {
      self.count { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that begins with one of the specified prefixes.
   public func count(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> Int {
      self.count { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that contains the specified substring.
   public func count(where keyPath: KeyPath<Element, String>, contains substring: String) -> Int {
      self.count { $0[keyPath: keyPath].contains(substring) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that contains one of the specified substrings.
   public func count(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> Int {
      self.count { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that ends with the specified suffix.
   public func count(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> Int {
      self.count { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   /// Returns an Int value representing how many elements in the sequence have a String keypath value that ends with one of the specified suffixes.
   public func count(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> Int {
      self.count { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] > otherValue }
   }

   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] >= otherValue }
   }

   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] < otherValue }
   }

   public func count<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> Int {
      self.count { $0[keyPath: keyPath] <= otherValue }
   }

   public func filter<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] == otherValue }
   }

   public func filter<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] != otherValue }
   }

   public func filter(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   public func filter(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> [Element] {
      self.filter { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   public func filter(where keyPath: KeyPath<Element, String>, contains substring: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].contains(substring) }
   }

   public func filter(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> [Element] {
      self.filter { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   public func filter(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> [Element] {
      self.filter { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   public func filter(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> [Element] {
      self.filter { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] > otherValue }
   }

   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] >= otherValue }
   }

   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] < otherValue }
   }

   public func filter<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> [Element] {
      self.filter { $0[keyPath: keyPath] <= otherValue }
   }

   public func first<Value: Equatable>(where keyPath: KeyPath<Element, Value>, equalTo otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] == otherValue }
   }

   public func first<Value: Equatable>(where keyPath: KeyPath<Element, Value>, notEqualTo otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] != otherValue }
   }

   public func first(where keyPath: KeyPath<Element, String>, prefixedBy prefix: String) -> Element? {
      self.first { $0[keyPath: keyPath].hasPrefix(prefix) }
   }

   public func first(where keyPath: KeyPath<Element, String>, prefixedByOneOf prefixes: some Sequence<String>) -> Element? {
      self.first { element in
         prefixes.contains { element[keyPath: keyPath].hasPrefix($0) }
      }
   }

   public func first(where keyPath: KeyPath<Element, String>, contains substring: String) -> Element? {
      self.first { $0[keyPath: keyPath].contains(substring) }
   }

   public func first(where keyPath: KeyPath<Element, String>, containsOneOf substrings: [String]) -> Element? {
      self.first { element in
         substrings.contains { element[keyPath: keyPath].contains($0) }
      }
   }

   public func first(where keyPath: KeyPath<Element, String>, suffixedBy suffix: String) -> Element? {
      self.first { $0[keyPath: keyPath].hasSuffix(suffix) }
   }

   public func first(where keyPath: KeyPath<Element, String>, suffixedByOneOf suffixes: [String]) -> Element? {
      self.first { element in
         suffixes.contains { element[keyPath: keyPath].hasSuffix($0) }
      }
   }

   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThan otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] > otherValue }
   }

   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, greaterThanOrEqual otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] >= otherValue }
   }

   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThan otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] < otherValue }
   }

   public func first<Value: Comparable>(where keyPath: KeyPath<Element, Value>, lessThanOrEqual otherValue: Value) -> Element? {
      self.first { $0[keyPath: keyPath] <= otherValue }
   }
}

extension Sequence<String> {
   public func count(prefixedBy prefix: String) -> Int {
      self.count { $0.hasPrefix(prefix) }
   }

   public func count(suffixedBy suffix: String) -> Int {
      self.count { $0.hasSuffix(suffix) }
   }

   public func count(contains substring: String) -> Int {
      self.count { $0.contains(substring) }
   }

   public func count(prefixedByOneOf prefixes: [String]) -> Int {
      self.count { string in
         prefixes.contains { string.hasPrefix($0) }
      }
   }

   public func count(suffixedByOneOf suffixes: [String]) -> Int {
      self.count { string in
         suffixes.contains { string.hasSuffix($0) }
      }
   }

   public func count(containsOneOf substrings: [String]) -> Int {
      self.count { string in
         substrings.contains { string.contains($0) }
      }
   }

   public func filter(prefixedBy prefix: String) -> [Element] {
      self.filter { $0.hasPrefix(prefix) }
   }

   public func filter(suffixedBy suffix: String) -> [Element] {
      self.filter { $0.hasSuffix(suffix) }
   }

   public func filter(contains substring: String) -> [Element] {
      self.filter { $0.contains(substring) }
   }

   public func filter(prefixedByOneOf prefixes: [String]) -> [Element] {
      self.filter { string in
         prefixes.contains { string.hasPrefix($0) }
      }
   }

   public func filter(suffixedByOneOf suffixes: [String]) -> [Element] {
      self.filter { string in
         suffixes.contains { string.hasSuffix($0) }
      }
   }

   public func filter(containsOneOf substrings: [String]) -> [Element] {
      self.filter { string in
         substrings.contains { string.contains($0) }
      }
   }
}

extension Sequence where Element: Comparable {
   public func count(greaterThan otherValue: Element) -> Int {
      self.count { $0 > otherValue }
   }

   public func count(greaterThanOrEqual otherValue: Element) -> Int {
      self.count { $0 >= otherValue }
   }

   public func count(lessThan otherValue: Element) -> Int {
      self.count { $0 < otherValue }
   }

   public func count(lessThanOrEqual otherValue: Element) -> Int {
      self.count { $0 <= otherValue }
   }

   public func filter(greaterThan otherValue: Element) -> [Element] {
      self.filter { $0 > otherValue }
   }

   public func filter(greaterThanOrEqual otherValue: Element) -> [Element] {
      self.filter { $0 >= otherValue }
   }

   public func filter(lessThan otherValue: Element) -> [Element] {
      self.filter { $0 < otherValue }
   }

   public func filter(lessThanOrEqual otherValue: Element) -> [Element] {
      self.filter { $0 <= otherValue }
   }
}
