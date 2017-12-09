//
// Created by Oliver Schöndorn on 08.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class FileStream: Sequence
{
    private let file: UnsafeMutablePointer<FILE>!

    public init(path: String)
    {
        self.file = fopen(path, "r")
        if self.file == nil {
            fatalError("Unable to open \(path)")
        }
    }

    deinit {
        self.close()
    }

    public func readLine() -> String?
    {
        var line:UnsafeMutablePointer<CChar>? = nil
        var lineCap:Int = 0

        defer { free(line) }
        return getline(&line, &lineCap, self.file) > 0 ? String(cString: line!) : nil
    }

    func makeIterator() -> AnyIterator<String>
    {
        return AnyIterator<String>({
            return self.readLine()
        })
    }

    public func close()
    {
        fclose(self.file)
    }
}
