// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Nuke.git", from: "12.0.0")
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "NukeUI", package: "Nuke")
            ],
            resources: [.process("Resources")]
        )
    ]
)
