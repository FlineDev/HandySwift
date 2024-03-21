import Foundation

/// A shorthand for `OperatingSystem` to save typing work when using this often inside SwiftUI modifiers, for example.
public typealias OS = OperatingSystem

/// Represents the possible Operating Systems on which a Swift program might run.
/// 
/// String example:
/// ```swift
/// let settingsAppName = OS.value(default: "Settings", macOS: "System Settings")
/// print(settingsAppName) // Output will be "System Settings" if running on macOS, otherwise "Settings" for all other platforms
/// ```
///
/// SwiftUI modifier example:
/// ```swift
/// Button("Close", "xmark.circle") {
///   self.dismiss()
/// }
/// .labelStyle(.iconOnly)
/// .frame(
///   width: OS.value(default: 44, visionOS: 60),
///   height: OS.value(default: 44, visionOS: 60)
/// )
/// ```
public enum OperatingSystem: AutoConforming {
   // Apple Platforms
   case iOS
   case macOS
   case tvOS
   case visionOS
   case watchOS

   // Other
   case linux
   case windows

   /// Returns the current operating system.
   public static var current: OperatingSystem {
      #if os(iOS)
      return .iOS
      #elseif os(macOS)
      return .macOS
      #elseif os(tvOS)
      return .tvOS
      #elseif os(visionOS)
      return .visionOS
      #elseif os(watchOS)
      return .watchOS
      #elseif os(Linux)
      return .linux
      #elseif os(Windows)
      return .windows
      #else
      fatalError("Unsupported operating system")
      #endif
   }

   /// Returns the value provided for the OS-specific parameter if provided, else falls back to `default`.
   ///
   /// - Parameters:
   ///   - defaultValue: The default value to use if no OS-specific value is provided.
   ///   - iOS: The value specific to iOS.
   ///   - macOS: The value specific to macOS.
   ///   - tvOS: The value specific to tvOS.
   ///   - visionOS: The value specific to visionOS.
   ///   - watchOS: The value specific to watchOS.
   ///   - linux: The value specific to Linux.
   ///   - windows: The value specific to Windows.
   /// - Returns: The value provided for the OS-specific parameter if provided, else falls back to `default`.
   ///
   /// String example:
   /// ```swift
   /// let settingsAppName = OS.value(default: "Settings", macOS: "System Settings")
   /// print(settingsAppName) // Output will be "System Settings" if running on macOS, otherwise "Settings" for all other platforms
   /// ```
   ///
   /// SwiftUI modifier example:
   /// ```swift
   /// Button("Close", "xmark.circle") {
   ///   self.dismiss()
   /// }
   /// .labelStyle(.iconOnly)
   /// .frame(
   ///   width: OS.value(default: 44, visionOS: 60),
   ///   height: OS.value(default: 44, visionOS: 60)
   /// )
   /// ```
   public static func value<T>(
      default defaultValue: T,
      iOS: T? = nil,
      macOS: T? = nil,
      tvOS: T? = nil,
      visionOS: T? = nil,
      watchOS: T? = nil,
      linux: T? = nil,
      windows: T? = nil
   ) -> T {
      switch Self.current {
      case .iOS: iOS ?? defaultValue
      case .macOS: macOS ?? defaultValue
      case .tvOS: tvOS ?? defaultValue
      case .visionOS: visionOS ?? defaultValue
      case .watchOS: watchOS ?? defaultValue
      case .linux: linux ?? defaultValue
      case .windows: windows ?? defaultValue
      }
   }
}
