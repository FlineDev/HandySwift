import Foundation

extension Double {
   /// Rounds the value to an integral value using the specified number of fraction digits and rounding rule.
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
