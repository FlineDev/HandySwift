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

#if swift(>=5.6)
  // Add the documentation compiler plugin if possible
  package.dependencies.append(
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  )
#endif
