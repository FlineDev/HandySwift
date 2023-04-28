import Foundation

extension Float {
  /// Rounds the value to an integral value using the specified fraction digits and rounding rule.
  ///
  /// - NOTE: Dropping the `rule` parameter will default to “schoolbook rounding”.
  public mutating func round(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) {
    let divisor = pow(10.0, Float(fractionDigits))
    self = (self * divisor).rounded(rule) / divisor
  }

  /// Returns this value rounded to an integral value using the specified fraction digits and rounding rule.
  ///
  /// - NOTE: Dropping the `rule` parameter will default to “schoolbook rounding”.
  public func rounded(fractionDigits: Int, rule: FloatingPointRoundingRule = .toNearestOrAwayFromZero) -> Float {
    let divisor = pow(10.0, Float(fractionDigits))
    return (self * divisor).rounded(rule) / divisor
  }
}
