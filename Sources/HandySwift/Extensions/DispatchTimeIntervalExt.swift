import Foundation

extension DispatchTimeInterval {
   /// Converts the dispatch time interval to seconds using the `TimeInterval` type. 
   /// This is useful for when you need to work with `DispatchTimeInterval` values in contexts that require `TimeInterval` (in seconds),
   /// such as scheduling timers, animations, or any operations that are based on seconds.
   ///
   /// Example:
   /// ```swift
   /// let delay = DispatchTimeInterval.seconds(5)
   /// Timer.scheduledTimer(withTimeInterval: delay.timeInterval, repeats: false) { _ in
   ///     print("Timer fired after 5 seconds.")
   /// }
   /// ```
   ///
   /// - Returns: The time interval in seconds. For `.never`, returns `TimeInterval.infinity` to represent an indefinite time interval.
   public var timeInterval: TimeInterval {
      switch self {
      case let .seconds(seconds):
         Double(seconds)

      case let .milliseconds(milliseconds):
         Double(milliseconds) / TimeInterval.millisecondsPerSecond

      case let .microseconds(microseconds):
         Double(microseconds) / TimeInterval.microsecondsPerSecond

      case let .nanoseconds(nanoseconds):
         Double(nanoseconds) / TimeInterval.nanosecondsPerSecond

      case .never:
         TimeInterval.infinity

      @unknown default:
         fatalError("Unknown DispatchTimeInterval unit.")
      }
   }
}
