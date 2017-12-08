//
// Created by Oliver Schöndorn on 07.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class TowerModel
{
    public let title: String
    public var weight: Int
    public let childTitles: [String]
    public var children: [TowerModel] = []

    private var childWeights: [Int]? = nil
    private var totalWeight: Int? = nil

    public init(title: String, weight: Int, children: [String])
    {
        self.title = title
        self.weight = weight
        self.childTitles = children
    }

    public func getChildWeights() -> [Int]
    {
        return self.children.map({ $0.getTotalWeight() })
        if (self.childWeights == nil) {
            self.childWeights = self.children.map({ $0.getTotalWeight() })
        }
        return self.childWeights!
    }

    public func getTotalWeight() -> Int
    {
        return self.weight + self.getChildWeights().reduce(0, +)
        if (self.totalWeight == nil) {
            self.totalWeight = self.weight + self.getChildWeights().reduce(0, +)
        }
        return self.totalWeight!
    }
}
