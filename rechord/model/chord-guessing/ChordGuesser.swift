//
//  ChordGuesser.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class ChordGuesser {
    let scaleDegreePowers: [Float]
    
    init(_ scaleDegreePowers: [Float]) {
        self.scaleDegreePowers = scaleDegreePowers
    }
    
    func guessChord() -> Chord {
        let closestChords = getPossibleChords().sorted { (a, b) -> Bool in
            a.getDistance(from: scaleDegreePowers) < b.getDistance(from: scaleDegreePowers)
        }
        
        return closestChords[0]
    }
    
    private func getPossibleChords() -> [Chord] {
        var chords = [Chord]()
        
        for i in 0..<12 {
            chords.append(MajorTriad(root: i))
            chords.append(MinorTriad(root: i))
        }
        
        return chords
    }
}
