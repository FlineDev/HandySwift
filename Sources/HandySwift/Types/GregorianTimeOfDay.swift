import Foundation

/// A time without date info.
///
/// `GregorianTimeOfDay` represents a time of day without any associated date information. It provides functionalities to work with time components like hour, minute, and second, and perform operations such as initializing from a given date, calculating durations, advancing, and reversing time.
///
/// Example:
/// ```swift
/// // Initializing from a given date
/// let date = Date()
/// let timeOfDay = GregorianTimeOfDay(date: date)
///
/// // Calculating duration since the start of the day
/// let durationSinceStartOfDay: Duration = timeOfDay.durationSinceStartOfDay
/// let timeIntervalSinceStartOfDay: TimeInterval = durationSinceStartOfDay.timeInterval
///
/// // Advancing time by a duration
/// let advancedTime = timeOfDay.advanced(by: .hours(2) + .minutes(30))
///
/// // Reversing time by a duration
/// let reversedTime = timeOfDay.reversed(by: .minutes(15))
/// ```
public struct GregorianTimeOfDay {
   /// The number of days beyond the current day.
   public var overflowingDays: Int
   /// The hour component of the time.
   public var hour: Int
   /// The minute component of the time.
   public var minute: Int
   /// The second component of the time.
   public var second: Int

   /// Initializes a `GregorianTimeOfDay` instance from a given date.
   ///
   /// - Parameter date: The date from which to extract time components.
   public init(date: Date) {
      let components = Calendar(identifier: .gregorian).dateComponents([.hour, .minute, .second], from: date)
      self.overflowingDays = 0
      self.hour = components.hour!
      self.minute = components.minute!
      self.second = components.second!
   }

   /// Initializes a `GregorianTimeOfDay` instance with the provided time components.
   ///
   /// - Parameters:
   ///   - hour: The hour component.
   ///   - minute: The minute component.
   ///   - second: The second component (default is 0).
   public init(hour: Int, minute: Int, second: Int = 0) {
      assert(hour >= 0 && hour < 24)
      assert(minute >= 0 && minute < 60)
      assert(second >= 0 && second < 60)

      self.overflowingDays = 0
      self.hour = hour
      self.minute = minute
      self.second = second
   }

   /// Returns a `Date` object representing the time on a given day.
   ///
   /// - Parameters:
   ///   - day: The day to which the time belongs.
   ///   - timeZone: The time zone to use for the conversion (default is the current time zone).
   /// - Returns: A `Date` object representing the time.
   public func date(day: GregorianDay, timeZone: TimeZone = Calendar.current.timeZone) -> Date {
      let components = DateComponents(
         calendar: Calendar(identifier: .gregorian),
         timeZone: timeZone,
         year: day.year,
         month: day.month,
         day: day.day,
         hour: self.hour,
         minute: self.minute,
         second: self.second
      )
      return components.date!.addingTimeInterval(.days(Double(self.overflowingDays)))
   }

   /// Initializes a `GregorianTimeOfDay` instance from the duration since the start of the day.
   ///
   /// - Parameter durationSinceStartOfDay: The duration since the start of the day.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public init(durationSinceStartOfDay: Duration) {
      self.overflowingDays = Int(durationSinceStartOfDay.timeInterval.days)
      self.hour = Int((durationSinceStartOfDay - .days(self.overflowingDays)).timeInterval.hours)
      self.minute = Int((durationSinceStartOfDay - .days(self.overflowingDays) - .hours(self.hour)).timeInterval.minutes)
      self.second = Int((durationSinceStartOfDay - .days(self.overflowingDays) - .hours(self.hour) - .minutes(self.minute)).timeInterval.seconds)
   }

   /// Returns the duration since the start of the day.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public var durationSinceStartOfDay: Duration {
      .days(self.overflowingDays) + .hours(self.hour) + .minutes(self.minute) + .seconds(self.second)
   }

   /// Advances the time by the specified duration.
   ///
   /// - Parameter duration: The duration by which to advance the time.
   /// - Returns: A new `GregorianTimeOfDay` instance advanced by the specified duration.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public func advanced(by duration: Duration) -> Self {
      GregorianTimeOfDay(durationSinceStartOfDay: self.durationSinceStartOfDay + duration)
   }

   /// Reverses the time by the specified duration.
   ///
   /// - Parameter duration: The duration by which to reverse the time.
   /// - Returns: A new `GregorianTimeOfDay` instance reversed by the specified duration.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public func reversed(by duration: Duration) -> Self {
      GregorianTimeOfDay(durationSinceStartOfDay: self.durationSinceStartOfDay - duration)
   }
}

extension GregorianTimeOfDay: Codable, Hashable, Sendable {}
extension GregorianTimeOfDay: Identifiable {
   /// The unique identifier of the time, formatted as "hour:minute:second".
   public var id: String { "\(self.hour):\(self.minute):\(self.second)" }
}

extension GregorianTimeOfDay: Comparable {
   /// Compares two `GregorianTimeOfDay` instances.
   ///
   /// - Parameters:
   ///   - left: The left-hand side of the comparison.
   ///   - right: The right-hand side of the comparison.
   /// - Returns: `true` if the left time is less than the right time; otherwise, `false`.
   public static func < (left: GregorianTimeOfDay, right: GregorianTimeOfDay) -> Bool {
      guard left.overflowingDays == right.overflowingDays else { return left.overflowingDays < right.overflowingDays }
      guard left.hour == right.hour else { return left.hour < right.hour }
      guard left.minute == right.minute else { return left.minute < right.minute }
      return left.second < right.second
   }
}

extension GregorianTimeOfDay {
   /// The zero time of day (00:00:00).
   public static var zero: Self { GregorianTimeOfDay(hour: 0, minute: 0, second: 0) }
   /// The current time of day.
   public static var now: Self { GregorianTimeOfDay(date: Date()) }
}

extension GregorianTimeOfDay: Withable {}
