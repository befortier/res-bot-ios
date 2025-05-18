// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Websockets",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "Websockets",
            targets: ["Websockets"]
        ),
    ],
    targets: [
        .target(
            name: "Websockets"
        ),
        .testTarget(
            name: "WebsocketsTests",
            dependencies: ["Websockets"]
        )
    ]
)
