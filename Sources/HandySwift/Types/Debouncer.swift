import Foundation

/// A class for debouncing operations.
///
/// Debouncing ensures that an operation is not executed multiple times within a given time frame, cancelling any duplicate operations.
/// Only the last operation will be executed, and only after the given time frame has passed.
///
/// - Note: This is useful for improving user experience in scenarios like search functionalities in apps, where you might want to reduce the number of search operations triggered by keystroke events.
///
/// Example for SwiftUI's `.searchable` modifier:
/// ```swift
/// @State private var searchText = ""
/// let debouncer = Debouncer()
///
/// var body: some View {
///     List(filteredItems) { item in
///         Text(item.title)
///     }
///     .searchable(text: self.$searchText)
///     .onChange(of: self.searchText) { newValue in
///         self.debouncer.delay(for: 0.5) {
///             // Perform search operation with the updated search text after 500 milliseconds of user inactivity
///             self.performSearch(with: newValue)
///         }
///     }
///     .onDisappear {
///         debouncer.cancelAll()
///     }
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
   /// This version of `delay` uses a `Duration` to specify the delay time, available in iOS 16 and later.
   ///
   /// Example:
   /// ```swift
   /// let debouncer = Debouncer()
   /// debouncer.delay(for: .milliseconds(500), id: "search") {
   ///     // Perform some operation after a 500 milliseconds delay
   ///     performOperation()
   /// }
   /// ```
   @available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
   public func delay(for duration: Duration, id: String = "default", operation: @Sendable @escaping () -> Void) {
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
   /// Example for a generic operation:
   /// ```swift
   /// let debouncer = Debouncer()
   /// debouncer.delay(for: 0.5, id: "genericOperation") {
   ///     // Perform some operation after a 500 milliseconds delay
   ///     performOperation()
   /// }
   /// ```
   public func delay(for interval: TimeInterval, id: String = "default", operation: @Sendable @escaping () -> Void) {
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
