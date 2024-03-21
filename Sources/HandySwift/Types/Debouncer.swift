import Foundation

/// A class for debouncing operations.
///
/// Debouncing ensures that an operation is not executed multiple times within a given time frame, cancelling any duplicate operations.
/// Only the last operation will be executed, and only after the given time frame has passed.
///
/// - Note: This is useful to reduce reloads such as when a user is typing text into a search field. Instead of searching immediately on each letter change, it's better to debounce by ~500 milliseconds.
///
/// Example:
/// ```swift
/// let debouncer = Debouncer()
/// debouncer.delay(for: .milliseconds(500)) {
///     // Perform search operation after 500 milliseconds of user inactivity
///     performSearch()
/// }
/// ```
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
   ///
   /// - Availability: iOS 16.0, macOS 13.0, tvOS 16.0, visionOS 1.0, watchOS 9.0
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
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
   ///
   /// Example:
   /// ```swift
   /// let debouncer = Debouncer()
   /// debouncer.delay(for: .milliseconds(500)) {
   ///     // Perform some operation after a 500 milliseconds delay
   ///     performOperation()
   /// }
   /// ```
   public func delay(for interval: TimeInterval, id: String = "default", operation: @escaping () -> Void) {
      self.cancel(id: id)
      self.timerByID[id] = Timer.scheduledTimer(withTimeInterval: interval, repeats: false) { _ in
         operation()
      }
   }

   /// Cancels any in-flight operations with the provided `id`.
   ///
   /// - Parameter id: The identifier of the operation to be canceled.
   ///
   /// Example:
   /// ```swift
   /// var body: some View {
   ///     ContentView()
   ///         .onDisappear {
   ///             debouncer.cancel(id: "search")
   ///         }
   /// }
   /// ```
   public func cancel(id: String) {
      self.timerByID[id]?.invalidate()
   }

   /// Cancels all in-flight operations independent of their `id`. This could be called `.onDisappear` when this is used in a SwiftUI view, for example.
   ///
   /// Example:
   /// ```swift
   /// var body: some View {
   ///     ContentView()
   ///         .onDisappear {
   ///             debouncer.cancelAll()
   ///         }
   /// }
   /// ```
   public func cancelAll() {
      for timer in self.timerByID.values {
         timer.invalidate()
      }
   }
}
