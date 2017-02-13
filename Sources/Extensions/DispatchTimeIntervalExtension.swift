//
//  DispatchTimeIntervalExtension.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 28.01.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Foundation

public typealias Timespan = DispatchTimeInterval

extension Timespan {
    /// - Returns: The time in seconds using the`TimeInterval` type.
    public var timeInterval: TimeInterval {
        switch self {
        case .seconds(let seconds):
            return Double(seconds)
        case .milliseconds(let milliseconds):
            return Double(milliseconds) / 1_000
        case .microseconds(let microseconds):
            return Double(microseconds) / 1_000_000
        case .nanoseconds(let nanoseconds):
            return Double(nanoseconds) / 1_000_000_000
        }
    }
}
