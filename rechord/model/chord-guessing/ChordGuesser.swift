//
//  ChordGuesser.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class ChordGuesser {
    lazy var chordPossibilities: [Chord] = {
        var chords = [Chord]()
        
        for i in 0..<12 {
            chords.append(MajorTriad(root: i))
            chords.append(MinorTriad(root: i))
            chords.append(DiminishedTriad(root: i))
            chords.append(DominantSeventh(root: i))
        }
        
        return chords
    }()
    
    func guessChord(_ chroma: [Float]) -> Chord {
        let closestChords = chordPossibilities.sorted { (a, b) -> Bool in
            a.getDistance(from: chroma) < b.getDistance(from: chroma)
        }
        
        return closestChords[0]
    }
}
