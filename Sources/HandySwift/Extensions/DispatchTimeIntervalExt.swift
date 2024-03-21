import Foundation

extension DispatchTimeInterval {
   /// - Returns: The time in seconds using the`TimeInterval` type.
   public var timeInterval: TimeInterval {
      switch self {
      case let .seconds(seconds):
         return Double(seconds)
         
      case let .milliseconds(milliseconds):
         return Double(milliseconds) / TimeInterval.millisecondsPerSecond
         
      case let .microseconds(microseconds):
         return Double(microseconds) / TimeInterval.microsecondsPerSecond
         
      case let .nanoseconds(nanoseconds):
         return Double(nanoseconds) / TimeInterval.nanosecondsPerSecond
         
      case .never:
         return TimeInterval.infinity
         
      @unknown default:
         fatalError("Unknown DispatchTimeInterval unit.")
      }
   }
}
