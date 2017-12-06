//
// Created by Oliver Schöndorn on 06.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class MemoryManager
{
    private var currentConfiguration: [Int]
    private var pastConfigurations: [[Int]] = []

    public init(initialConfiguration: [Int])
    {
        self.currentConfiguration = initialConfiguration
    }

    public func getCurrentConfiguration() -> [Int]
    {
        return self.currentConfiguration
    }

    public func iterate()
    {
        self.pastConfigurations.append(self.currentConfiguration)

        let index = self.bankWithHighestAmount()
        let iterations = self.currentConfiguration[index]
        self.currentConfiguration[index] = 0

        for i in 0..<iterations {
            let actualIndex = Int(Float(i+index+1).truncatingRemainder(dividingBy: Float(self.currentConfiguration.count)))
            self.currentConfiguration[actualIndex] += 1
        }
    }

    public func iterateUntilLoopIsDetected() -> Int
    {
        var counter: Int = 0
        repeat {
            counter += 1
            self.iterate()
        } while(self.isCurrentConfigurationKnown() == false)
        return counter
    }

    public func iterateUntilValueEquals(value startingValue: [Int]) -> Int
    {
        var counter: Int = 0
        repeat {
            counter += 1
            self.iterate()
        } while(startingValue != self.currentConfiguration)
        return counter
    }

    public func isCurrentConfigurationKnown() -> Bool
    {
        return self.pastConfigurations.contains(where: { $0 == self.currentConfiguration })
    }

    private func bankWithHighestAmount() -> Int
    {
        var index: Int = 0
        var highestValue: Int = 0

        for (key, value) in self.currentConfiguration.enumerated() {
            if value > highestValue {
                highestValue = value
                index = key
            }
        }

        return index
    }
}
