# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/).

<details>
<summary>Formatting Rules for Entries</summary>
Each entry should use the following format:

```markdown
- Summary of what was changed in a single line using past tense & followed by two whitespaces.  
  Issue: [#0](https://github.com/Flinesoft/HandySwift/issues/0) | PR: [#0](https://github.com/Flinesoft/HandySwift/pull/0) | Author: [Cihat Gündüz](https://github.com/Jeehut)
```

Note that at the end of the summary line, you need to add two whitespaces (`  `) for correct rendering on GitHub.

If needed, pluralize to `Tasks`, `PRs` or `Authors` and list multiple entries separated by `, `. Also, remove entries not needed in the second line.
</details>

## [Unreleased]
### Added
- New `DivisibleArithmetic` protocol which easily extends `average()` to Collections of `Double`, `Float` and `CGFloat`.  
  Issue: [#36](https://github.com/Flinesoft/HandySwift/issues/36) | PR: [#38](https://github.com/Flinesoft/HandySwift/pull/38) | Author: [David Knothe](https://github.com/knothed)
- Make most of the API `@inlinable` for increased real-time performance.  
  Issue: [#40](https://github.com/Flinesoft/HandySwift/issues/40) | PR: [#43](https://github.com/Flinesoft/HandySwift/pull/43) | Author: [David Knothe](https://github.com/knothed)
### Changed
- Allow `Int.init?(randomBelow:)` to use an arbitrary RandomNumberGenerator (instead of just the system one).  
  PR: [#44](https://github.com/Flinesoft/HandySwift/pull/44) | Author: [David Knothe](https://github.com/knothed)
### Deprecated
- None.
### Removed
- None.
### Fixed
- None.
### Security
- None.

## [3.1.0] - 2019-09-01
### Added
- New `Comparable.clamped(to:)` and `Comparable.clamp(to:)` interfaces for any `Comparable`, e. g. `Int`.

## [3.0.0] - 2019-04-30
### Added
- New `Withable` protocol to init/copy objects and set properties in a convenient way on a single line.
### Changed
- Upgraded to Swift 5 & Xcode 10.2.
### Removed
- Remove `ExpressibleByStringLiteral` conformance of `Regex` type to only allow initialization via `init(_:options:) throws` interface.

## [2.8.0] - 2019-02-11
### Added
- New `NSRange(_:in:)` initializer for converting from `Range<String.Index>`
- New `sum` computed property on `Sequence` types like `Array`
- New `average` computed property on `Collection` types with `Int` or `Double` elements like `[Int]`
- New `fullRange` and `fullNSRange` computed properties on `String`
### Changed
- Made some APIs available in wider contexts (like `sample` in `RandomAccessCollection` instead of `Array`)

## [2.7.0] - 2018-09-27
### Added
- Official support for Linux & Swift Package Manager.
### Removed
- Support for Swift 4.1 and lower was dropped.

## [2.6.0] - 2018-04-22
### Added
- New swifty `Regex` type built on top of the NSRegularExpression API.
