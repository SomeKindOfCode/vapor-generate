import PackageDescription

let package = Package(
    name: "VaporToolbox-Generator",
    targets: [
        Target(name: "Executable")
    ],
    dependencies: [
        // Console protocols, terminal, and commands
        .Package(url: "https://github.com/vapor/console.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/json.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/leaf.git", majorVersion: 1)
    ]
)
