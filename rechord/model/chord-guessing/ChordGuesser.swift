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
        
        print(closestChords[0..<3])
        
        return closestChords[0]
    }
    
    private func getPossibleChords() -> [Chord] {
        var chords = [Chord]()
        
        chords.append(Silence(root: -1))
        chords.append(Noise(root: -1))
        
        for i in 0..<12 {
            chords.append(MajorChord(root: i))
            chords.append(MinorChord(root: i))
        }
        
        return chords
    }
}
