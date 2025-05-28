// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "User",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "User",
            targets: ["User"]
        ),
    ],
    dependencies: [
      .package(path: "../Network"),
      .package(path: "../ProjectFoundation"),
    ],
    targets: [
        .target(
            name: "User",
            dependencies: [
                "Network",
                "ProjectFoundation",
            ]
        )
    ]
)
