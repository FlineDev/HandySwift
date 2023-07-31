import Foundation

@available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
extension Duration {
   /// - Returns: The Duration as a ``TimeInterval``, which is a ``Double`` representing the duration in seconds.
   public var timeInterval: TimeInterval {
      TimeInterval(self.components.seconds) + (TimeInterval(self.components.attoseconds) / 1_000_000_000_000_000_000)
   }
   
   /// Construct a `Duration` given a number of weeks represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of weeks.
   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public static func weeks<T: BinaryInteger>(_ weeks: T) -> Duration {
      self.days(weeks * 7)
   }
   
   /// Construct a `Duration` given a number of days represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of days.
   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public static func days<T: BinaryInteger>(_ days: T) -> Duration {
      self.hours(days * 24)
   }
   
   /// Construct a `Duration` given a number of hours represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of hours.
   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public static func hours<T: BinaryInteger>(_ hours: T) -> Duration {
      self.minutes(hours * 60)
   }
   
   /// Construct a `Duration` given a number of minutes represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of minutes.
   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public static func minutes<T: BinaryInteger>(_ minutes: T) -> Duration {
      self.seconds(minutes * 60)
   }

   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public func autoscaleFormatted() -> String {
      var leftoverTimeInterval = self.timeInterval
      let fullDays = Int(leftoverTimeInterval.days)

      leftoverTimeInterval -= .days(Double(fullDays))
      let fullHours = Int(leftoverTimeInterval.hours)

      leftoverTimeInterval -= .hours(Double(fullHours))
      let fullMinutes = Int(leftoverTimeInterval.minutes)

      leftoverTimeInterval -= .minutes(Double(fullMinutes))
      let fullSeconds = Int(leftoverTimeInterval.seconds)

      if fullDays > 0 {
         guard fullHours != 0 else { return "\(fullDays)d" }
         return "\(fullDays)d \(fullHours)h"
      } else if fullHours > 0 {
         guard fullMinutes != 0 else { return "\(fullHours)h" }
         return "\(fullHours)h \(fullMinutes)m"
      } else if fullMinutes > 0 {
         guard fullSeconds != 0 else { return "\(fullMinutes)m" }
         return "\(fullMinutes)m \(fullSeconds)s"
      } else if fullSeconds > 0 {
         return "\(fullSeconds)s"
      } else {
         return "???"
      }
   }
}
