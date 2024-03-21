import Foundation

extension TimeInterval {
   @usableFromInline
   internal static var secondsPerDay: Double { 24 * 60 * 60 }
   
   @usableFromInline
   internal static var secondsPerHour: Double { 60 * 60 }
   
   @usableFromInline
   internal static var secondsPerMinute: Double { 60 }
   
   @usableFromInline
   internal static var millisecondsPerSecond: Double { 1_000 }
   
   @usableFromInline
   internal static var microsecondsPerSecond: Double { 1_000 * 1_000 }
   
   @usableFromInline
   internal static var nanosecondsPerSecond: Double { 1_000 * 1_000 * 1_000 }

   /// - Returns: The `TimeInterval` in days.
   @inlinable
   public var days: Double {
      self / TimeInterval.secondsPerDay
   }
   
   /// - Returns: The `TimeInterval` in hours.
   @inlinable
   public var hours: Double {
      self / TimeInterval.secondsPerHour
   }
   
   /// - Returns: The `TimeInterval` in minutes.
   @inlinable
   public var minutes: Double {
      self / TimeInterval.secondsPerMinute
   }
   
   /// - Returns: The `TimeInterval` in seconds.
   @inlinable
   public var seconds: Double {
      self
   }
   
   /// - Returns: The `TimeInterval` in milliseconds.
   @inlinable
   public var milliseconds: Double {
      self * TimeInterval.millisecondsPerSecond
   }
   
   /// - Returns: The `TimeInterval` in microseconds.
   @inlinable
   public var microseconds: Double {
      self * TimeInterval.microsecondsPerSecond
   }
   
   /// - Returns: The `TimeInterval` in nanoseconds.
   @inlinable
   public var nanoseconds: Double {
      self * TimeInterval.nanosecondsPerSecond
   }
   
   /// - Returns: The time in days using the `TimeInterval` type.
   @inlinable
   public static func days(_ value: Double) -> TimeInterval {
      value * secondsPerDay
   }
   
   /// - Returns: The time in hours using the `TimeInterval` type.
   @inlinable
   public static func hours(_ value: Double) -> TimeInterval {
      value * secondsPerHour
   }
   
   /// - Returns: The time in minutes using the `TimeInterval` type.
   @inlinable
   public static func minutes(_ value: Double) -> TimeInterval {
      value * secondsPerMinute
   }
   
   /// - Returns: The time in seconds using the `TimeInterval` type.
   @inlinable
   public static func seconds(_ value: Double) -> TimeInterval {
      value
   }
   
   /// - Returns: The time in milliseconds using the `TimeInterval` type.
   @inlinable
   public static func milliseconds(_ value: Double) -> TimeInterval {
      value / millisecondsPerSecond
   }
   
   /// - Returns: The time in microseconds using the `TimeInterval` type.
   @inlinable
   public static func microseconds(_ value: Double) -> TimeInterval {
      value / microsecondsPerSecond
   }
   
   /// - Returns: The time in nanoseconds using the `TimeInterval` type.
   @inlinable
   public static func nanoseconds(_ value: Double) -> TimeInterval {
      value / nanosecondsPerSecond
   }

   /// - Returns: The ``Duration`` representation of the current time interval.
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public func duration() -> Duration {
      let fullSeconds = Int64(self.seconds)
      let remainingInterval = self - .seconds(Double(fullSeconds))

      let attosecondsPerNanosecond = Double(1_000 * 1_000 * 1_000)
      let fullAttoseconds = Int64(remainingInterval.nanoseconds / attosecondsPerNanosecond)

      return Duration(secondsComponent: fullSeconds, attosecondsComponent: fullAttoseconds)
   }
}
