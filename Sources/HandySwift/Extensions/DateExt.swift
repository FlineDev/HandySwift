import Foundation

extension Date {
   /// Returns a date offset by the specified time interval from this date to the past. 
   /// This method is useful when you need to calculate a date that occurred a certain duration before the current date instance.
   /// For example, if you want to find out what the date was 2 hours ago from a given date, you can use this method by passing the time interval for 2 hours in seconds.
   ///
   /// Example:
   /// ```swift
   /// let now = Date()
   /// let twoHoursInSeconds: TimeInterval = 2 * 60 * 60
   /// let twoHoursAgo = now.reversed(by: twoHoursInSeconds)
   /// print("Two hours ago: \(twoHoursAgo)")
   /// ```
   ///
   /// - Parameter interval: The time interval offset to subtract from this date.
   /// - Returns: A date offset by subtracting the specified time interval from this date.
   @available(iOS 13, macOS 10.15, tvOS 13, visionOS 1, watchOS 6, *)
   public func reversed(by interval: TimeInterval) -> Date {
      self.advanced(by: -interval)
   }
}
