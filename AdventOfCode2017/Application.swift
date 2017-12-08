//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

enum terminalColors: String
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

    public func day06Part01Test()
    {
        self.logDayStart(6, part: 1)
        let test = [ 0, 2, 7, 0]
        let manager = MemoryManager(initialConfiguration: test)
        let timer = Timer<Int>({ manager.iterateUntilLoopIsDetected() })
        let counter = timer.execute()

        var testResult: String = ""
        if (counter == 5) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(5)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(counter) did not match the expected value of \(5)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day06Part01()
    {
        self.logDayStart(6, part: 1)
        let data = MemoryManagerDataProvider.getData()
        let manager = MemoryManager(initialConfiguration: data)
        let timer = Timer<Int>({ manager.iterateUntilLoopIsDetected() })
        let counter = timer.execute()

        print("MemoryManager did \(counter) iterations until a loop was detected (\(timer.getExecutionTimeAsString()!))")
    }

    public func day06Part02Test()
    {
        self.logDayStart(6, part: 2)
        let test = [ 0, 2, 7, 0]
        let manager = MemoryManager(initialConfiguration: test)
        let timer = Timer<Int>({
            _ = manager.iterateUntilLoopIsDetected()
            return manager.iterateUntilValueEquals(value: manager.getCurrentConfiguration())
        })
        let counter = timer.execute()

        var testResult: String = ""
        if (counter == 4) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(4)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(counter) did not match the expected value of \(4)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day06Part02()
    {
        self.logDayStart(6, part: 2)
        let data = MemoryManagerDataProvider.getData()
        let manager = MemoryManager(initialConfiguration: data)
        let timer = Timer<Int>({
            _ = manager.iterateUntilLoopIsDetected()
            return manager.iterateUntilValueEquals(value: manager.getCurrentConfiguration())
        })
        let counter = timer.execute()

        print("MemoryManager did \(counter) iterations until a loop was detected (\(timer.getExecutionTimeAsString()!))")
    }

    public func day07Part01Test()
    {
        self.logDayStart(7, part: 1)
        let data = TowerDataProvider.testData
        let parser = TowerParser(data)
        let expectedResult = "tknk"

        let timer = Timer<TowerModel>({
            let mapper = TowerMapper(parser.getParsedData())
            return mapper.findRootNode()
        })

        let rootNode = timer.execute()

        var testResult: String = ""
        if (rootNode.title == expectedResult) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(expectedResult)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(rootNode.title) did not match the expected value of \(expectedResult)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day07Part01()
    {
        self.logDayStart(7, part: 1)
        let data = TowerDataProvider.actualData()
        let parser = TowerParser(data)

        let timer = Timer<TowerModel>({
            let mapper = TowerMapper(parser.getParsedData())
            return mapper.findRootNode()
        })

        let rootNode = timer.execute()

        print("TowerMapper found \(rootNode.title) to be the root node (\(timer.getExecutionTimeAsString()!))")
    }

    public func day07Part02Test()
    {
        self.logDayStart(7, part: 2)
        let data = TowerDataProvider.testData
        let parser = TowerParser(data)
        let expectedResult = 60

        let timer = Timer<(node: TowerModel, correctedWeight: Int)?>({
            let mapper = TowerMapper(parser.getParsedData())
            guard let a = mapper.findInvalidNode() else {
                return nil
            }

            return (node: a.node, correctedWeight: a.node.weight - a.delta)
        })

        guard let rootNode = timer.execute() else {
            print(terminalColors.red.apply(toString: "Did not find a faulty node"))
            return
        }

        var testResult: String = ""
        if (rootNode.correctedWeight == expectedResult) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(expectedResult)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result of \(rootNode.correctedWeight) did not match the expected value of \(expectedResult)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day07Part02()
    {
        self.logDayStart(7, part: 2)

        let data = TowerDataProvider.actualData()
        let parser = TowerParser(data)

        let timer = Timer<(node: TowerModel, correctedWeight: Int)?>({
            let mapper = TowerMapper(parser.getParsedData())
            guard let a = mapper.findInvalidNode() else {
                return nil
            }

            return (node: a.node, correctedWeight: a.node.weight - a.delta)
        })


        guard let rootNode = timer.execute() else {
            print(terminalColors.red.apply(toString: "Did not find a faulty node"))
            return
        }

        print("TowerMapper found \(rootNode.node.title) to be imbalanced. Weight should be \(rootNode.correctedWeight) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part01Test()
    {
        self.logDayStart(8, part: 1)
        let data: [[String]] = [
            "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10"
        ].map({ $0.split(separator: " ").map({ String($0) }) })

        let expectedResult = (key: "a", value: 1)
        let processor = Cpu()

        let timer = Timer<(key: String, value: Int)>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestValueFromRegister()
        })

        let result = timer.execute()

        var testResult: String = ""
        if (result.key == expectedResult.key && result.value == expectedResult.value) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(result.value)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result \(result.value) did not match the expected value of \(expectedResult.value)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part01()
    {
        self.logDayStart(8, part: 1)

        let data = DataProvider.day08()
        let processor = Cpu()

        let timer = Timer<(key: String, value: Int)>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestValueFromRegister()
        })

        let result = timer.execute()

        print("Highest value in Cpu register: \(result.key) => \(result.value) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part02Test()
    {
        self.logDayStart(8, part: 2)
        let data: [[String]] = [
            "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10"
        ].map({ $0.split(separator: " ").map({ String($0) }) })

        let expectedResult = 10
        let processor = Cpu()

        let timer = Timer<Int>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestRuntimeValue()
        })

        let result = timer.execute()

        var testResult: String = ""
        if (result == expectedResult) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(result)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result \(result) did not match the expected value of \(expectedResult)")
        }
        
        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part02()
    {
        self.logDayStart(8, part: 2)

        let data = DataProvider.day08()
        let processor = Cpu()

        let timer = Timer<Int>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestRuntimeValue()
        })

        let result = timer.execute()

        print("Highest runtime value in Cpu register: \(result) (\(timer.getExecutionTimeAsString()!))")
    }
}
