// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Venues",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Venues",
            targets: ["Venues"]
        ),
    ],
    dependencies: [
        .package(path: "../DesignSystem"),
        .package(path: "../Network"),
        .package(path: "../ProjectFoundation"),
        .package(url: "https://github.com/kean/Nuke.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "Venues",
            dependencies: [
                "DesignSystem",
                "Network",
                "ProjectFoundation",
                .product(name: "NukeUI", package: "Nuke")
            ]
        )
    ]
)
