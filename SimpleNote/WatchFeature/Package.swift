// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WatchFeature",
  defaultLocalization: "en",
  platforms: [.watchOS(.v10)],
  products: [
    .library(
      name: "WatchBaseFeature",
      targets: ["WatchBaseFeature"]
    ),
    .library(
      name: "WatchFeatureKit",
      targets: ["WatchFeatureKit"]
    ),
    .library(
      name: "WatchHomeFeature",
      targets: ["WatchHomeFeature"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
    .package(path: "../Service"),
  ],
  targets: [
    .target(
      name: "WatchBaseFeature",
      dependencies: [
        .product(name: "DesignKit", package: "Shared"),
        .product(name: "ImageResourceKit", package: "Shared"),
        .product(name: "Storage", package: "Service"),
      ]
    ),
    .target(
      name: "WatchFeatureKit",
      dependencies: [
        "WatchBaseFeature",
        .product(name: "ThirdPartyKit", package: "Shared"),
      ]
    ),
    .target(
      name: "WatchHomeFeature",
      dependencies: [
        "WatchFeatureKit"
      ],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
