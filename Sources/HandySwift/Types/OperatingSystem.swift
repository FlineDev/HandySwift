import Foundation

public typealias OS = OperatingSystem

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

   static var current: OperatingSystem {
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
}
