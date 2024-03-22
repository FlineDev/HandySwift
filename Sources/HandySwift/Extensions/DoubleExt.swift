import Foundation

extension Double {
   /// Rounds the value to an integral value using the specified number of fraction digits and rounding rule. 
   /// This is useful for when you need precise control over the rounding behavior of floating-point calculations,
   /// such as in financial calculations where rounding to a specific number of decimal places is required.
   ///
   /// Example:
   /// ```swift
   /// var price: Double = 2.875
   /// price.round(fractionDigits: 2) // price becomes 2.88
   /// 
   /// // Using a different rounding rule:
   /// price.round(fractionDigits: 2, rule: .down) // price becomes 2.87
   /// ```
   ///
   /// - Parameters:
   ///   - fractionDigits: The number of fraction digits to round to.
   ///   - rule: The rounding rule to apply. Default is `.toNearestOrAwayFromZero`.
   ///
   /// - Note: Dropping the `rule` parameter will default to “schoolbook rounding”.
   public mutating func round(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
      let divisor = pow(10.0, Double(fractionDigits))
      self = (self * divisor).rounded(rule) / divisor
   }

   /// Returns this value rounded to an integral value using the specified number of fraction digits and rounding rule. 
   /// This method does not mutate the original value but instead returns a new `Double` that is the result of the rounding operation,
   /// making it suitable for cases where the original value must remain unchanged.
   ///
   /// Example:
   /// ```swift
   /// let price: Double = 2.875
   /// let roundedPrice = price.rounded(fractionDigits: 2) // => 2.88
   /// 
   /// // Using a different rounding rule:
   /// let roundedDownPrice = price.rounded(fractionDigits: 2, rule: .down) // => 2.87
   /// ```
   ///
   /// - Parameters:
   ///   - fractionDigits: The number of fraction digits to round to.
   ///   - rule: The rounding rule to apply. Default is `.toNearestOrAwayFromZero`.
   ///
   /// - Note: Dropping the `rule` parameter will default to “schoolbook rounding”.
   ///
   /// - Returns: The rounded value.
   public func rounded(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Double {
      let divisor = pow(10.0, Double(fractionDigits))
      return (self * divisor).rounded(rule) / divisor
   }
}
