//
//  Globals.swift
//  HandySwift
//
//  Created by Cihat Gündüz on 07.06.16.
//  Copyright © 2016 Flinesoft. All rights reserved.
//

import Foundation

/// Runs code with delay given in seconds. Uses the main thread if not otherwise specified.
///
/// - Parameters:
///   - delayTime: The duration of the delay. E.g. `.seconds(1)` or `.milliseconds(200)`.
///   - qosClass: The global QOS class to be used or `nil` to use the main thread. Defaults to `nil`.
///   - closure: The code to run with a delay.
public func delay(by delayTime: Timespan, qosClass: DispatchQoS.QoSClass? = nil, _ closure: @escaping () -> Void) {
    let dispatchQueue = qosClass != nil ? DispatchQueue.global(qos: qosClass!) : DispatchQueue.main
    dispatchQueue.asyncAfter(deadline: DispatchTime.now() + delayTime, execute: closure)
}

/// Executes passed closure every Timespan interval.
///
/// - Parameters:
///   - interval: Execution interval duration
///   - queue: Dispatch queue for execution. Defaults to global
///   - qos: Quality of service. Defaults to .default
///   - leeway: Allowed leeway between executions. Defaults to .milliseconds(10)
///   - closure: Block of code to run
/// - Returns: Timer object
public func every(
    _ interval: Timespan,
    queue: DispatchQueue = DispatchQueue.global(),
    qos: DispatchQoS = .default,
    leeway: DispatchTimeInterval = .milliseconds(10),
    _ closure: @escaping DispatchSourceProtocol.DispatchSourceHandler
) -> DispatchSourceTimer {
    let timer = DispatchSource.makeTimerSource(queue: queue)
    timer.setEventHandler(qos: qos, handler: closure)
    timer.scheduleRepeating(deadline: .now(), interval: interval, leeway: leeway)
    timer.resume()
    return timer
}
