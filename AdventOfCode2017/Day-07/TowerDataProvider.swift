//
// Created by Oliver Schöndorn on 07.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class TowerDataProvider
{
    public static let testData = [
        "pbga (66)",
        "xhth (57)",
        "ebii (61)",
        "havc (66)",
        "ktlj (57)",
        "fwft (72) -> ktlj, cntj, xhth",
        "qoyq (66)",
        "padx (45) -> pbga, havc, qoyq",
        "tknk (41) -> ugml, padx, fwft",
        "jptl (61)",
        "ugml (68) -> gyxo, ebii, jptl",
        "gyxo (61)",
        "cntj (57)"
    ].joined(separator: "\n")

    public static func actualData() -> String
    {
        guard let filePath = Bundle.main.url(forResource: "day07", withExtension: "benchmark") else {
            NSLog("Could not find file path for day07.data")
            return ""
        }

        return try! String(contentsOf: filePath)
    }
}
