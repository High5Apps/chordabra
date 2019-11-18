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
            return ["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "F#", "G", "Ab"][root]
        }
    }
    
    var symbol: String {
        get {
            "\(rootName) (N.C.)"
        }
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
    
    convenience init(root: Int, scaleDegrees: [Int]) {
        self.init(root: root)
        self.scaleDegrees = scaleDegrees
    }
    
    func getDistance(from scaleNotePowers: [Float]) -> Float {
        guard scaleNotePowers.count == notesPerOctave else {
            fatalError("Expected scaleNotePowers to have 12 elements")
        }
        
        var distance: Float = 0.0
        
        for i in 0..<notesPerOctave {
            distance += abs(scaleNotePowers[i] - Float(scaleDegrees[i]))
        }
 
        return distance
    }
}
