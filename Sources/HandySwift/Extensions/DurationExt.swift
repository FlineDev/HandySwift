import Foundation

@available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
extension Duration {
   /// Returns the duration as a `TimeInterval`.
   ///
   /// - Returns: The duration as a `TimeInterval`, which represents the duration in seconds.
   public var timeInterval: TimeInterval {
      TimeInterval(self.components.seconds) + (TimeInterval(self.components.attoseconds) / 1_000_000_000_000_000_000)
   }

   /// Constructs a `Duration` given a number of weeks represented as a `BinaryInteger`.
   ///
   /// - Parameter weeks: The number of weeks.
   /// - Returns: A `Duration` representing the given number of weeks.
   public static func weeks<T: BinaryInteger>(_ weeks: T) -> Duration {
      self.days(weeks * 7)
   }

   /// Constructs a `Duration` given a number of days represented as a `BinaryInteger`.
   ///
   /// - Parameter days: The number of days.
   /// - Returns: A `Duration` representing the given number of days.
   public static func days<T: BinaryInteger>(_ days: T) -> Duration {
      self.hours(days * 24)
   }

   /// Constructs a `Duration` given a number of hours represented as a `BinaryInteger`.
   ///
   /// - Parameter hours: The number of hours.
   /// - Returns: A `Duration` representing the given number of hours.
   public static func hours<T: BinaryInteger>(_ hours: T) -> Duration {
      self.minutes(hours * 60)
   }

   /// Constructs a `Duration` given a number of minutes represented as a `BinaryInteger`.
   ///
   /// - Parameter minutes: The number of minutes.
   /// - Returns: A `Duration` representing the given number of minutes.
   public static func minutes<T: BinaryInteger>(_ minutes: T) -> Duration {
      self.seconds(minutes * 60)
   }

   /// Formats the duration to a human-readable string with auto-scaling.
   ///
   /// - Returns: A formatted string representing the duration.
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
   /// Multiplies the duration by a given factor.
   ///
   /// - Parameter factor: The multiplication factor.
   /// - Returns: A `Duration` representing the multiplied duration.
   func multiplied(by factor: Double) -> Duration {
      (self.timeInterval * factor).duration()
   }

   /// Multiplies the duration by a given factor.
   ///
   /// - Parameter factor: The multiplication factor.
   /// - Returns: A `Duration` representing the multiplied duration.
   func multiplied(by factor: Int) -> Duration {
      self.multiplied(by: Double(factor))
   }

   /// Divides the duration by a given denominator.
   ///
   /// - Parameter denominator: The denominator.
   /// - Returns: A `Duration` representing the divided duration.
   func divided(by denominator: Double) -> Duration {
      (self.timeInterval / denominator).duration()
   }

   /// Divides the duration by a given denominator.
   ///
   /// - Parameter denominator: The denominator.
   /// - Returns: A `Duration` representing the divided duration.
   func divided(by denominator: Int) -> Duration {
      self.divided(by: Double(denominator))
   }

   /// Divides the duration by another duration.
   ///
   /// - Parameter duration: The duration to divide by.
   /// - Returns: The ratio of the two durations.
   func divided(by duration: Duration) -> Double {
      self.timeInterval / duration.timeInterval
   }
}
