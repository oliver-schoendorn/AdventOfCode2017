//
// Created by Oliver Schöndorn on 08.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class DataProvider
{
    public static func day08() -> [String]
    {
        return parseDay08(readFile("day08"))
    }
    public static func day08Benchmark() -> [String]
    {
        return parseDay08(readFile("day08", withExtension: "benchmark"))
    }

    public static func day08BenchmarkStream() -> FileStream
    {
        return FileStream(path: "day08.benchmark")
    }

    private static func parseDay08(_ input: String) -> [String]
    {
        return input
            .split(separator: "\n")
            .map({
                /*$0.split(separator: " ")
                  .map({ String($0) })*/
                String($0)
            })
    }

    public static func day09() -> String
    {
        return readFile("day09")
    }

    public static func day10() -> String
    {
        return readFile("day10")
    }

    public static func day10thore() -> String
    {
        return readFile("day10-thore")
    }

    private static func readFile(_ name: String, withExtension: String = "data") -> String
    {
        guard let filePath = Bundle.main.url(forResource: name, withExtension: withExtension) else {
            NSLog("Could not find file path for \(name).\(withExtension)")
            return ""
        }

        return try! String(contentsOf: filePath)
    }
}
