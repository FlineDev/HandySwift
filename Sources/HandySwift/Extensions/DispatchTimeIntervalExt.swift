import Foundation

extension DispatchTimeInterval {
   /// Converts the dispatch time interval to seconds using the `TimeInterval` type.
   ///
   /// - Returns: The time interval in seconds.
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
