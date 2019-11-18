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
        var minDistance = Float.infinity
        var closestChord: Chord!
        
        for chord in getPossibleChords() {
            let distance = chord.getDistance(from: scaleDegreePowers)
            if distance < minDistance {
                minDistance = distance
                closestChord = chord
            }
        }
        
        return closestChord
    }
    
    private func getPossibleChords() -> [Chord] {
        var chords = [Chord]()
        
        for i in 0..<12 {
            chords.append(MajorChord(root: i))
            chords.append(MinorChord(root: i))
            chords.append(PowerChord(root: i))
        }
        
        return chords
    }
}
