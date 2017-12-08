//
// Created by Oliver Schöndorn on 07.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class TowerMapper
{
    public var models: [String: TowerModel]
    public init(_ data: [String: TowerModel])
    {
        self.models = data
        
        // Map models
        for (_, model) in self.models {
            for childTitle in model.childTitles {
                model.children.append(self.models[childTitle]!)
            }
        }
    }

    public func findRootNode() -> TowerModel
    {
        let modelsWithChildren: [TowerModel] = self.models.values.filter({ $0.childTitles.count > 0 }).sorted(by: { (a, b) -> Bool in
            return a.childTitles.count > b.childTitles.count
        })
        var modelsWithParent: [String] = []
        for model in modelsWithChildren {
            for childModel in model.childTitles {
                modelsWithParent.append(childModel)
            }
        }

        return modelsWithChildren.first(where: {
            return !modelsWithParent.contains($0.title)
        })!
    }

    public func mapModels(rootNode root: TowerModel) -> TowerModel
    {
        root.children = root.childTitles.map({ self.mapModels(rootNode: self.getNode($0)) })
        return root
    }
    
    public func findInvalidNode() -> (parent: TowerModel, node: TowerModel, delta: Int)?
    {
        guard let invalidNode = self.searchInvalidNode() else {
            return nil
        }
        
        return self.parseInvalid(node: invalidNode)
    }

    private func parseInvalid(node invalidNode: TowerModel) -> (parent: TowerModel, node: TowerModel, delta: Int)?
    {
        let weights = invalidNode.getChildWeights()
        for (key, child) in invalidNode.children.enumerated() {
            let expectedWeight = child.getTotalWeight()
            if weights.filter({ $0 == expectedWeight }).count < weights.count - 1 {
                return (parent: invalidNode, node: child, delta: expectedWeight - weights[key == 0 ? 1 : 0])
            }
        }
        return nil
    }
    
    private func searchInvalidNode() -> TowerModel?
    {
        for (_, node) in self.models {
            if (!self.isBalanced(node)) {
                let node = self.searchInvalidRecursive(startNode: node)
                return node
            }
        }
        return nil
    }

    private func searchInvalidRecursive(startNode: TowerModel) -> TowerModel
    {
        for child in startNode.children {
            if (!self.isBalanced(child)) {
                return self.searchInvalidRecursive(startNode: child)
            }
        }
        return startNode
    }

    public func findInvalidRecursive(startNode node: TowerModel) -> (parent: TowerModel, node: TowerModel, delta: Int)?
    {
        guard let node = searchInvalidNodeRecursive(node.children) else {
            return nil
        }
        return parseInvalid(node: node)
    }

    private func searchInvalidNodeRecursive(_ nodes: [TowerModel]) -> TowerModel?
    {
        for node in nodes {
            if (!isBalanced(node)) {
                return searchInvalidNodeRecursive(node.children) ?? node
            }
        }
        return nil
    }

    public func isBalanced(_ node: TowerModel) -> Bool
    {
        if (node.children.count == 0) {
            return true
        }

        let childWeights = node.children.map({ $0.getTotalWeight() })
        return Float(childWeights[0]) == Float(childWeights.reduce(0, +))/Float(childWeights.count)
    }

    public func getNode(_ nodeTitle: String) -> TowerModel
    {
        return self.models[nodeTitle]!
    }

    public func getParent(_ nodeTitle: String) -> TowerModel
    {
        return self.models.first(where: { (key: String, value: TowerModel) in
            return value.childTitles.contains(nodeTitle)
        })!.value
    }
}
