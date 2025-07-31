// swift-tools-version: 6.0
import PackageDescription

let package = Package(
   name: "HandySwift",
   platforms: [.iOS(.v12), .macOS(.v10_14), .tvOS(.v13), .visionOS(.v1), .watchOS(.v6)],
   products: [.library(name: "HandySwift", targets: ["HandySwift"])],
   targets: [
      .target(name: "HandySwift"),
      .testTarget(name: "HandySwiftTests", dependencies: ["HandySwift"]),
   ]
)
