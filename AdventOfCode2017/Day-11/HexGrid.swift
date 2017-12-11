//
// Created by Oliver Schöndorn on 11.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class HexGrid
{
    enum Direction: String
    {
        case north     = "n"
        case northEast = "ne"
        case southEast = "se"
        case south     = "s"
        case southWest = "sw"
        case northWest = "nw"

        public func opposite() -> Direction
        {
            return Direction.opposite(self)
        }

        public static func opposite(_ direction: Direction) -> Direction
        {
            switch direction {
                case .north:        return self.south
                case .northEast:    return self.southWest
                case .southEast:    return self.northWest
                case .south:        return self.north
                case .southWest:    return self.northEast
                case .northWest:    return self.southEast
            }
        }
    }

    private var moves: [Direction: Int]
    public var longestDistance: Int = 0

    public init(_ moveSequence: [String], trackLongestDistance: Bool = false)
    {
        self.moves = [:]
        for direction in moveSequence.map({ Direction(rawValue: $0)! }) {
            if moves[direction.opposite()] != nil && moves[direction.opposite()]! > 0 {
                moves[direction.opposite()]! -= 1
            }
            else if moves[direction] != nil {
                moves[direction]! += 1
            }
            else {
                moves[direction] = 1
            }

            if (trackLongestDistance) {
                self.longestDistance = max(self.longestDistance, self.distanceFromOrigin(moves: self.moves))
            }
        }

        self.moves = self.simplifyMoves()
    }

    private func simplifyMoves(moves: [Direction: Int]? = nil) -> [Direction: Int]
    {
        var moves = moves ?? self.moves

        moves = self.simplifyMove(moves, .northEast, .south, .southEast)
        moves = self.simplifyMove(moves, .northWest, .south, .southEast)

        moves = self.simplifyMove(moves, .southEast, .north, .northEast)
        moves = self.simplifyMove(moves, .southWest, .north, .northWest)

        moves = self.simplifyMove(moves, .northEast, .northWest, .north)
        moves = self.simplifyMove(moves, .southEast, .southWest, .south)

        return moves.filter({ $0.value > 0 })
    }

    private func simplifyMove(_ initialMoves: [Direction: Int], _ dir1: Direction, _ dir2: Direction, _ resultingDir: Direction) -> [Direction: Int]
    {
        var moves = initialMoves

        if moves[dir1] == nil || moves[dir1]! < 1 || moves[dir2] == nil || moves[dir2]! < 1 {
            return moves
        }

        let minMoves = min(moves[dir1]!, moves[dir2]!)
        moves[dir1]! -= minMoves
        moves[dir2]! -= minMoves

        if moves[resultingDir] == nil {
            moves[resultingDir] = minMoves
        }
        else {
            moves[resultingDir]! += minMoves
        }

        return moves
    }

    public func distanceFromOrigin(moves: [Direction: Int]? = nil) -> Int
    {
        let simplifiedMoves = self.simplifyMoves(moves: moves ?? self.moves)
        return simplifiedMoves.reduce(into: 0, { (result: inout Int, move: (key: Direction, value: Int)) in
            result += move.value
        })
    }

    public func getMoves() -> [Direction: Int]
    {
        return self.moves
    }
}
