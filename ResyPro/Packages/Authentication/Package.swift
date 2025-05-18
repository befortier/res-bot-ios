// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]
        )
    ],
    dependencies: [
        .package(path: "../Network"),
        .package(path: "../ProjectFoundation"),
        .package(path: "../User")
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                "Network",
                "ProjectFoundation",
                "User"
            ]
        )
    ]
)
