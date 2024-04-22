// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Feature",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "BaseFeature",
      targets: ["BaseFeature"]
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
      ]
    ),
    .target(
      name: "AllFeatures",
      dependencies: [
        "BaseFeature"
      ],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
