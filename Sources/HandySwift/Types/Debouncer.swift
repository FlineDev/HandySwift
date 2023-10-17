import Foundation

/// A class for delaying and debouncing operations.
public final class Debouncer {
   private var timerByID: [String: Timer] = [:]

   /// Initializes a new instance of the `Debouncer` class.
   public init() {}

   /// Delays operations and cancels all but the last one when the same `id` is provided.
   ///
   /// - Parameters:
   ///   - duration: The time duration for the delay.
   ///   - id: An optional identifier to distinguish different delays (default is "default").
   ///   - operation: The operation to be delayed and executed.
   ///
   /// This version of `delay` uses a `Duration` to specify the delay time.
   @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
   public func delay(for duration: Duration, id: String = "default", operation: @escaping () -> Void) {
      self.cancel(id: id)
      self.timerByID[id] = Timer.scheduledTimer(withTimeInterval: duration.timeInterval, repeats: false) { _ in
         operation()
      }
   }

   /// Delays operations and cancels all but the last one when the same `id` is provided.
   ///
   /// - Parameters:
   ///   - interval: The time interval for the delay.
   ///   - id: An optional identifier to distinguish different delays (default is "default").
   ///   - operation: The operation to be delayed and executed.
   ///
   /// This version of `delay` uses a `TimeInterval` to specify the delay time.
   public func delay(for interval: TimeInterval, id: String = "default", operation: @escaping () -> Void) {
      self.cancel(id: id)
      self.timerByID[id] = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
         operation()
      }
   }

   /// Cancels any in-flight operations with the provided `id`.
   public func cancel(id: String) {
      self.timerByID[id]?.invalidate()
   }

   /// Cancels all in-flight operations independent of their `id`. This could be called `.onDisappear` when this is used in a SwiftUI view, for example.
   public func cancelAll() {
      for timer in self.timerByID.values {
         timer.invalidate()
      }
   }
}
