import Foundation

extension Date {
   /// Returns a date offset the specified time interval from this date to the past.
   /// - Parameter interval: The time interval offset.
   /// - Returns: A date offset the specified time interval from this date to the past.
   @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
   public func reversed(by interval: TimeInterval) -> Date {
      self.advanced(by: -interval)
   }
}
