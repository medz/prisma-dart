// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "orm_flutter_ios",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(name: "orm-flutter-ios", targets: ["PrismaQueryEngineBridge"]),
    ],
    targets: [
        .target(
            name: "PrismaQueryEngineBridge",
            dependencies: ["PrismaQueryEngine"],
            path: "Sources/query_engine_bridge",
            sources: ["bridge.c"],
            cSettings: [
                .headerSearchPath("headers"),
                .headerSearchPath("include")
            ],
            linkerSettings: [
                .linkedFramework("PrismaQueryEngine")
            ]
        ),
        .binaryTarget(
            name: "PrismaQueryEngine",
            path: "Frameworks/QueryEngine.xcframework"
        )
    ]
)
