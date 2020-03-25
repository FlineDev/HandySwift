// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

@testable import HandySwiftTests
import XCTest

// swiftlint:disable line_length file_length

extension ArrayExtensionTests {
    static var allTests: [(String, (ArrayExtensionTests) -> () throws -> Void)] = [
        ("testSample", testSample),
        ("testSampleWithSize", testSampleWithSize),
        ("testCombinationsWithOther", testCombinationsWithOther),
        ("testSortByStable", testSortByStable),
        ("testSortedByStable", testSortedByStable)
    ]
}

extension CollectionExtensionTests {
    static var allTests: [(String, (CollectionExtensionTests) -> () throws -> Void)] = [
        ("testTrySubscript", testTrySubscript),
        ("testSum", testSum),
        ("testAverage", testAverage)
    ]
}

extension ComparableExtensionTests {
    static var allTests: [(String, (ComparableExtensionTests) -> () throws -> Void)] = [
        ("testClampedClosedRange", testClampedClosedRange),
        ("testClampedPartialRangeFrom", testClampedPartialRangeFrom),
        ("testClampedPartialRangeThrough", testClampedPartialRangeThrough),
        ("testClampClosedRange", testClampClosedRange),
        ("testClampPartialRangeFrom", testClampPartialRangeFrom),
        ("testClampPartialRangeThrough", testClampPartialRangeThrough)
    ]
}

extension DictionaryExtensionTests {
    static var allTests: [(String, (DictionaryExtensionTests) -> () throws -> Void)] = [
        ("testInitWithSameCountKeysAndValues", testInitWithSameCountKeysAndValues),
        ("testInitWithDifferentCountKeysAndValues", testInitWithDifferentCountKeysAndValues),
        ("testMergeOtherDictionary", testMergeOtherDictionary),
        ("testMergedWithOtherDicrionary", testMergedWithOtherDicrionary)
    ]
}

extension DispatchTimeIntervalExtensionTests {
    static var allTests: [(String, (DispatchTimeIntervalExtensionTests) -> () throws -> Void)] = [
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

extension IntExtensionTests {
    static var allTests: [(String, (IntExtensionTests) -> () throws -> Void)] = [
        ("testInitRandomBelow", testInitRandomBelow),
        ("testTimesMethod", testTimesMethod),
        ("testTimesMakeMethod", testTimesMakeMethod)
    ]
}

extension NSRangeExtensionTests {
    static var allTests: [(String, (NSRangeExtensionTests) -> () throws -> Void)] = [
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

extension StringExtensionTests {
    static var allTests: [(String, (StringExtensionTests) -> () throws -> Void)] = [
        ("testStrip", testStrip),
        ("testIsBlank", testIsBlank),
        ("testInitRandomWithLengthAllowedCharactersType", testInitRandomWithLengthAllowedCharactersType),
        ("testSample", testSample),
        ("testSampleWithSize", testSampleWithSize),
        ("testFullRange", testFullRange)
    ]
}

extension TimeIntervalExtensionTests {
    static var allTests: [(String, (TimeIntervalExtensionTests) -> () throws -> Void)] = [
        ("testUnitInitialization", testUnitInitialization),
        ("testUnitConversion", testUnitConversion)
    ]
}

extension WithableTests {
    static var allTests: [(String, (WithableTests) -> () throws -> Void)] = [
        ("testInitWith", testInitWith),
        ("testWith", testWith)
    ]
}

XCTMain([
    testCase(ArrayExtensionTests.allTests),
    testCase(CollectionExtensionTests.allTests),
    testCase(ComparableExtensionTests.allTests),
    testCase(DictionaryExtensionTests.allTests),
    testCase(DispatchTimeIntervalExtensionTests.allTests),
    testCase(FrequencyTableTests.allTests),
    testCase(GlobalsTests.allTests),
    testCase(IntExtensionTests.allTests),
    testCase(NSRangeExtensionTests.allTests),
    testCase(RegexTests.allTests),
    testCase(SortedArrayTests.allTests),
    testCase(StringExtensionTests.allTests),
    testCase(TimeIntervalExtensionTests.allTests),
    testCase(WithableTests.allTests)
])
