//
// Created by Oliver Schöndorn on 08.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class Cpu
{
    enum Action: String
    {
        case increment = "inc"
        case decrement = "dec"
    }

    enum Comparison: String
    {
        case equals = "=="
        case notEquals = "!="
        case lessThan = "<"
        case lessThanOrEquals = "<="
        case greaterThan = ">"
        case greaterThanOrEquals = ">="
    }

    struct Command
    {
        public let variable: String
        public let action: Action
        public let value: Int
        public let comparisonVariable: String
        public let comparison: Comparison
        public let comparisonValue: Int

        public init(
            variable: String,
            action: String,
            value: Int,
            comparisonVariable: String,
            comparison: String,
            comparisonValue: Int
        ) {
            self.variable = variable
            self.action = Action(rawValue: action)!
            self.value = value
            self.comparisonVariable = comparisonVariable
            self.comparison = Comparison(rawValue: comparison)!
            self.comparisonValue = comparisonValue
        }
    }

    private var register: [String: Int] = [:]
    private var highestValue: Int = 0
    private let trimmingCharacterSet = CharacterSet(charactersIn: "\n")

    public func getHighestValueFromRegister() -> (register: (key: String, value: Int), allTime: Int)
    {
        return ( register: self.register.max(by: { (a: (key: String, value: Int), b: (key: String, value: Int)) -> Bool in
            return a.value < b.value
        })!, allTime: self.highestValue)
    }

    public func getHighestRuntimeValue() -> Int
    {
        return self.highestValue
    }

    public func process(_ command: String)
    {
        let command = self.parseCommand(command)
        self.executeCommand(command)
    }

    private func parseCommand(_ command: String) -> Command
    {
        let command = command.split(separator: " ")
        return Command(
            variable: String(command[0]),
            action: String(command[1]),
            value: Int(command[2])!,
            comparisonVariable: String(command[4]),
            comparison: String(command[5]),
            comparisonValue: Int(command[6].trimmingCharacters(in: self.trimmingCharacterSet))!
        )
    }

    private func executeCommand(_ command: Command)
    {
        if (self.conditionMet(command)) {
            var variable = self.getVar(command.variable)
            switch (command.action) {
                case .increment:
                    variable += command.value
                    break

                case .decrement:
                    variable -= command.value
                    break
            }
            self.setVar(command.variable, value: variable)
        }
    }

    private func conditionMet(_ command: Command) -> Bool
    {
        let variable = self.getVar(command.comparisonVariable)
        switch (command.comparison) {
            case .equals:               return variable == command.comparisonValue
            case .notEquals:            return variable != command.comparisonValue
            case .lessThan:             return variable <  command.comparisonValue
            case .lessThanOrEquals:     return variable <= command.comparisonValue
            case .greaterThan:          return variable >  command.comparisonValue
            case .greaterThanOrEquals:  return variable >= command.comparisonValue
        }
    }

    private func getVar(_ name: String) -> Int
    {
        return self.register[name] ?? 0
    }

    private func setVar(_ name: String, value: Int)
    {
        self.highestValue = max(self.highestValue, value)
        self.register[name] = value
    }
}
