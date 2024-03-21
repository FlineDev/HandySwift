import Foundation

public typealias OS = OperatingSystem

/// The list of possible Operating Systems a Swift program might run in.
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
   
   /// - Returns: The value provided for the OS-specific parameter if provided, else falls back to `default`.
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
