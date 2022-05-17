// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MMMTooltip",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "MMMTooltip",
            targets: ["MMMTooltip"]
		)
    ],
    dependencies: [
		.package(url: "https://github.com/mediamonks/MMMTackKit", .upToNextMajor(from: "0.8.1")),
		.package(url: "https://github.com/mediamonks/MMMCommonCore", .upToNextMajor(from: "1.6.0"))
    ],
    targets: [
        .target(
            name: "MMMTooltip",
            dependencies: [
				"MMMCommonCore",
				"MMMTackKit"
            ],
            path: "Sources"
		),
        .testTarget(
            name: "MMMTooltipTests",
            dependencies: ["MMMTooltip"],
            path: "Tests"
		)
    ]
)
