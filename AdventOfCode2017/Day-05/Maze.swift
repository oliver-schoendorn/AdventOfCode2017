//
// Created by Oliver Schöndorn on 05.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class Maze
{
    private var maze: [Int]
    private let part: Int
    private var position: Int = 0

    public init(_ maze: [Int], forPart part: Int)
    {
        self.maze = maze
        self.part = part
    }

    public func iterate() -> Bool
    {
        // Get the jump command for the current position
        let jumpOffset: Int = self.maze[self.position]

        // Increment current jump offset
        if (self.part == 1) {
            self.maze[self.position] += 1
        }
        else {
            self.maze[self.position] += jumpOffset >= 3 ? -1 : 1
        }

        // Make sure the next maze index exists
        if ( !self.maze.indices.contains(self.position + jumpOffset)) {
            return false
        }

        // Index if valid -> update position
        self.position += jumpOffset
        return true
    }

    public func iterateUntilOutOfBounds() -> Int
    {
        var iterations = 0
        var canIterate = false
        repeat {
            iterations += 1
            canIterate = self.iterate()
        } while(canIterate)
        return iterations
    }

    public func getMaze() -> [Int]
    {
        return self.maze
    }
}
