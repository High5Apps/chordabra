//
//  ChordAnalyzer.swift
//  rechord
//
//  Created by Julian Tigler on 11/11/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

class ChordAnalyzer {

    // MARK: Properties
    var mic = AKMicrophone()!
    var keyboardRangeNoteTap: KeyboardRangeNoteTap
    
    init(onChordChanged: @escaping (Chord) -> Void) {
        let chordGuesser = ChordGuesser()
        var oneChordAgo: Chord?
        var twoChordsAgo: Chord?
        
        self.keyboardRangeNoteTap = KeyboardRangeNoteTap(self.mic) { (chroma) in
            let chord = chordGuesser.guessChord(chroma)

            if twoChordsAgo != oneChordAgo && oneChordAgo == chord {
                onChordChanged(chord)
            }
            
            twoChordsAgo = oneChordAgo
            oneChordAgo = chord
        }
        
        let silence = AKBooster(self.mic, gain: 0)
        AudioKit.output = silence
    }
    
    func start() {
        do {
            try AudioKit.start()
        } catch {
            print("Failed to start AudioKit")
        }
        
        self.mic.start()
    }
    
    func stop() {
        self.mic.stop()
        
        do {
            try AudioKit.stop()
        } catch {
            print("Failed to stop AudioKit")
        }
    }
}
