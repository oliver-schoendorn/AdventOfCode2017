//
// Created by Oliver Schöndorn on 10.12.17.
// Copyright (c) 2017 OSwebstyle. All rights reserved.
//

import Foundation

class Hash
{
    private let hashLength: Int

    public init(hashLength: Int = 256)
    {
        self.hashLength = hashLength
    }

    public func encrypt(_ lengths: [Int]) -> [Int]
    {
        return self.encryptionRoundTrip(lengths: lengths, hash: self.prepareHash(), initialSkipSize: 0, initialPointer: 0).hash
    }

    private func encryptionRoundTrip(
        lengths: [Int],
        hash initialHash: [Int],
        initialSkipSize: Int,
        initialPointer: Int
    ) -> (hash: [Int], skipSize: Int, pointer: Int)
    {
        var hash = initialHash
        var pointer: Int = initialPointer
        var skipSize = initialSkipSize

        for rawLength in lengths {
            let length = rawLength - 1
            for i in 0...length/2 {
                hash.swapAt((pointer+i) % self.hashLength, ((pointer+length)-i) % self.hashLength)
            }
            pointer = (pointer + rawLength + skipSize) % self.hashLength
            skipSize += 1
        }

        return (hash: hash, skipSize: skipSize, pointer: pointer)
    }

    public func encryptString(_ string: String) -> String
    {
        var pointer: Int = 0
        var skipSize: Int = 0
        var hash = self.prepareHash()
        let lengths = self.appendStandardSuffix(self.stringToInt(string))

        for _ in 0..<64 {
            let result = self.encryptionRoundTrip(lengths: lengths, hash: hash, initialSkipSize: skipSize, initialPointer: pointer)
            hash = result.hash
            skipSize = result.skipSize
            pointer = result.pointer
        }

        let denseHash = self.createDenseHash(sparseHash: hash)
        return denseHash.map({ String(format: "%02x", $0) }).joined()
    }

    private func prepareHash() -> [Int]
    {
        var hash: [Int] = []
        for i in 0..<self.hashLength {
            hash.append(i)
        }
        return hash
    }

    private func stringToInt(_ string: String) -> [Int]
    {
        return string.unicodeScalars.map({ Int(UInt32($0)) })
    }

    private func appendStandardSuffix(_ lengths: [Int]) -> [Int]
    {
        var mutableLengths = lengths
        for length in [17, 31, 73, 47, 23] {
            mutableLengths.append(length)
        }
        return mutableLengths
    }

    private func createDenseHash(sparseHash: [Int]) -> [Int]
    {
        var denseHash: [Int] = []
        for i in 0..<16 {
            var sequence: [Int] = []
            for j in 0..<16 {
                sequence.append(sparseHash[j+(i*16)])
            }
            denseHash.append(sequence.reduce(0, { $0 ^ $1 }))
        }
        return denseHash
    }
}
