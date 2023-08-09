import Foundation

public struct GregorianTimeOfDay {
   public let overflowingDays: Int
   public let hour: Int
   public let minute: Int
   public let second: Int
   
   public init(date: Date) {
      let components = Calendar(identifier: .gregorian).dateComponents([.hour, .minute, .second], from: date)
      self.overflowingDays = 0
      self.hour = components.hour!
      self.minute = components.minute!
      self.second = components.second!
   }
   
   public init(hour: Int, minute: Int, second: Int = 0) {
      assert(hour >= 0 && hour < 24)
      assert(minute >= 0 && minute < 60)
      assert(second >= 0 && second < 60)
      
      self.overflowingDays = 0
      self.hour = hour
      self.minute = minute
      self.second = second
   }
   
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
   
   @available(iOS 16, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
   public init(durationSinceStartOfDay: Duration) {
      self.overflowingDays = Int(durationSinceStartOfDay.timeInterval.days)
      self.hour = Int((durationSinceStartOfDay - .days(self.overflowingDays)).timeInterval.hours)
      self.minute = Int((durationSinceStartOfDay - .days(self.overflowingDays) - .hours(self.hour)).timeInterval.minutes)
      self.second = Int((durationSinceStartOfDay - .days(self.overflowingDays) - .hours(self.hour) - .minutes(self.minute)).timeInterval.seconds)
   }
   
   @available(iOS 16, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
   public var durationSinceStartOfDay: Duration {
      .days(self.overflowingDays) + .hours(self.hour) + .minutes(self.minute) + .seconds(self.second)
   }
   
   @available(iOS 16, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
   public func advanced(by duration: Duration) -> Self {
      GregorianTimeOfDay(durationSinceStartOfDay: self.durationSinceStartOfDay + duration)
   }
}

extension GregorianTimeOfDay: Codable, Hashable, Sendable {}
extension GregorianTimeOfDay: Identifiable {
   public var id: String { "\(self.hour):\(self.minute):\(self.second)" }
}

extension GregorianTimeOfDay: Comparable {
   public static func < (left: GregorianTimeOfDay, right: GregorianTimeOfDay) -> Bool {
      guard left.overflowingDays == right.overflowingDays else { return left.overflowingDays < right.overflowingDays }
      guard left.hour == right.hour else { return left.hour < right.hour }
      guard left.minute == right.minute else { return left.minute < right.minute }
      return left.second < right.second
   }
}

extension GregorianTimeOfDay {
   public static var zero: Self { GregorianTimeOfDay(hour: 0, minute: 0, second: 0) }
   public static var now: Self { GregorianTimeOfDay(date: Date()) }
}
