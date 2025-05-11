// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ProjectFoundation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "ProjectFoundation",
            targets: ["ProjectFoundation"]
        ),
    ],
    targets: [
        .target(
            name: "ProjectFoundation",
            dependencies: []
        )
    ]
)
