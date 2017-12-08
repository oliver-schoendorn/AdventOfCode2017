//
// Created by Oliver Schöndorn on 05.11.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class RegularExpressionMatch
{
    private let match: NSTextCheckingResult
    private let string: String

    public let ranges: [NSRange]
    public let numberOfRanges: Int

    init(match: NSTextCheckingResult, string: String)
    {
        self.match = match
        self.string = string

        // Store ranges
        var ranges: [NSRange] = []
        for i in 0 ..< match.numberOfRanges {
            let range = match.range(at: i)

            // Ignore invalid ranges
            if (range.location == NSNotFound) {
                continue
            }

            ranges.append(range)
        }
        self.ranges = ranges
        self.numberOfRanges = ranges.count
    }

    public func getRange(at index: Int) -> NSRange
    {
        return self.ranges[index]
    }

    public func getMatchedString(at index: Int) -> String
    {
        let range = self.getRange(at: index)
        return (self.string as NSString).substring(with: range) as String
    }

    public func getMatchedStrings(skipFullMatch: Bool = false) -> [String]
    {
        var matchedStrings: [String] = []
        for i in (skipFullMatch ? 1 : 0) ..< self.numberOfRanges {
            matchedStrings.append(self.getMatchedString(at: i))
        }
        return matchedStrings
    }
}