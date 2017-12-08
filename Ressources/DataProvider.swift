//
// Created by Oliver Schöndorn on 08.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class DataProvider
{
    public static func day08() -> [[String]]
    {
        return readFile("day08")
            .split(separator: "\n")
            .map({
                $0.split(separator: " ")
                  .map({ String($0) })
            })
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
