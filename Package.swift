// swift-tools-version: 6.0
import PackageDescription

// MermaidKit — native Mermaid diagram parsing, layout, and rendering.
//
// pi-work fork of clintecker/MermaidKit @ v1.0.0 (74f62a6).
// Patch: lower the platform floor to macOS 13 / iOS 16 and the manifest to
// swift-tools 6.0, and drop the LinuxRaster trait + Silica/Cairo dependency
// graph. Apple platforms never linked those symbols; every reference is inside
// `#if canImport(SilicaCairo)`. Source code is otherwise unmodified.
// Keep this file as the ONLY divergence from upstream so upgrades stay a
// three-way merge.
let package = Package(
    name: "MermaidKit",
    platforms: [.macOS(.v13), .iOS(.v16), .visionOS(.v1)],
    products: [
        .library(name: "MermaidLayout", targets: ["MermaidLayout"]),
        .library(name: "MermaidRender", targets: ["MermaidRender"]),
    ],
    targets: [
        .target(name: "MermaidLayout", path: "Sources/MermaidLayout"),
        .target(
            name: "MermaidRender",
            dependencies: ["MermaidLayout"],
            path: "Sources/MermaidRender"),
        .testTarget(name: "MermaidLayoutTests", dependencies: ["MermaidLayout"], path: "Tests/MermaidLayoutTests"),
        .testTarget(name: "MermaidRenderTests", dependencies: ["MermaidRender", "MermaidLayout"], path: "Tests/MermaidRenderTests"),
    ]
)
