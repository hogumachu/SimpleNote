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
      name: "CalendarFeature",
      targets: ["CalendarFeature"]
    ),
    .library(
      name: "FolderFeature",
      targets: ["FolderFeature"]
    ),
    .library(
      name: "HomeFeature",
      targets: ["HomeFeature"]
    ),
    .library(
      name: "SettingFeature",
      targets: ["SettingFeature"]
    ),
    .library(
      name: "TodoFeature",
      targets: ["TodoFeature"]
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
        .product(name: "ImageResourceKit", package: "Shared"),
        .product(name: "UIDesignKit", package: "UI"),
      ]
    ),
    .target(
      name: "UIFeatureKit",
      dependencies: [
        "BaseFeature",
        .product(name: "ThirdPartyKit", package: "Shared")
      ]
    ),
    .target(
      name: "CalendarFeature",
      dependencies: [
        "UIFeatureKit",
        "TodoFeature"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "FolderFeature",
      dependencies: [
        "UIFeatureKit",
        "TodoFeature"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "HomeFeature",
      dependencies: [
        "UIFeatureKit",
        "SettingFeature",
        "TodoFeature",
        "FolderFeature"
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
      name: "TodoFeature",
      dependencies: [
        "UIFeatureKit"
      ],
      resources: [
        .process("Resources")
      ]
    ),
  ]
)
