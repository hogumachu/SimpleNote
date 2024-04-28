// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UIDesignKit",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "UIDesignKit",
      targets: ["UIDesignKit"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
    .package(path: "../Service"),
    .package(url: "https://github.com/airbnb/lottie-spm.git", .upToNextMajor(from: "4.4.3")),
  ],
  targets: [
    .target(
      name: "UIDesignKit",
      dependencies: [
        .product(name: "Entity", package: "Service"),
        .product(name: "ThirdPartyKit", package: "Shared"),
        .product(name: "Lottie", package: "lottie-spm"),
      ],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
