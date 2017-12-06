//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class MemoryManagerDataProvider
{
    public static func getData() -> [Int]
    {
        guard let filePath = Bundle.main.url(forResource: "day06", withExtension: "data") else {
            NSLog("Could not find file path for day06.data")
            return []
        }

        let fileContents = try! String(contentsOf: filePath).split(separator: "\n")
        return fileContents.map({ Int($0)! })
    }
}
