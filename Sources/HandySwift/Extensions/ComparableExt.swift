import Foundation

extension Comparable {
   /// Returns `self` clamped to the given closed range limits.
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

   /// Returns `self` clamped to the given partial range (from) limits.
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
   ///
   /// - `self`, if it is inside the given limits.
   /// - `lowerBound` of the given limits, if `self` is smaller than it.
   /// - `upperBound` of the given limits, if `self` is greater than it.
   ///
   /// - Parameter limits: The closed range determining minimum and maximum value.
   @inlinable
   public mutating func clamp(to limits: ClosedRange<Self>) {
      self = clamped(to: limits)
   }

   /// Clamps `self` to the given partial range (from) limits.
   ///
   /// - `self`, if it is inside the given limits.
   /// - `lowerBound` of the given limits, if `self` is smaller than it.
   ///
   /// - Parameter limits: The partial range (from) determining the minimum value.
   @inlinable
   public mutating func clamp(to limits: PartialRangeFrom<Self>) {
      self = clamped(to: limits)
   }

   /// Clamps `self` to the given partial range (through) limits.
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
