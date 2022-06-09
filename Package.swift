// swift-tools-version:5.1
import PackageDescription

let package = Package(
  name: "HandySwift",
  platforms: [.iOS(.v8), .macOS(.v10_10), .tvOS(.v9), .watchOS(.v2)],
  products: [
    .library(name: "HandySwift", targets: ["HandySwift"])
  ],
  targets: [
    .target(name: "HandySwift"),
    .testTarget(name: "HandySwiftTests", dependencies: ["HandySwift"])
  ]
)
