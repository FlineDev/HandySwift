//
//  Created by Cihat Gündüz on 28.01.17.
//  Copyright © 2017 Flinesoft. All rights reserved.
//

import Foundation

extension DispatchTimeInterval {
    /// - Returns: The time in seconds using the`TimeInterval` type.
    public var timeInterval: TimeInterval {
        switch self {
        case let .seconds(seconds):
            return Double(seconds)

        case let .milliseconds(milliseconds):
            return Double(milliseconds) / Timespan.millisecondsPerSecond

        case let .microseconds(microseconds):
            return Double(microseconds) / Timespan.microsecondsPerSecond

        case let .nanoseconds(nanoseconds):
            return Double(nanoseconds) / Timespan.nanosecondsPerSecond

        case .never:
            return TimeInterval.infinity

        @unknown default:
            fatalError("Unknown DispatchTimeInterval unit.")
        }
    }
}
