// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PageControl",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "PageControl",
            targets: ["PageControl"]),
    ],
    targets: [
        .target(
            name: "PageControl",
            path: "Sources")
    ]
)
