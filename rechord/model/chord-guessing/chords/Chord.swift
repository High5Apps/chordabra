//
//  Chord.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class Chord: NSObject {
    var root: Int
    var scaleDegrees: [Int]
    
    var rootName: String {
        get {
            ["A", "B♭", "B", "C", "D♭", "D", "E♭", "E", "F", "F#", "G", "A♭"][root]
        }
    }
    
    var symbol: String {
        get {
            "\(rootName) (N.C.)"
        }
    }
    
    class var enabledByDefault: Bool {
        return false
    }
    
    class var friendlyName: String {
        return "Chord"
    }
    
    static func == (lhs: Chord, rhs: Chord) -> Bool {
        return
            type(of: lhs) == type(of: rhs) &&
            lhs.root == rhs.root
    }
    
    static func != (lhs: Chord, rhs: Chord) -> Bool  {
        return !(lhs == rhs)
    }
    
    let notesPerOctave = 12
    
    required init(root: Int) {
        self.root = root
        self.scaleDegrees = [Int](zeros: notesPerOctave)
    }
    
    func getDistance(from chroma: [Float]) -> Double {
        guard chroma.count == notesPerOctave else {
            fatalError("Expected chroma to have 12 elements")
        }

        var noise = 0.0
        
        for i in 0..<notesPerOctave {
            noise += (1 - Double(scaleDegrees[i])) * pow(Double(chroma[i]), 2)
        }
        
        noise = sqrt(noise) / Double(12 - scaleDegrees.filter({ $0 > 0 }).count)

        return noise
    }
}
