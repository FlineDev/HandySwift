// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "HandySwift",
    products: [
        .library(name: "HandySwift", targets: ["HandySwift"])
    ],
    targets: [
        .target(
            name: "HandySwift",
            exclude: ["Sources/SupportingFiles"]
        ),
        .testTarget(
            name: "HandySwiftTests",
            dependencies: ["HandySwift"],
            exclude: ["Tests/SupportingFiles"]
        )
    ],
    swiftLanguageVersions: [4]
)
