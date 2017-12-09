//
// Created by Oliver Schöndorn on 09.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class Scanner
{
    private var string: String
    public var groupCounter = 0
    public var groupDepth = 0
    public var inGarbage = false
    public var ignoreCharacter = false
    public var score = 0
    public var garbageCount = 0

    public init(_ string: String)
    {
        self.string = string
    }

    public func scan()
    {
        for index in self.string.indices {
            if self.ignoreCharacter {
                self.ignoreCharacter = false
                continue
            }

            let letter: Character = self.string[index]

            if letter == "!" {
                self.ignoreCharacter = true
                continue
            }

            if self.inGarbage == true {
                if (letter == ">") {
                    self.inGarbage = false
                }
                else {
                    self.garbageCount += 1
                }
                continue
            }

            if letter == "<" {
                self.inGarbage = true
                continue
            }


            if letter == "{" {
                self.groupCounter += 1
                self.groupDepth += 1
                self.score += self.groupDepth
            }
            else if letter == "}" {
                self.groupDepth -= 1
            }
        }
    }
}
