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
        .package(path: "../ProjectFoundation")
    ],
    targets: [
        .target(
            name: "Venues",
            dependencies: [
                "DesignSystem",
                "Network",
                "ProjectFoundation"
            ]
        )
    ]
)
