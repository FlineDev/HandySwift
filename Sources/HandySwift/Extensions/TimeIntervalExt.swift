import Foundation

extension TimeInterval {
   /// The number of seconds in a day.
   @usableFromInline
   internal static var secondsPerDay: Double { 24 * 60 * 60 }

   /// The number of seconds in an hour.
   @usableFromInline
   internal static var secondsPerHour: Double { 60 * 60 }

   /// The number of seconds in a minute.
   @usableFromInline
   internal static var secondsPerMinute: Double { 60 }

   /// The number of milliseconds in a second.
   @usableFromInline
   internal static var millisecondsPerSecond: Double { 1_000 }

   /// The number of microseconds in a second.
   @usableFromInline
   internal static var microsecondsPerSecond: Double { 1_000 * 1_000 }

   /// The number of nanoseconds in a second.
   @usableFromInline
   internal static var nanosecondsPerSecond: Double { 1_000 * 1_000 * 1_000 }

   /// Returns the time interval converted to days.
   ///
   /// - Returns: The `TimeInterval` in days.
   @inlinable
   public var days: Double {
      self / TimeInterval.secondsPerDay
   }

   /// Returns the time interval converted to hours.
   ///
   /// - Returns: The `TimeInterval` in hours.
   @inlinable
   public var hours: Double {
      self / TimeInterval.secondsPerHour
   }

   /// Returns the time interval converted to minutes.
   ///
   /// - Returns: The `TimeInterval` in minutes.
   @inlinable
   public var minutes: Double {
      self / TimeInterval.secondsPerMinute
   }

   /// Returns the time interval as is, representing seconds.
   ///
   /// - Returns: The `TimeInterval` in seconds.
   @inlinable
   public var seconds: Double {
      self
   }

   /// Returns the time interval converted to milliseconds.
   ///
   /// - Returns: The `TimeInterval` in milliseconds.
   @inlinable
   public var milliseconds: Double {
      self * TimeInterval.millisecondsPerSecond
   }

   /// Returns the time interval converted to microseconds.
   ///
   /// - Returns: The `TimeInterval` in microseconds.
   @inlinable
   public var microseconds: Double {
      self * TimeInterval.microsecondsPerSecond
   }

   /// Returns the time interval converted to nanoseconds.
   ///
   /// - Returns: The `TimeInterval` in nanoseconds.
   @inlinable
   public var nanoseconds: Double {
      self * TimeInterval.nanosecondsPerSecond
   }

   /// Converts the provided value to `TimeInterval` representing days.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in days.
   @inlinable
   public static func days(_ value: Double) -> TimeInterval {
      value * secondsPerDay
   }

   /// Converts the provided value to `TimeInterval` representing hours.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in hours.
   @inlinable
   public static func hours(_ value: Double) -> TimeInterval {
      value * secondsPerHour
   }

   /// Converts the provided value to `TimeInterval` representing minutes.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in minutes.
   @inlinable
   public static func minutes(_ value: Double) -> TimeInterval {
      value * secondsPerMinute
   }

   /// Converts the provided value to `TimeInterval` representing seconds.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in seconds.
   @inlinable
   public static func seconds(_ value: Double) -> TimeInterval {
      value
   }

   /// Converts the provided value to `TimeInterval` representing milliseconds.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in milliseconds.
   @inlinable
   public static func milliseconds(_ value: Double) -> TimeInterval {
      value / millisecondsPerSecond
   }

   /// Converts the provided value to `TimeInterval` representing microseconds.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in microseconds.
   @inlinable
   public static func microseconds(_ value: Double) -> TimeInterval {
      value / microsecondsPerSecond
   }

   /// Converts the provided value to `TimeInterval` representing nanoseconds.
   ///
   /// - Parameter value: The value to convert.
   /// - Returns: The time interval in nanoseconds.
   @inlinable
   public static func nanoseconds(_ value: Double) -> TimeInterval {
      value / nanosecondsPerSecond
   }

   /// Returns the `Duration` representation of the current time interval.
   ///
   /// - Returns: The `Duration` representation.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public func duration() -> Duration {
      let fullSeconds = Int64(self.seconds)
      let remainingInterval = self - .seconds(Double(fullSeconds))

      let attosecondsPerNanosecond = Double(1_000 * 1_000 * 1_000)
      let fullAttoseconds = Int64(remainingInterval.nanoseconds / attosecondsPerNanosecond)

      return Duration(secondsComponent: fullSeconds, attosecondsComponent: fullAttoseconds)
   }
}
