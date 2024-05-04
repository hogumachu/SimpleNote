// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "WatchFeature",
  platforms: [.watchOS(.v10)],
  products: [
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
      name: "WatchFeatureKit",
      dependencies: [
        .product(name: "ImageResourceKit", package: "Shared"),
        .product(name: "Storage", package: "Service"),
        .product(name: "ThirdPartyKit", package: "Shared"),
      ]
    ),
    .target(
      name: "WatchHomeFeature",
      dependencies: [
        "WatchFeatureKit"
      ]
    ),
  ]
)
