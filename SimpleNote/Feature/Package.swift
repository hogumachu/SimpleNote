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
      name: "UIFeatureKit",
      targets: ["UIFeatureKit"]
    ),
    .library(
      name: "AllFeatures",
      targets: ["AllFeatures"]
    ),
    .library(
      name: "SettingFeature",
      targets: ["SettingFeature"]
    ),
    .library(
      name: "SettingFeatureImp",
      targets: ["SettingFeatureImp"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared"),
    .package(path: "../Service"),
    .package(path: "../UI")
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
      name: "UIFeatureKit",
      dependencies: [
        "BaseFeature",
        .product(name: "ThirdPartyKit", package: "Shared"),
        .product(name: "UIDesignKit", package: "UI")
      ]
    ),
    .target(
      name: "AllFeatures",
      dependencies: [
        "UIFeatureKit",
        "SettingFeature"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "SettingFeature",
      dependencies: [
        "UIFeatureKit"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "SettingFeatureImp",
      dependencies: [
        "SettingFeature"
      ]
    ),
  ]
)
