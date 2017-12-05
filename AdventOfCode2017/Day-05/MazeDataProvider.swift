//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class MazeDataProvider
{
    public static let part01TestData: [Int] = [
        0, 3,  0, 1,  -3
    ]

    public static let part01ExpectedResult: Int = 5
    public static let part02ExpectedResult: Int = 10

    public static func part01RealData() -> [Int]
    {
        guard let filePath = Bundle.main.url(forResource: "day05", withExtension: "data") else {
            NSLog("Could not find file path for day05.data")
            return []
        }

        let fileContents = try! String(contentsOf: filePath).split(separator: "\n")
        return fileContents.map({ Int($0)! })
    }
}
