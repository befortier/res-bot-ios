// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Bootstrap",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Bootstrap",
            targets: ["Bootstrap"]
        )
    ],
    dependencies: [
        .package(path: "../Authentication"),
        .package(path: "../Network"),
        .package(path: "../ProjectFoundation"),
        .package(path: "../User")
    ],
    targets: [
        .target(
            name: "Bootstrap",
            dependencies: [
                "Authentication",
                "Network",
                "ProjectFoundation",
                "User"
            ]
        )
    ]
)
