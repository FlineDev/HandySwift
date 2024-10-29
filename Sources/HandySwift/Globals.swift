import Foundation

/// Runs code with a delay given in seconds, using the main thread by default or a specified QoS class.
///
/// - Parameters:
///   - timeInterval: The duration of the delay. E.g., `.seconds(1)` or `.milliseconds(200)`.
///   - qosClass: The global QoS class to be used or `nil` to use the main thread. Defaults to `nil`.
///   - closure: The code to run with a delay.
public func delay(by timeInterval: TimeInterval, qosClass: DispatchQoS.QoSClass? = nil, _ closure: @Sendable @escaping () -> Void) {
   let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : DispatchQueue.main
   dispatchQueue.asyncAfter(deadline: DispatchTime.now() + timeInterval, execute: closure)
}

/// Runs code with a delay given in seconds, using the main thread by default or a specified QoS class.
///
/// - Parameters:
///   - duration: The duration of the delay. E.g., `.seconds(1)` or `.milliseconds(200)`.
///   - qosClass: The global QoS class to be used or `nil` to use the main thread. Defaults to `nil`.
///   - closure: The code to run with a delay.
@_disfavoredOverload
@available(iOS 16, macOS 13, tvOS 16, visionOS 1, watchOS 9, *)
public func delay(by duration: Duration, qosClass: DispatchQoS.QoSClass? = nil, _ closure: @Sendable @escaping () -> Void) {
   let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : DispatchQueue.main
   dispatchQueue.asyncAfter(deadline: DispatchTime.now() + duration.timeInterval, execute: closure)
}
