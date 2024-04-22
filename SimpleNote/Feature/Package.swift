// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  defaultLocalization: "en",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "BaseFeature",
      targets: ["BaseFeature"]
    ),
    .library(
      name: "FeatureKit",
      targets: ["FeatureKit"]
    ),
    .library(
      name: "AllFeatures",
      targets: ["AllFeatures"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
    .package(path: "../Service")
  ],
  targets: [
    .target(
      name: "BaseFeature",
      dependencies: [
        .product(name: "Storage", package: "Service"),
        .product(name: "ThirdPartyKit", package: "Shared"),
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "FeatureKit",
      dependencies: [
        "BaseFeature"
      ]
    ),
    .target(
      name: "AllFeatures",
      dependencies: [
        "FeatureKit"
      ],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
