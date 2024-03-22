import Foundation

extension Float {
   /// Rounds the value to an integral value using the specified number of fraction digits and rounding rule. 
   /// This is useful for when you need precise control over the formatting of floating-point numbers,
   /// for example, when displaying currency or other numerical calculations that require a specific number of decimal places.
   ///
   /// Example:
   /// ```swift
   /// var price: Float = 2.875
   /// price.round(fractionDigits: 2) // => 2.88
   /// 
   /// // Using a specific rounding rule:
   /// price.round(fractionDigits: 2, rule: .down) // => 2.87
   /// ```
   ///
   /// - Parameters:
   ///   - fractionDigits: The number of fraction digits to round to.
   ///   - rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
   ///
   /// - Note: Dropping the `rule` parameter will default to “schoolbook rounding”.
   public mutating func round(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      let divisor = pow(10.0, Float(fractionDigits))
      self = (self * divisor).rounded(rule) / divisor
   }

   /// Returns this value rounded to an integral value using the specified number of fraction digits and rounding rule. 
   /// Similar to `round`, but this method does not modify the original value and instead returns a new `Float` with the rounded value.
   /// This is particularly handy in functional programming paradigms where immutability is preferred.
   ///
   /// Example:
   /// ```swift
   /// let originalPrice: Float = 2.875
   /// let roundedPrice = originalPrice.rounded(fractionDigits: 2) // => 2.88
   /// 
   /// // With explicit rounding rule:
   /// let roundedDownPrice = originalPrice.rounded(fractionDigits: 2, rule: .down) // => 2.87
   /// ```
   ///
   /// - Parameters:
   ///   - fractionDigits: The number of fraction digits to round to.
   ///   - rule: The rounding rule to use. Defaults to `.toNearestOrAwayFromZero`.
   ///
   /// - Note: Dropping the `rule` parameter will default to “schoolbook rounding”.
   public func rounded(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Float {
      let divisor = pow(10.0, Float(fractionDigits))
      return (self * divisor).rounded(rule) / divisor
   }
}
