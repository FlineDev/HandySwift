import WorkspaceConfiguration
import SDGControlFlow
// SDGCornerstone, https://github.com/SDGGiesbrecht/SDGCornerstone, 6.0.0, SDGControlFlow

let configuration = WorkspaceConfiguration()
configuration.optIntoAllTasks()

configuration.supportedPlatforms = [.amazonLinux, .android, .centOS, .iOS, .macOS, .tvOS, .ubuntu, .watchOS, .web, .windows]
configuration.documentation.currentVersion = Version(3, 2, 1)
configuration.documentation.repositoryURL = URL(string: "https://github.com/Flinesoft/HandySwift")

configuration.documentation.api.yearFirstPublished = 2015

configuration.documentation.localisations = ["en-US"]
configuration.documentation.api.copyrightNotice = Lazy<[LocalisationIdentifier: StrictString]>(
  resolve: { configuration in
    return [
      "en-US": "Copyright (c) #dates \(configuration.documentation.primaryAuthor!).",
    ]
  })

configuration.documentation.primaryAuthor = "Flinesoft (alias Cihat Gündüz)"
