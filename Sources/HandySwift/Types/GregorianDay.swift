import Foundation

/// A date without time information.
///
/// Example:
/// ```swift
/// let yesterday = GregorianDay.yesterday
/// print(yesterday.iso8601Formatted) // Prints the current date in ISO 8601 format, e.g. "2024-03-20"
///
/// let tomorrow = yesterday.advanced(by: 2)
/// let timCookBirthday = GregorianDay(year: 1960, month: 11, day: 01)
///
/// let startOfDay = GregorianDay(date: Date()).startOfDay()
/// ```
public struct GregorianDay {
   /// The year component of the date.
   public var year: Int
   /// The month component of the date.
   public var month: Int
   /// The day component of the date.
   public var day: Int

   /// Returns an ISO 8601 formatted String representation of the date, e.g., `2024-02-24`.
   public var iso8601Formatted: String {
      "\(String(format: "%04d", self.year))-\(String(format: "%02d", self.month))-\(String(format: "%02d", self.day))"
   }

   /// Initializes a `GregorianDay` instance with the given `Date`.
   ///
   /// - Parameter date: The date to extract components from.
   public init(date: Date) {
      let components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: date)
      self.year = components.year!
      self.month = components.month!
      self.day = components.day!
   }

   /// Initializes a `GregorianDay` instance with the given year, month, and day.
   ///
   /// - Parameters:
   ///   - year: The year of the date.
   ///   - month: The month of the date.
   ///   - day: The day of the date.
   public init(year: Int, month: Int, day: Int) {
      assert(month >= 1 && month <= 12)
      assert(day >= 1 && day <= 31)

      self.year = year
      self.month = month
      self.day = day
   }

   /// Advances the date by the specified number of days.
   ///
   /// - Parameter days: The number of days to advance the date by.
   /// - Returns: A new `GregorianDay` instance advanced by the specified number of days.
   ///
   /// Example:
   /// ```swift
   /// let tomorrow = GregorianDay.today.advanced(by: 1)
   /// ```
   public func advanced(by days: Int) -> Self {
      GregorianDay(date: self.midOfDay().addingTimeInterval(.days(Double(days))))
   }

   /// Reverses the date by the specified number of days.
   ///
   /// - Parameter days: The number of days to reverse the date by.
   /// - Returns: A new `GregorianDay` instance reversed by the specified number of days.
   ///
   /// Example:
   /// ```swift
   /// let yesterday = GregorianDay.today.reversed(by: 1)
   /// ```
   public func reversed(by days: Int) -> Self {
      self.advanced(by: -days)
   }

   /// Advances the date by the specified number of months.
   ///
   /// - Parameter months: The number of months to advance the date by.
   /// - Returns: A new `GregorianDay` instance advanced by the specified number of months.
   ///
   /// - Warning: This may return an invalid date such as February 31st. Only use in combination with a method like ``startOfMonth(timeZone:)`` that removes the day.
   ///
   /// Example:
   /// ```swift
   /// let tomorrow = GregorianDay.today.advanced(byMonths: 1)
   /// ```
   public func advanced(byMonths months: Int) -> Self {
      let (overflowingYears, newMonth) = (self.month + months - 1).quotientAndRemainder(dividingBy: 12)
      return self.with {
         $0.year += overflowingYears
         $0.month = newMonth + 1
      }
   }

   /// Reverses the date by the specified number of months.
   ///
   /// - Parameter months: The number of months to reverse the date by.
   /// - Returns: A new `GregorianDay` instance reversed by the specified number of months.
   ///
   /// - Warning: This may return an invalid date such as February 31st. Only use in combination with a method like ``startOfMonth(timeZone:)`` that removes the day.
   ///
   /// Example:
   /// ```swift
   /// let yesterday = GregorianDay.today.reversed(byMonths: 1)
   /// ```
   public func reversed(byMonths months: Int) -> Self {
      self.advanced(byMonths: -months)
   }

   /// Advances the date by the specified number of years.
   ///
   /// - Parameter years: The number of years to advance the date by.
   /// - Returns: A new `GregorianDay` instance advanced by the specified number of years. The day and month stay the same.
   ///
   /// - Warning: This may return an invalid date such as February 31st. Only use in combination with a method like ``startOfMonth(timeZone:)`` that removes the day.
   ///
   /// Example:
   /// ```swift
   /// let tomorrow = GregorianDay.today.advanced(byYears: 1)
   /// ```
   public func advanced(byYears years: Int) -> Self {
      self.with { $0.year += years }
   }

   /// Reverses the date by the specified number of years.
   ///
   /// - Parameter years: The number of years to reverse the date by.
   /// - Returns: A new `GregorianDay` instance reversed by the specified number of years. The day and month stay the same.
   ///
   /// - Warning: This may return an invalid date such as February 31st. Only use in combination with a method like ``startOfMonth(timeZone:)`` that removes the day.
   /// Example:
   /// ```swift
   /// let yesterday = GregorianDay.today.reversed(byYears: 1)
   /// ```
   public func reversed(byYears years: Int) -> Self {
      self.advanced(byYears: -years)
   }

   /// Returns the start of the day represented by the date.
   ///
   /// - Parameter timeZone: The time zone for which to calculate the start of the day. Defaults to the users current timezone.
   /// - Returns: A `Date` representing the start of the day.
   ///
   /// Example:
   /// ```swift
   /// let startOfToday = GregorianDay.today.startOfDay()
   /// ```
   public func startOfDay(timeZone: TimeZone = .current) -> Date {
      let components = DateComponents(
         calendar: Calendar(identifier: .gregorian),
         timeZone: timeZone,
         year: self.year,
         month: self.month,
         day: self.day
      )
      return components.date!
   }

   /// Returns the start of the month represented by the date.
   ///
   /// - Parameter timeZone: The time zone for which to calculate the start of the month. Defaults to the users current timezone.
   /// - Returns: A `Date` representing the start of the month.
   ///
   /// Example:
   /// ```swift
   /// let startOfThisMonth = GregorianDay.today.startOfMonth()
   /// ```
   public func startOfMonth(timeZone: TimeZone = .current) -> Date {
      let components = DateComponents(
         calendar: Calendar(identifier: .gregorian),
         timeZone: timeZone,
         year: self.year,
         month: self.month,
         day: 1
      )
      return components.date!
   }

   /// Returns the start of the year represented by the date.
   ///
   /// - Parameter timeZone: The time zone for which to calculate the start of the year. Defaults to the users current timezone.
   /// - Returns: A `Date` representing the start of the year.
   ///
   /// Example:
   /// ```swift
   /// let startOfThisYear = GregorianDay.today.startOfYear()
   /// ```
   public func startOfYear(timeZone: TimeZone = .current) -> Date {
      let components = DateComponents(
         calendar: Calendar(identifier: .gregorian),
         timeZone: timeZone,
         year: self.year,
         month: 1,
         day: 1
      )
      return components.date!
   }

   /// Returns the middle of the day represented by the date.
   ///
   /// - Parameter timeZone: The time zone for which to calculate the middle of the day. Defaults to UTC.
   /// - Returns: A `Date` representing the middle of the day.
   ///
   /// - Note: If you need to pass a `Date` to an API that only cares about the day (not the time), calling ``midOfDay(timeZone:)`` ensures you get the same day independent of timezones.
   ///
   /// Example:
   /// ```swift
   /// let midOfToday: Date = GregorianDay.today.midOfDay()  // the middle of today in UTC time zone
   /// ```
   public func midOfDay(timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) -> Date {
      let components = DateComponents(
         calendar: Calendar(identifier: .gregorian),
         timeZone: timeZone,
         year: self.year,
         month: self.month,
         day: self.day,
         hour: 12
      )
      return components.date!
   }

   /// Returns a `Date` representing this day at the specified time.
   ///
   /// - Parameters:
   ///   - timeOfDay: The time of day to set for the resulting date.
   ///   - timeZone: The time zone for which to calculate the date. Defaults to the users current timezone.
   /// - Returns: A `Date` representing this day at the specified time.
   ///
   /// Example:
   /// ```swift
   /// let noonToday = GregorianDay.today.date(timeOfDay: .noon)  // today at 12:00
   /// ```
   public func date(timeOfDay: GregorianTime, timeZone: TimeZone = .current) -> Date {
      timeOfDay.date(day: self, timeZone: timeZone)
   }
}

extension GregorianDay: Codable {
   /// Initializes a `GregorianDay` instance by decoding from the provided decoder.
   ///
   /// - Parameter decoder: The decoder to read data from.
   /// - Throws: An error if reading from the decoder fails, or if the data is corrupted or cannot be decoded.
   public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)

      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd"
      formatter.calendar = Calendar(identifier: .gregorian)

      guard let date = formatter.date(from: dateString) else {
         throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string")
      }

      self = GregorianDay(date: date)
   }

   /// Encodes the `GregorianDay` instance into the provided encoder.
   ///
   /// - Parameter encoder: The encoder to write data to.
   /// - Throws: An error if encoding fails.
   public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      try container.encode(self.iso8601Formatted)
   }
}

extension GregorianDay: Hashable, Sendable {}
extension GregorianDay: Identifiable {
   /// The identifier of the `GregorianDay` instance, which is a string representation of its year, month, and day.
   public var id: String { "\(self.year)-\(self.month)-\(self.day)" }
}

extension GregorianDay: Comparable {
   /// Compares two `GregorianDay` instances for order.
   ///
   /// - Parameters:
   ///   - left: The first `GregorianDay` instance to compare.
   ///   - right: The second `GregorianDay` instance to compare.
   /// - Returns: `true` if the `left` date is less than the `right` date; otherwise, `false`.
   public static func < (left: GregorianDay, right: GregorianDay) -> Bool {
      guard left.year == right.year else { return left.year < right.year }
      guard left.month == right.month else { return left.month < right.month }
      return left.day < right.day
   }
}

extension GregorianDay {
   /// The `GregorianDay` representing yesterday's date.
   public static var yesterday: Self { GregorianDay(date: Date()).advanced(by: -1) }

   /// The `GregorianDay` representing today's date.
   public static var today: Self { GregorianDay(date: Date()) }

   /// The `GregorianDay` representing tomorrow's date.
   public static var tomorrow: Self { GregorianDay(date: Date()).advanced(by: 1) }
}

extension GregorianDay: Withable {}
