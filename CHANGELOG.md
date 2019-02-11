# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- New `NSRange(_:in:)` initializer for converting from `Range<String.Index>`
- New `sum` computed property on `Sequence` types like `Array`
- New `average` computed property on `Collection` types with `Int` or `Double` elements like `[Int]`
- New `fullRange` and `fullNSRange` computed properties on `String`
### Changed
- Made some APIs available in wider contexts (like `sample` in `RandomAccessCollection` instead of `Array`) 
### Deprecated
- None.
### Removed
- None.
### Fixed
- None.
### Security
- None.

## [2.7.0] - 2018-09-27
### Added
- Official support for Linux & Swift Package Manager.
### Removed
- Support for Swift 4.1 and lower was dropped.

## [2.6.0] - 2018-04-22
### Added
- New swifty `Regex` type built on top of the NSRegularExpression API.
