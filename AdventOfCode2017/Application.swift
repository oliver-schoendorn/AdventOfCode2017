//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class Application
{
    private var currentRiddle: (day: Int, part: Int) = (-1, -1)

    public func logDayStart(_ day: Int, part: Int)
    {
        if (self.currentRiddle.day == day && self.currentRiddle.part == part) {
            return
        }

        print(terminalColors.cyan.apply(toString: "\n############### Day \(day) – Part \(part) ###############"))
        self.currentRiddle = (day, part)
    }

    public func logDayEnd(_ day: Int, part: UInt8, result: String)
    {
        print("Result for Day \(day) – Part \(part) is: \(result)\n")
    }

    private enum terminalColors: String
    {
        case black =    "0;30"
        case red =      "0;31"
        case green =    "0;32"
        case yellow =   "0;33"
        case blue =     "0;34"
        case magenta =  "0;35"
        case cyan =     "0;36"
        case white =    "0;37"
        case none =     "0;0"

        public func apply(toString: String) -> String
        {
            return "\u{001B}[\(self.rawValue)m\(toString)\u{001B}[0;0m"
        }
    }

    public func day05Part01Test()
    {
        self.logDayStart(5, part: 1)

        let expectedResult = MazeDataProvider.part01ExpectedResult
        let maze = Maze(MazeDataProvider.part01TestData, forPart: 1)
        let timer = Timer<Int>({ maze.iterateUntilOutOfBounds() })
        let iterations = timer.execute()

        var testResult: String = ""
        if (iterations == expectedResult) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(expectedResult)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(iterations) did not match the expected value of \(expectedResult)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day05Part01()
    {
        self.logDayStart(5, part: 1)

        let maze = Maze(MazeDataProvider.part01RealData(), forPart: 1)
        let timer = Timer<Int>({ maze.iterateUntilOutOfBounds() })
        let iterations = timer.execute()

        let result: String = "Maze could be iterate \(iterations) times until the offset was out of bounds"
        print("\(result) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day05Part02Test()
    {
        self.logDayStart(5, part: 2)

        let expectedResult = MazeDataProvider.part02ExpectedResult
        let maze = Maze(MazeDataProvider.part01TestData, forPart: 2)
        let timer = Timer<Int>({ maze.iterateUntilOutOfBounds() })
        let iterations = timer.execute()

        var testResult: String = ""
        if (iterations == expectedResult) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(expectedResult)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(iterations) did not match the expected value of \(expectedResult)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day05Part02()
    {
        self.logDayStart(5, part: 2)

        let maze = Maze(MazeDataProvider.part01RealData(), forPart: 2)
        let timer = Timer<Int>({ maze.iterateUntilOutOfBounds() })
        let iterations = timer.execute()

        print("Maze could be iterate \(iterations) times until the offset was out of bounds (\(timer.getExecutionTimeAsString()!))")
    }
}
