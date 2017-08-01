import PackageDescription
 
let package = Package(
    name: "App",
    dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git", majorVersion: 1),
    ]
)
