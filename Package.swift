// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ResyProApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(
            name: "ResyProApp",
            targets: ["ResyProApp"]
        )
    ],
    dependencies: [
        .package(path: "ResyPro/Packages/DesignSystem"),
        .package(path: "ResyPro/Packages/Reservation"),
        .package(path: "ResyPro/Packages/Network"),
        .package(path: "ResyPro/Packages/Notifications"),
        .package(path: "ResyPro/Packages/ProjectFoundation"),
        .package(path: "ResyPro/Packages/Authentication"),
        .package(path: "ResyPro/Packages/User"),
        .package(path: "ResyPro/Packages/Bootstrap"),
        .package(path: "ResyPro/Packages/Onboarding"),
        .package(path: "ResyPro/Packages/Venues"),
        .package(path: "ResyPro/Packages/Websockets"),
        .package(path: "ResyPro/Packages/DebugTools")
    ],
    targets: [
        .executableTarget(
            name: "ResyProApp",
            dependencies: [
                "DesignSystem",
                "Network",
                "Notifications",
                "ProjectFoundation",
                "Authentication",
                "Onboarding",
                "User",
                "Bootstrap",
                "Reservation",
                "Venues",
                "Websockets",
                "DebugTools"
            ],
            path: "ResyPro",
            exclude: [
                "Packages",
                "Preview Content",
                "Assets.xcassets",
                "Info.plist",
                "ResyPro.entitlements"
            ]
        )
    ]
)
