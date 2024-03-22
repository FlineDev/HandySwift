import Foundation

extension NSRange {
   /// Initializes an NSRange from a Swift String.Range when the String is provided. 
   /// This is useful for operations that require NSRange, such as string manipulation with `NSRegularExpression`, or when working with UIKit components that deal with attributed strings.
   ///
   /// Example:
   /// ```swift
   /// let string = "Hello World!"
   /// let swiftRange = string.startIndex..<string.index(string.startIndex, offsetBy: 5)
   /// let nsRange = NSRange(swiftRange, in: string)
   /// // Now `nsRange` can be used with APIs expecting an NSRange, for example:
   /// // NSAttributedString, NSRegularExpression, etc.
   /// ```
   ///
   /// - Parameters:
   ///   - range: The Swift Range representing the substring.
   ///   - string: The String from which the range is extracted.
   public init(_ range: Range<String.Index>, in string: String) {
      self.init()
      self.location = string.utf16.distance(from: string.startIndex, to: range.lowerBound)
      self.length = string.utf16.distance(from: range.lowerBound, to: range.upperBound)
   }
}
