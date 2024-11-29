// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "orm_flutter_ios",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "orm-flutter-ios",
            type: .dynamic,
            targets: ["query_engine_bridge"]
        )
    ],
    targets: [
        .target(
            name: "query_engine_bridge",
            dependencies: [
                .target(name: "PrismaQueryEngine")
            ],
            linkerSettings: [
                .linkedFramework("CoreFoundation"),
                .linkedFramework("Security"),
            ]
        ),
        .binaryTarget(
            name: "PrismaQueryEngine",
            path: "Frameworks/QueryEngine.xcframework"
        ),
    ]
)
