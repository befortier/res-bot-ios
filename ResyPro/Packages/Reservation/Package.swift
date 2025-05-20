// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Reservation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Reservation",
            targets: ["Reservation"]
        )
    ],
    dependencies: [
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "Reservation",
            dependencies: ["DesignSystem"]
        )
    ]
)
