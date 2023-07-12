import Foundation

public struct GregorianTimeOfDay {
   public let hour: Int
   public let minute: Int
   public let second: Int

   public init(date: Date) {
      let components = Calendar(identifier: .gregorian).dateComponents([.hour, .minute, .second], from: date)
      self.hour = components.hour!
      self.minute = components.minute!
      self.second = components.second!
   }

   public init(hour: Int, minute: Int = 0, second: Int = 0) {
      assert(hour >= 0 && hour < 24)
      assert(minute >= 0 && minute < 60)
      assert(second >= 0 && second < 60)

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
      return components.date!
   }
}
