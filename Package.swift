// swift-tools-version:5.4
//
//  Package.swift
//  LispKit
//
//  Build targets by calling the Swift Package Manager in the following way for debug purposes:
//  swift build -Xswiftc "-D" -Xswiftc "SPM"
//
//  Run REPL:
//  swift run -Xswiftc "-D" -Xswiftc "SPM"
//
//  A release can be built with these options:
//  swift build -c release -Xswiftc "-D" -Xswiftc "SPM"
//
//  This creates a release binary in .build/release/ which can be invoked like this:
//  .build/release/LispKitRepl -r Sources/LispKit/Resources
//  
//  This is how to run the tests:
//  swift test -Xswiftc "-D" -Xswiftc "SPM"
//  
//
//  Created by Matthias Zenger on 16/10/2017.
//  Copyright © 2017-2023 ObjectHub. All rights reserved.
//  
//  Licensed under the Apache License, Version 2.0 (the "License"); you
//  may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import PackageDescription

let package = Package(
  name: "LispKit",
  platforms: [
    .macOS(.v11),
    .iOS(.v14)
  ],
  products: [
    .library(name: "LispKit", targets: ["LispKit"]),
    .library(name: "LispKitTools", targets: ["LispKitTools"]),
    .executable(name: "LispKitRepl", targets: ["LispKitRepl"])
  ],
  dependencies: [
    .package(url: "https://github.com/objecthub/swift-numberkit.git", from: "2.4.2"),
    .package(url: "https://github.com/objecthub/swift-markdownkit.git", from: "1.1.7"),
    .package(url: "https://github.com/objecthub/swift-commandlinekit.git", from: "0.3.5"),
    .package(url: "https://github.com/objecthub/swift-sqliteexpress.git", from: "1.0.3"),
    .package(url: "https://github.com/objecthub/swift-clformat.git", from: "1.0.10"),
    .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.16"),
    .package(url: "https://github.com/apple/swift-atomics.git", from: "1.1.0")
  ],
  targets: [
    .target(name: "LispKit",
            dependencies: [
              .product(name: "NumberKit", package: "swift-numberkit"),
              .product(name: "MarkdownKit", package: "swift-markdownkit"),
              .product(name: "SQLiteExpress", package: "swift-sqliteexpress"),
              .product(name: "CLFormat", package: "swift-clformat"),
              .product(name: "ZIPFoundation", package: "ZIPFoundation"),
              .product(name: "Atomics", package: "swift-atomics")
            ],
            exclude: [
              "Info.plist",
              "Resources",
              "Graphics/Drawing_iOS.swift",
              "Graphics/Transformation_iOS.swift",
              "Primitives/DrawingLibrary_iOS.swift"
            ]),
    .target(name: "LispKitTools",
            dependencies: [
              .target(name: "LispKit"),
              .product(name: "CommandLineKit", package: "swift-commandlinekit")
            ],
            exclude: [
              "Info.plist"
            ]),
    .executableTarget(name: "LispKitRepl",
                      dependencies: [
                        .target(name: "LispKit"),
                        .target(name: "LispKitTools")
                      ],
                      exclude: [
                        "Info.plist",
                        "BuildMetadata.m",
                        "BuildMetadata.h"
                      ]),
    .testTarget(name: "LispKitTests",
                dependencies: [
                  .target(name: "LispKit")
                ],
                exclude: [
                  "Info.plist",
                  "Code"
                ])
  ],
  swiftLanguageVersions: [.v5]
)
