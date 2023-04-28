import Foundation

extension NSRange {
  /// Initializes an NSRange from a Swift String.Range when the String is provided.
  public init(_ range: Range<String.Index>, in string: String) {
    self.init()
    self.location = string.utf16.distance(from: string.startIndex, to: range.lowerBound)
    self.length = string.utf16.distance(from: range.lowerBound, to: range.upperBound)
  }
}
