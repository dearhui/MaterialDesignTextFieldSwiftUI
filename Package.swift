// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MaterialDesignTextFieldSwiftUI",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "MaterialDesignTextFieldSwiftUI",
            targets: ["MaterialDesignTextFieldSwiftUI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/CodeSlicing/pure-swift-ui", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "MaterialDesignTextFieldSwiftUI",
            dependencies: [.product(name: "PureSwiftUI", package: "pure-swift-ui")]),
        .testTarget(
            name: "MaterialDesignTextFieldSwiftUITests",
            dependencies: ["MaterialDesignTextFieldSwiftUI", .product(name: "PureSwiftUI", package: "pure-swift-ui")]),
    ]
)
