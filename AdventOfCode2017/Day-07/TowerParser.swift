//
// Created by Oliver Schöndorn on 07.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class TowerParser
{
    private let expression = RegularExpression(pattern: "(?<name>\\w+)\\s\\((?<weight>\\d+)\\)(?:\\s\\-\\>\\s(?<groups>.*))*\\n*")
    public let parsedData: [TowerModel]

    public init(_ data: String)
    {
        let results = self.expression.matches(string: data, options: .anchored)
        self.parsedData = results.map({ (result: RegularExpressionMatch) -> TowerModel in
            let matches = result.getMatchedStrings(skipFullMatch: true)
            return TowerModel(
                title: matches[0],
                weight: Int(matches[1])!,
                children: matches.count > 2
                    ? matches[2].split(separator: ",").map({ String($0).trimmingCharacters(in: CharacterSet(charactersIn: " ")) })
                    : []
            )
        })
    }

    public func getParsedData() -> [String:TowerModel]
    {
        var out: [String:TowerModel] = [:]
        for model in self.parsedData {
            out[model.title] = model
        }
        return out
    }
}
