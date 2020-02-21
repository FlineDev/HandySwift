// Copyright © 2017 Flinesoft. All rights reserved.

import Foundation

/// A typealias to keep backwards compatibility with version 2.0.x and 2.1.x.
public typealias Timespan = TimeInterval

extension TimeInterval {
    // MARK: - Computed Type Properties
    internal static var secondsPerDay: Double { 24 * 60 * 60 }
    internal static var secondsPerHour: Double { 60 * 60 }
    internal static var secondsPerMinute: Double { 60 }
    internal static var millisecondsPerSecond: Double { 1_000 }
    internal static var microsecondsPerSecond: Double { 1_000 * 1_000 }
    internal static var nanosecondsPerSecond: Double { 1_000 * 1_000 * 1_000 }

    // MARK: - Computed Instance Properties
    /// - Returns: The `TimeInterval` in days.
    public var days: Double {
        self / TimeInterval.secondsPerDay
    }

    /// - Returns: The `TimeInterval` in hours.
    public var hours: Double {
        self / TimeInterval.secondsPerHour
    }

    /// - Returns: The `TimeInterval` in minutes.
    public var minutes: Double {
        self / TimeInterval.secondsPerMinute
    }

    /// - Returns: The `TimeInterval` in seconds.
    public var seconds: Double {
        self
    }

    /// - Returns: The `TimeInterval` in milliseconds.
    public var milliseconds: Double {
        self * TimeInterval.millisecondsPerSecond
    }

    /// - Returns: The `TimeInterval` in microseconds.
    public var microseconds: Double {
        self * TimeInterval.microsecondsPerSecond
    }

    /// - Returns: The `TimeInterval` in nanoseconds.
    public var nanoseconds: Double {
        self * TimeInterval.nanosecondsPerSecond
    }

    // MARK: - Type Methods
    /// - Returns: The time in days using the `TimeInterval` type.
    public static func days(_ value: Double) -> TimeInterval {
        value * secondsPerDay
    }

    /// - Returns: The time in hours using the `TimeInterval` type.
    public static func hours(_ value: Double) -> TimeInterval {
        value * secondsPerHour
    }

    /// - Returns: The time in minutes using the `TimeInterval` type.
    public static func minutes(_ value: Double) -> TimeInterval {
        value * secondsPerMinute
    }

    /// - Returns: The time in seconds using the `TimeInterval` type.
    public static func seconds(_ value: Double) -> TimeInterval {
        value
    }

    /// - Returns: The time in milliseconds using the `TimeInterval` type.
    public static func milliseconds(_ value: Double) -> TimeInterval {
        value / millisecondsPerSecond
    }

    /// - Returns: The time in microseconds using the `TimeInterval` type.
    public static func microseconds(_ value: Double) -> TimeInterval {
        value / microsecondsPerSecond
    }

    /// - Returns: The time in nanoseconds using the `TimeInterval` type.
    public static func nanoseconds(_ value: Double) -> TimeInterval {
        value / nanosecondsPerSecond
    }
}
