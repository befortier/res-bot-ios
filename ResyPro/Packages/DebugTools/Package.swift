// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DebugTools",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "DebugTools",
            targets: ["DebugTools"]
        )
    ],
    dependencies: [
        .package(path: "../Network"),
        .package(path: "../DesignSystem"),
        .package(path: "../Websockets"),
        .package(path: "../ProjectFoundation"),
        .package(path: "../User"),
        .package(path: "../Venues"),
        .package(path: "../Notifications")
    ],
    targets: [
        .target(
            name: "DebugTools",
            dependencies: [
                "Network",
                "DesignSystem",
                "Websockets",
                "ProjectFoundation",
                "User",
                "Venues",
                "Notifications"
            ],
            resources: []
        )
    ]
)
