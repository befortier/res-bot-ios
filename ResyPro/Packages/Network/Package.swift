// swift-tools-version: 6.0
import PackageDescription

let package = Package(
  name: "Network",
  platforms: [
    .iOS(.v17),
    .macOS(.v14),
  ],
  products: [
    .library(
      name: "NetworkKit",
      targets: ["NetworkKit"]
    )
  ],
  targets: [
    .target(
      name: "NetworkKit",
      dependencies: [],
      resources: [.process("Resources")]
    ),
    .testTarget(
      name: "NetworkTests",
      dependencies: ["NetworkKit"]
    ),
  ]
)
