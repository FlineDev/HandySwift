// Generated using Sourcery 1.0.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import HandySwiftTests
import XCTest

// swiftlint:disable line_length file_length

extension ArrayExtTests {
    static var allTests: [(String, (ArrayExtTests) -> () throws -> Void)] = [
        ("testSample", testSample),
        ("testSampleWithSize", testSampleWithSize),
        ("testCombinationsWithOther", testCombinationsWithOther),
        ("testSortByStable", testSortByStable),
        ("testSortedByStable", testSortedByStable)
    ]
}

extension CollectionExtTests {
    static var allTests: [(String, (CollectionExtTests) -> () throws -> Void)] = [
        ("testTrySubscript", testTrySubscript),
        ("testSum", testSum),
        ("testAverage", testAverage)
    ]
}

extension ComparableExtTests {
    static var allTests: [(String, (ComparableExtTests) -> () throws -> Void)] = [
        ("testClampedClosedRange", testClampedClosedRange),
        ("testClampedPartialRangeFrom", testClampedPartialRangeFrom),
        ("testClampedPartialRangeThrough", testClampedPartialRangeThrough),
        ("testClampClosedRange", testClampClosedRange),
        ("testClampPartialRangeFrom", testClampPartialRangeFrom),
        ("testClampPartialRangeThrough", testClampPartialRangeThrough)
    ]
}

extension DictionaryExtTests {
    static var allTests: [(String, (DictionaryExtTests) -> () throws -> Void)] = [
        ("testInitWithSameCountKeysAndValues", testInitWithSameCountKeysAndValues),
        ("testInitWithDifferentCountKeysAndValues", testInitWithDifferentCountKeysAndValues),
        ("testMergeOtherDictionary", testMergeOtherDictionary),
        ("testMergedWithOtherDicrionary", testMergedWithOtherDicrionary)
    ]
}

extension DispatchTimeIntervalExtTests {
    static var allTests: [(String, (DispatchTimeIntervalExtTests) -> () throws -> Void)] = [
        ("testTimeInterval", testTimeInterval)
    ]
}

extension FrequencyTableTests {
    static var allTests: [(String, (FrequencyTableTests) -> () throws -> Void)] = [
        ("testSample", testSample),
        ("testSampleWithSize", testSampleWithSize)
    ]
}

extension GlobalsTests {
    static var allTests: [(String, (GlobalsTests) -> () throws -> Void)] = [
        ("testDelayed", testDelayed)
    ]
}

extension IntExtTests {
    static var allTests: [(String, (IntExtTests) -> () throws -> Void)] = [
        ("testInitRandomBelow", testInitRandomBelow),
        ("testTimesMethod", testTimesMethod),
        ("testTimesMakeMethod", testTimesMakeMethod)
    ]
}

extension NSObjectExtTests {
    static var allTests: [(String, (NSObjectExtTests) -> () throws -> Void)] = [
        ("testWith", testWith)
    ]
}

extension NSRangeExtTests {
    static var allTests: [(String, (NSRangeExtTests) -> () throws -> Void)] = [
        ("testInitWithSwiftRange", testInitWithSwiftRange)
    ]
}

extension RegexTests {
    static var allTests: [(String, (RegexTests) -> () throws -> Void)] = [
        ("testValidInitialization", testValidInitialization),
        ("testInvalidInitialization", testInvalidInitialization),
        ("testOptions", testOptions),
        ("testMatchesBool", testMatchesBool),
        ("testFirstMatch", testFirstMatch),
        ("testMatches", testMatches),
        ("testReplacingMatches", testReplacingMatches),
        ("testReplacingMatchesWithSpecialCharacters", testReplacingMatchesWithSpecialCharacters),
        ("testMatchString", testMatchString),
        ("testMatchRange", testMatchRange),
        ("testMatchCaptures", testMatchCaptures),
        ("testMatchStringApplyingTemplate", testMatchStringApplyingTemplate),
        ("testEquatable", testEquatable),
        ("testRegexCustomStringConvertible", testRegexCustomStringConvertible),
        ("testMatchCustomStringConvertible", testMatchCustomStringConvertible)
    ]
}

extension SortedArrayTests {
    static var allTests: [(String, (SortedArrayTests) -> () throws -> Void)] = [
        ("testInitialization", testInitialization),
        ("testFirstMatchingIndex", testFirstMatchingIndex),
        ("testSubArrayToIndex", testSubArrayToIndex),
        ("testSubArrayFromIndex", testSubArrayFromIndex),
        ("testCollectionFeatures", testCollectionFeatures)
    ]
}

extension StringExtTests {
    static var allTests: [(String, (StringExtTests) -> () throws -> Void)] = [
        ("testStrip", testStrip),
        ("testIsBlank", testIsBlank),
        ("testInitRandomWithLengthAllowedCharactersType", testInitRandomWithLengthAllowedCharactersType),
        ("testSample", testSample),
        ("testSampleWithSize", testSampleWithSize),
        ("testFullRange", testFullRange)
    ]
}

extension TimeIntervalExtTests {
    static var allTests: [(String, (TimeIntervalExtTests) -> () throws -> Void)] = [
        ("testUnitInitialization", testUnitInitialization),
        ("testUnitConversion", testUnitConversion)
    ]
}

extension WithableTests {
    static var allTests: [(String, (WithableTests) -> () throws -> Void)] = [
        ("testWith", testWith)
    ]
}

XCTMain([
    testCase(ArrayExtTests.allTests),
    testCase(CollectionExtTests.allTests),
    testCase(ComparableExtTests.allTests),
    testCase(DictionaryExtTests.allTests),
    testCase(DispatchTimeIntervalExtTests.allTests),
    testCase(FrequencyTableTests.allTests),
    testCase(GlobalsTests.allTests),
    testCase(IntExtTests.allTests),
    testCase(NSObjectExtTests.allTests),
    testCase(NSRangeExtTests.allTests),
    testCase(RegexTests.allTests),
    testCase(SortedArrayTests.allTests),
    testCase(StringExtTests.allTests),
    testCase(TimeIntervalExtTests.allTests),
    testCase(WithableTests.allTests)
])
