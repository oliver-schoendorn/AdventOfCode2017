//
// Created by Oliver Schöndorn on 05.11.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class RegularExpression
{
    private let pattern: String;
    private let expression: NSRegularExpression;

    init(pattern: String, options: NSRegularExpression.Options = [])
    {
        self.pattern = pattern
        self.expression = try! NSRegularExpression(pattern: pattern, options: options)
    }

    public func matches(
            string: String,
            options: NSRegularExpression.MatchingOptions = [],
            range: NSRange? = nil
    ) -> [RegularExpressionMatch]
    {
        let matches = self.expression.matches(
                in: string,
                options: options,
                range: self.getRangeIfNecessary(string: string, range: range)
        )

        return matches.map { RegularExpressionMatch(match: $0, string: string) }
    }

    public func test(string: String, range: NSRange? = nil) -> Bool
    {
        return self.expression.matches(in: string, range: self.getRangeIfNecessary(string: string, range: range)).count != 0
    }

    private func getRangeIfNecessary(string: String, range: NSRange?) -> NSRange
    {
        if (range != nil) {
            return range!
        }

        return NSRange(location: 0, length: string.count)
    }
}