// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Network",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Network",
            targets: ["Network"]
        ),
    ],
    targets: [
        .target(
            name: "Network",
            dependencies: []
        )
    ]
)
