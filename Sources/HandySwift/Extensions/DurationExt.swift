import Foundation

@available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
extension Duration {
   /// Returns the duration as a `TimeInterval`.
   ///
   /// This can be useful for interfacing with APIs that require `TimeInterval` (which is measured in seconds), allowing you to convert a `Duration` directly to the needed format.
   ///
   /// Example:
   /// ```swift
   /// let duration = Duration.hours(2)
   /// let timeInterval = duration.timeInterval // Converts to TimeInterval for compatibility
   /// ```
   ///
   /// - Returns: The duration as a `TimeInterval`, which represents the duration in seconds.
   public var timeInterval: TimeInterval {
      TimeInterval(self.components.seconds) + (TimeInterval(self.components.attoseconds) / 1_000_000_000_000_000_000)
   }

   /// Constructs a `Duration` given a number of weeks represented as a `BinaryInteger`.
   ///
   /// This method can be particularly useful when working with durations that span several weeks, such as project timelines or subscription periods.
   ///
   /// Example:
   /// ```swift
   /// let threeWeeksDuration = Duration.weeks(3) // Creates a Duration of 3 weeks
   /// ```
   ///
   /// - Parameter weeks: The number of weeks.
   /// - Returns: A `Duration` representing the given number of weeks.
   public static func weeks<T: BinaryInteger>(_ weeks: T) -> Duration {
      self.days(weeks * 7)
   }

   /// Constructs a `Duration` given a number of days represented as a `BinaryInteger`.
   ///
   /// Useful for creating durations for events, reminders, or deadlines that are a specific number of days in the future.
   ///
   /// Example:
   /// ```swift
   /// let tenDaysDuration = Duration.days(10) // Creates a Duration of 10 days
   /// ```
   ///
   /// - Parameter days: The number of days.
   /// - Returns: A `Duration` representing the given number of days.
   public static func days<T: BinaryInteger>(_ days: T) -> Duration {
      self.hours(days * 24)
   }

   /// Constructs a `Duration` given a number of hours represented as a `BinaryInteger`.
   ///
   /// Can be used to schedule events or tasks that are several hours long.
   ///
   /// Example:
   /// ```swift
   /// let eightHoursDuration = Duration.hours(8) // Creates a Duration of 8 hours
   /// ```
   ///
   /// - Parameter hours: The number of hours.
   /// - Returns: A `Duration` representing the given number of hours.
   public static func hours<T: BinaryInteger>(_ hours: T) -> Duration {
      self.minutes(hours * 60)
   }

   /// Constructs a `Duration` given a number of minutes represented as a `BinaryInteger`.
   ///
   /// This is helpful for precise time measurements, such as cooking timers, short breaks, or meeting durations.
   ///
   /// Example:
   /// ```swift
   /// let fifteenMinutesDuration = Duration.minutes(15) // Creates a Duration of 15 minutes
   /// ```
   ///
   /// - Parameter minutes: The number of minutes.
   /// - Returns: A `Duration` representing the given number of minutes.
   public static func minutes<T: BinaryInteger>(_ minutes: T) -> Duration {
      self.seconds(minutes * 60)
   }

   /// Formats the duration to a human-readable string with auto-scaling.
   ///
   /// This function takes a duration and formats it into a string that represents the duration in the largest non-zero unit, scaling from seconds up to days.
   /// The output is dynamically scaled to provide a succinct and easily understandable representation of the duration.
   ///
   /// Examples:
   /// - For a duration of 45 seconds, the output will be `"45s"`.
   /// - For a duration of 150 minutes, the output will be `"2h 30m"` as it scales up from minutes to hours and minutes.
   /// - For a duration of 25 hours, the output will be `"1d 1h"`, scaling up to days and hours.
   /// - For a duration of 2 days and 0 hours, the output will be `"2d"` as it omits the zero hour part.
   ///
   /// - Returns: A formatted string representing the duration. If the duration is less than a second, it returns `"???"`.
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
   /// Multiplies the duration by a given factor. This can be useful when scaling animations or timer intervals proportionally.
   ///
   /// Example:
   /// ```swift
   /// let originalDuration = Duration.seconds(2)
   /// let doubledDuration = originalDuration.multiplied(by: 2) // Doubles the duration to 4 seconds
   /// ```
   ///
   /// - Parameter factor: The multiplication factor.
   /// - Returns: A `Duration` representing the multiplied duration.
   func multiplied(by factor: Double) -> Duration {
      (self.timeInterval * factor).duration()
   }

   /// Multiplies the duration by a given factor, allowing for integer factors. This is convenient for simple multiplications where decimal precision isn't needed.
   ///
   /// Example:
   /// ```swift
   /// let originalDuration = Duration.seconds(3)
   /// let tripledDuration = originalDuration.multiplied(by: 3) // Triples the duration to 9 seconds
   /// ```
   ///
   /// - Parameter factor: The multiplication factor.
   /// - Returns: A `Duration` representing the multiplied duration.
   func multiplied(by factor: Int) -> Duration {
      self.multiplied(by: Double(factor))
   }

   /// Divides the duration by a given denominator, useful for reducing animation durations or calculating partial intervals.
   ///
   /// Example:
   /// ```swift
   /// let originalDuration = Duration.seconds(10)
   /// let halvedDuration = originalDuration.divided(by: 2) // Halves the duration to 5 seconds
   /// ```
   ///
   /// - Parameter denominator: The denominator.
   /// - Returns: A `Duration` representing the divided duration.
   func divided(by denominator: Double) -> Duration {
      (self.timeInterval / denominator).duration()
   }

   /// Divides the duration by a given denominator using an integer value. This method simplifies division when working with whole numbers.
   ///
   /// Example:
   /// ```swift
   /// let originalDuration = Duration.seconds(8)
   /// let quarteredDuration = originalDuration.divided(by: 4) // Divides the duration to 2 seconds
   /// ```
   ///
   /// - Parameter denominator: The denominator.
   /// - Returns: A `Duration` representing the divided duration.
   func divided(by denominator: Int) -> Duration {
      self.divided(by: Double(denominator))
   }

   /// Divides the duration by another duration, returning the ratio of the two. This can be used to compare durations or compute proportions.
   ///
   /// Example:
   /// ```swift
   /// let durationA = Duration.seconds(5)
   /// let durationB = Duration.seconds(2)
   /// let ratio = durationA.divided(by: durationB) // Calculates the ratio, which is 2.5
   /// ```
   ///
   /// - Parameter duration: The duration to divide by.
   /// - Returns: The ratio of the two durations.
   func divided(by duration: Duration) -> Double {
      self.timeInterval / duration.timeInterval
   }
}
