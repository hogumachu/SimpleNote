// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Service",
  platforms: [.iOS(.v17)],
  products: [
    .library(
      name: "Entity",
      targets: ["Entity"]
    ),
    .library(
      name: "Storage",
      targets: ["Storage"]
    ),
  ],
  dependencies: [
    .package(path: "../Shared")
  ],
  targets: [
    .target(
      name: "Entity"
    ),
    .target(
      name: "Storage",
      dependencies: [
        "Entity",
        .product(name: "ThirdPartyKit", package: "Shared")
      ]
    ),
  ]
)
