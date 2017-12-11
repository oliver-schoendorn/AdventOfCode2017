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
        let data: [String] = [
            "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10"
        ]/*.map({ $0.split(separator: " ").map({ String($0) }) })*/

        let expectedResult = (key: "a", value: 1)
        let processor = Cpu()

        let timer = Timer<(register: (key: String, value: Int), allTime: Int)>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestValueFromRegister()
        })

        let result = timer.execute()

        var testResult: String = ""
        if (result.register.key == expectedResult.key && result.register.value == expectedResult.value) {
            testResult = terminalColors.green.apply(toString: "Result equals the expected outcome of \(result.register.value)")
        }
        else {
            testResult = terminalColors.red.apply(toString: "Result \(result.register.value) did not match the expected value of \(expectedResult.value)")
        }

        print("Test: \(testResult) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part01()
    {
        self.logDayStart(8, part: 1)

        let data = DataProvider.day08BenchmarkStream()
        let processor = Cpu()

        let timer = Timer<(register: (key: String, value: Int), allTime: Int)>({
            for command in data {
                processor.process(command)
            }

            return processor.getHighestValueFromRegister()
        })

        let result = timer.execute()

        print("Highest value in Cpu register: \(result.register.key) => \(result.register.value), highest value encountered: \(result.allTime) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day08Part02Test()
    {
        self.logDayStart(8, part: 2)
        let data: [String] = [
            "b inc 5 if a > 1",
            "a inc 1 if b < 5",
            "c dec -10 if a >= 1",
            "c inc -20 if c == 10"
        ]/*.map({ $0.split(separator: " ").map({ String($0) }) })*/

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

//        let data = DataProvider.day08Benchmark()
        let data = DataProvider.day08Benchmark()
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

    public func day09Part01Test()
    {
        self.logDayStart(9, part: 1)

        let testGroupCounts: [String: Int] = [
            "{}": 1,
            "{{{}}}": 3,
            "{{},{}}": 3,
            "{{{},{},{{}}}}": 6,
            "{<{},{},{{}}>}": 1,
            "{<a>,<a>,<a>,<a>}": 1,
            "{{<a>},{<a>},{<a>},{<a>}}": 5,
            "{{<!>},{<!>},{<!>},{<a>}}": 2
        ]

        let testScores: [String: Int] = [
            "{}": 1,
            "{{{}}}": 6,
            "{{},{}}": 5,
            "{{{},{},{{}}}}":16,
            "{<a>,<a>,<a>,<a>}": 1,
            "{{<ab>},{<ab>},{<ab>},{<ab>}}": 9,
            "{{<!!>},{<!!>},{<!!>},{<!!>}}": 9,
            "{{<a!>},{<a!>},{<a!>},{<ab>}}": 3,
        ]

        let timer = Timer<String>({
            var result = ""

            var counter = 0
            for (characters, expectedGroupCount) in testGroupCounts {
                counter += 1
                result += "Result for data set #\(counter): "

                let scanner = Scanner(characters)
                scanner.scan()

                if (scanner.groupCounter == expectedGroupCount) {
                    result += terminalColors.green.apply(toString: "Result of \(scanner.groupCounter) does match expected count of \(expectedGroupCount)\n")
                }
                else {
                    result += terminalColors.red.apply(toString: "Result of \(scanner.groupCounter) does NOT match expected count of \(expectedGroupCount)\n")
                }
            }

            result += "\n"

            counter = 0
            for (characters, expectedScore) in testScores {
                counter += 1
                result += "Result for data set #\(counter): "

                let scanner = Scanner(characters)
                scanner.scan()

                if (scanner.score == expectedScore) {
                    result += terminalColors.green.apply(toString: "Result of \(scanner.score) does match expected score of \(expectedScore)\n")
                }
                else {
                    result += terminalColors.red.apply(toString: "Result of \(scanner.score) does NOT match expected score of \(expectedScore)\n")
                }
            }

            return result
        })

        let result = timer.execute()
        print("\(result)\n\(timer.getExecutionTimeAsString()!)")
    }

    public func day09Part01()
    {
        self.logDayStart(9, part: 1)

        let scanner = Scanner(DataProvider.day09())

        let timer = Timer<Int>({
            scanner.scan()
            return scanner.score
        })

        let result = timer.execute()
        print("Scanner returned a score of \(result) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day09Part02()
    {
        self.logDayStart(9, part: 2)

        let scanner = Scanner(DataProvider.day09())

        let timer = Timer<Int>({
            scanner.scan()
            return scanner.garbageCount
        })

        let result = timer.execute()
        print("Scanner returned a garbage character count of \(result) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day10Part01Test()
    {
        self.logDayStart(10, part: 1)
        let testValues = [ 3, 4, 1, 5 ]
        let expectedResult = 12

        let hash = Hash(hashLength: 5)

        let timer = Timer<Int>({
            let responseHash = hash.encrypt(testValues)
            print("Resulting hash: \(responseHash)")
            return responseHash[0] * responseHash[1]
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

    public func day10Part01()
    {
        self.logDayStart(10, part: 1)
        let testValues = DataProvider.day10()

        let hash = Hash()

        let timer = Timer<Int>({
            let responseHash = hash.encrypt(testValues.split(separator: ",").map({ Int($0)! }))
//            print("Resulting hash: \(responseHash)")
            return responseHash[0] * responseHash[1]
        })

        let result = timer.execute()
        print("The product of the first two hash values is \(result) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day10Part02test()
    {
        self.logDayStart(10, part: 2)
        let testValues = [
            "" : "a2582a3a0e66e6e86e3812dcb672a272",
            "AoC 2017" : "33efeb34ea91902bb2f59c9920caa6cd",
            "1,2,3" : "3efbe78a8d82f29979031a4aa0b16a9d",
            "1,2,4" : "63960835bcdc130f0b66d7ff4f6a5a8e"
        ]

        let hash = Hash()

        let timer = Timer<[String:String]>({
            var response: [String:String] = [:]
            for (testValue, expectedValue) in testValues {
                response[hash.encryptString(testValue)] = expectedValue
            }
            return response
        })

        var testResult: String = ""
        for (result, expectedResult) in timer.execute() {
            if (result == expectedResult) {
                testResult += terminalColors.green.apply(toString: "Result equals the expected outcome of \(result)\n")
            }
            else {
                testResult += terminalColors.red.apply(toString: "Result \(result) did not match the expected value of \(expectedResult)\n")
            }
        }

        print("\(testResult)\n(\(timer.getExecutionTimeAsString()!))")
    }

    public func day10Part02()
    {
        self.logDayStart(10, part: 2)
        let string = DataProvider.day10thore()
        let hash = Hash()

        let timer = Timer<String>({
            return hash.encryptString(string)
        })

        let result = timer.execute()

        print("Resulting hash is \(result) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day11Part01test()
    {
        self.logDayStart(10, part: 1)
        let testMoves: [(key: [String], value: [HexGrid.Direction: Int])] = [
            (key: ["ne","ne","ne"], value: [HexGrid.Direction.northEast: 3]),
            (key: ["ne","ne","sw","sw"], value: [:]),
            (key: ["ne","ne","s","s"], value: [HexGrid.Direction.southEast: 2]),
            (key: ["se","sw","se","sw","sw"], value: [HexGrid.Direction.south: 2, HexGrid.Direction.southWest: 1])
        ]

        let timer = Timer<String>({
            var testResult = ""
            for moves in testMoves {
                let grid = HexGrid(moves.key)
                let uniqueMoves = grid.getMoves()

                if (self.validateDay11Part01(uniqueMoves, expected: moves.value)) {
                    testResult += terminalColors.green.apply(toString: "Result equals the expected outcome of \(uniqueMoves.count) unique moves\n")
                }
                else {
                    testResult += terminalColors.red.apply(toString: "Result of \(uniqueMoves.count) did not match the expected value of \(moves.value.count)\n")
                }
            }
            return testResult
        })

        let testResult = timer.execute()
        print("\(testResult)\n(\(timer.getExecutionTimeAsString()!))")
    }

    private func validateDay11Part01(_ result: [HexGrid.Direction: Int], expected: [HexGrid.Direction: Int]) -> Bool
    {
        // Match values
        for expectedMove in expected {
            if result[expectedMove.key] == nil || result[expectedMove.key]! != expectedMove.value {
                return false
            }
        }

        // Look for unwanted indices
        for actualMove in result {
            if expected[actualMove.key] == nil {
                return false
            }
        }

        return true
    }

    public func day11Part01()
    {
        self.logDayStart(11, part: 1)

        let moves = DataProvider.day11()
        let timer = Timer<(moves: [HexGrid.Direction: Int], distance: Int)>({
            let grid = HexGrid(moves)
            return (moves: grid.getMoves(), distance: grid.distanceFromOrigin())
        })

        let result = timer.execute()
        for move in result.moves {
            print("Moved \(move.value) times \(move.key.rawValue)")
        }
        print("Move distance: \(result.distance) (\(timer.getExecutionTimeAsString()!))")
    }

    public func day11Part02()
    {
        self.logDayStart(11, part: 2)

        let moves = DataProvider.day11()
        let timer = Timer<(moves: [HexGrid.Direction: Int], distance: Int, maxDistance: Int)>({
            let grid = HexGrid(moves, trackLongestDistance: true)
            return (moves: grid.getMoves(), distance: grid.distanceFromOrigin(), maxDistance: grid.longestDistance)
        })

        let result = timer.execute()
        for move in result.moves {
            print("Moved \(move.value) times \(move.key.rawValue)")
        }
        print("Move distance: \(result.distance), max distance: \(result.maxDistance) (\(timer.getExecutionTimeAsString()!))")
    }
}
