//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation
import Dispatch

class Timer<T>
{
    private let executable: () -> T
    private var started: DispatchTime?
    private var completed: DispatchTime?

    public init(_ executable: @escaping () -> T)
    {
        self.executable = executable
    }

    public func execute() -> T
    {
        self.started = DispatchTime.now()
        let result = self.executable()
        self.completed =  DispatchTime.now()

        return result
    }

    public func getExecutionTimeInMicroseconds() -> Float?
    {
        if (self.started == nil || self.completed == nil) {
            return nil
        }

        let nanoTime = self.completed!.uptimeNanoseconds - self.started!.uptimeNanoseconds
        return Float(nanoTime) / 1_000
    }

    public func getExecutionTimeAsString() -> String?
    {
        guard let executionTime = self.getExecutionTimeInMicroseconds() else {
            return nil
        }

        let microseconds = Int(executionTime.truncatingRemainder(dividingBy: 1_000))
        let milliseconds = Int(executionTime.truncatingRemainder(dividingBy: 1_000_000) / 1_000)
        let seconds = Int(executionTime / 1_000_000)

        var stringParts: [String] = []
        if (seconds > 0) {
            stringParts.append("\(seconds)s")
        }
        if (milliseconds > 0) {
            stringParts.append("\(milliseconds)ms")
        }
        stringParts.append("\(microseconds)µs")

        return stringParts.joined(separator: " ")
    }
}
