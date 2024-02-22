import Foundation

/// A date without time info.
public struct GregorianDay {
   public let year: Int
   public let month: Int
   public let day: Int
   
   public init(date: Date) {
      let components = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day], from: date)
      self.year = components.year!
      self.month = components.month!
      self.day = components.day!
   }
   
   public init(year: Int, month: Int, day: Int) {
      assert(month >= 1 && month <= 12)
      assert(day >= 1 && day <= 31)
      
      self.year = year
      self.month = month
      self.day = day
   }
   
   public func advanced(by days: Int) -> Self {
      GregorianDay(date: self.midOfDay().addingTimeInterval(.days(Double(days))))
   }
   
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
}

extension GregorianDay: Codable {
   static var dateFormatter: DateFormatter {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd"
      dateFormatter.calendar = Calendar(identifier: .gregorian)
      return dateFormatter
   }

   public init(from decoder: Decoder) throws {
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)

      guard let date = Self.dateFormatter.date(from: dateString) else {
         throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string")
      }

      self = GregorianDay(date: date)
   }

   public func encode(to encoder: Encoder) throws {
      var container = encoder.singleValueContainer()
      let dateString = Self.dateFormatter.string(from: self.startOfDay())
      try container.encode(dateString)
   }
}

extension GregorianDay: Hashable, Sendable {}
extension GregorianDay: Identifiable {
   public var id: String { "\(self.year)-\(self.month)-\(self.day)" }
}

extension GregorianDay: Comparable {
   public static func < (left: GregorianDay, right: GregorianDay) -> Bool {
      guard left.year == right.year else { return left.year < right.year }
      guard left.month == right.month else { return left.month < right.month }
      return left.day < right.day
   }
}

extension GregorianDay {
   public static var yesterday: Self { GregorianDay(date: Date()).advanced(by: -1) }
   public static var today: Self { GregorianDay(date: Date()) }
   public static var tomorrow: Self { GregorianDay(date: Date()).advanced(by: 1) }
}
