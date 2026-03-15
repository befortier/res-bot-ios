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
    )
  ],
  dependencies: [
    .package(path: "../DesignSystem"),
    .package(path: "../Reservation"),
    .package(path: "../Network"),
    .package(path: "../Venues"),
    .package(path: "../Websockets"),
    .package(url: "https://github.com/kean/Nuke.git", from: "12.0.0"),
  ],
  targets: [
    .target(
      name: "Notifications",
      dependencies: [
        "DesignSystem",
        "Reservation",
        .product(name: "NetworkKit", package: "Network"),
        "Venues",
        "Websockets",
        .product(name: "Nuke", package: "Nuke"),
        .product(name: "NukeUI", package: "Nuke"),
      ]
    ),
    .testTarget(
      name: "NotificationsTests",
      dependencies: ["Notifications", "Venues"]
    ),
  ]
)
