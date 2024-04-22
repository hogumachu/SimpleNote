// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Shared",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "ThirdPartyKit",
      targets: ["ThirdPartyKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.9.3")),
    .package(url: "https://github.com/malcommac/SwiftDate", .upToNextMajor(from: "7.0.0")),
    .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.4.3")),
  ],
  targets: [
    .target(
      name: "ThirdPartyKit",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "SwiftDate",
        .product(name: "Lottie", package: "lottie-spm"),
      ]
    ),
  ]
)
