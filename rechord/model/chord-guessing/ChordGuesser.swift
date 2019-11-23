//
//  ChordGuesser.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class ChordGuesser {
    
    // MARK: Properties
    var chordPossibilities = [Chord]()
    
    init(_ chordTypes: [Chord.Type]) {
        for chordType in chordTypes {
            for i in 0..<12 {
                chordPossibilities.append(chordType.init(root: i))
            }
        }
    }
    
    func guessChord(_ chroma: [Float]) -> Chord {
        let closestChords = chordPossibilities.sorted { (a, b) -> Bool in
            a.getDistance(from: chroma) < b.getDistance(from: chroma)
        }
        
        return closestChords[0]
    }
}
