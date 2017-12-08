//
// Created by Oliver Schöndorn on 06.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class MemoryManager
{
    private var currentConfiguration: [Int]
    private var pastConfigurations: [String] = []

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
        self.pastConfigurations.append(self.currentConfiguration.map({ String($0) }).joined())

        let index = self.bankWithHighestAmount()
        let iterations = self.currentConfiguration[index]
        self.currentConfiguration[index] = 0

        for i in 1...iterations {
            let actualIndex = (i+index) % self.currentConfiguration.count
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
        } while(startingValue.map({ String($0) }).joined() != self.currentConfiguration.map({ String($0) }).joined())
        return counter
    }

    public func isCurrentConfigurationKnown() -> Bool
    {
        let currentConfig: String = self.currentConfiguration.map({ String($0) }).joined()
        return self.pastConfigurations.contains(currentConfig)
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
