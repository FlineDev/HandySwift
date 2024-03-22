import Foundation

extension Comparable {
   /// Returns `self` clamped to the given closed range limits.
   /// This method ensures that the value remains within a specific range.
   /// If the value is outside the range, it's adjusted to the nearest boundary of the range.
   ///
   /// Example:
   /// ```swift
   /// let myNum = 3
   /// let clampedNum = myNum.clamped(to: 0 ... 6) // => 3
   /// let clampedNumBelow = myNum.clamped(to: 0 ... 2) // => 2
   /// let clampedNumAbove = myNum.clamped(to: 4 ... 6) // => 4
   /// ```
   ///
   /// - Parameter limits: The closed range determining the minimum and maximum value.
   /// - Returns:
   ///     - `self`, if it is inside the given limits.
   ///     - `lowerBound` of the given limits, if `self` is smaller than it.
   ///     - `upperBound` of the given limits, if `self` is greater than it.
   @inlinable
   public func clamped(to limits: ClosedRange<Self>) -> Self {
      if limits.lowerBound > self {
         limits.lowerBound
      } else if limits.upperBound < self {
         limits.upperBound
      } else {
         self
      }
   }

   /// Returns `self` clamped to the given partial range (from) limits. This method ensures that the value does not fall below a specified minimum.
   ///
   /// Example:
   /// ```swift
   /// let myNum = 3
   /// let clampedNum = myNum.clamped(to: 5...) // => 5
   /// ```
   ///
   /// - Parameter limits: The partial range (from) determining the minimum value.
   /// - Returns:
   ///     - `self`, if it is inside the given limits.
   ///     - `lowerBound` of the given limits, if `self` is smaller than it.
   @inlinable
   public func clamped(to limits: PartialRangeFrom<Self>) -> Self {
      limits.lowerBound > self ? limits.lowerBound : self
   }

   /// Returns `self` clamped to the given partial range (through) limits. 
   /// This method ensures that the value does not exceed a specified maximum.
   ///
   /// Example:
   /// ```swift
   /// let myNum = 7
   /// let clampedNum = myNum.clamped(to: ...5) // => 5
   /// ```
   ///
   /// - Parameter limits: The partial range (through) determining the maximum value.
   /// - Returns:
   ///     - `self`, if it is inside the given limits.
   ///     - `upperBound` of the given limits, if `self` is greater than it.
   @inlinable
   public func clamped(to limits: PartialRangeThrough<Self>) -> Self {
      limits.upperBound < self ? limits.upperBound : self
   }

   /// Clamps `self` to the given closed range limits. 
   /// Modifies the original value to ensure it falls within a specific range, adjusting it to the nearest boundary if necessary.
   ///
   /// Example:
   /// ```swift
   /// var myNum = 3
   /// myNum.clamp(to: 0...2)
   /// print(myNum) // => 2
   /// ```
   ///
   /// - Parameter limits: The closed range determining minimum and maximum value.
   @inlinable
   public mutating func clamp(to limits: ClosedRange<Self>) {
      self = clamped(to: limits)
   }

   /// Clamps `self` to the given partial range (from) limits. 
   /// Modifies the original value to ensure it does not fall below a specified minimum.
   ///
   /// Example:
   /// ```swift
   /// var myNum = 3
   /// myNum.clamp(to: 5...)
   /// print(myNum) // => 5
   /// ```
   ///
   /// - Parameter limits: The partial range (from) determining the minimum value.
   @inlinable
   public mutating func clamp(to limits: PartialRangeFrom<Self>) {
      self = clamped(to: limits)
   }

   /// Clamps `self` to the given partial range (through) limits. 
   /// Modifies the original value to ensure it does not exceed a specified maximum.
   ///
   /// Example:
   /// ```swift
   /// var myNum = 7
   /// myNum.clamp(to: ...5)
   /// print(myNum) // => 5
   /// ```
   ///
   /// - `self`, if it is inside the given limits.
   /// - `upperBound` of the given limits, if `self` is greater than it.
   ///
   /// - Parameter limits: The partial range (through) determining the maximum value.
   @inlinable
   public mutating func clamp(to limits: PartialRangeThrough<Self>) {
      self = clamped(to: limits)
   }
}
