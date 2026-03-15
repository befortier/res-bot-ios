// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "Onboarding",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Onboarding",
            targets: ["Onboarding"]
        )
    ],
    dependencies: [
        .package(path: "../Authentication"),
        .package(path: "../DesignSystem"),
        .package(path: "../Network"),
        .package(path: "../ProjectFoundation"),
        .package(path: "../User")
    ],
    targets: [
        .target(
            name: "Onboarding",
            dependencies: [
                "Authentication",
                "DesignSystem",
                .product(name: "NetworkKit", package: "Network"),
                "ProjectFoundation",
                "User"
            ]
        )
    ]
)
