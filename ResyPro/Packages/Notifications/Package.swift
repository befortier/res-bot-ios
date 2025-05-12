// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Notifications",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Notifications",
            targets: ["Notifications"]
        ),
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../Network"),
        .package(path: "../Venues"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "Notifications",
            dependencies: [
                "DesignSystem",
                "Network",
                "Venues",
                .product(name: "Nuke", package: "Nuke"),
                .product(name: "NukeUI", package: "Nuke")
            ]
        )
    ]
)
