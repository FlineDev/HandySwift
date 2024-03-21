import Foundation

@available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
extension Duration {
   /// - Returns: The Duration as a ``TimeInterval``, which is a ``Double`` representing the duration in seconds.
   public var timeInterval: TimeInterval {
      TimeInterval(self.components.seconds) + (TimeInterval(self.components.attoseconds) / 1_000_000_000_000_000_000)
   }
   
   /// Construct a `Duration` given a number of weeks represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of weeks.
   public static func weeks<T: BinaryInteger>(_ weeks: T) -> Duration {
      self.days(weeks * 7)
   }
   
   /// Construct a `Duration` given a number of days represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of days.
   public static func days<T: BinaryInteger>(_ days: T) -> Duration {
      self.hours(days * 24)
   }
   
   /// Construct a `Duration` given a number of hours represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of hours.
   public static func hours<T: BinaryInteger>(_ hours: T) -> Duration {
      self.minutes(hours * 60)
   }
   
   /// Construct a `Duration` given a number of minutes represented as a`BinaryInteger`.
   /// - Returns: A `Duration` representing a given number of minutes.
   public static func minutes<T: BinaryInteger>(_ minutes: T) -> Duration {
      self.seconds(minutes * 60)
   }

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

@available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
extension Duration {
   func multiplied(by factor: Double) -> Duration {
      (self.timeInterval * factor).duration()
   }

   func multiplied(by factor: Int) -> Duration {
      self.multiplied(by: Double(factor))
   }

   func divided(by denominator: Double) -> Duration {
      (self.timeInterval / denominator).duration()
   }

   func divided(by denominator: Int) -> Duration {
      self.divided(by: Double(denominator))
   }

   func divided(by duration: Duration) -> Double {
      self.timeInterval / duration.timeInterval
   }
}
