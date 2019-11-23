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
    var mic: AKMicrophone
    var keyboardRangeNoteTap: KeyboardRangeNoteTap?
    var chordGuesser: ChordGuesser!
    
    init() {
        self.mic = AKMicrophone()!
        let silence = AKBooster(self.mic, gain: 0)
        AudioKit.output = silence
    }
    
    func start(chordTypes: [Chord.Type], onChordChanged: @escaping (Chord) -> Void) {
        self.chordGuesser = ChordGuesser(chordTypes)
        
        var oneChordAgo: Chord?
        var twoChordsAgo: Chord?

        if self.keyboardRangeNoteTap == nil {
            self.keyboardRangeNoteTap = KeyboardRangeNoteTap(self.mic) { (chroma) in
                let chord = self.chordGuesser.guessChord(chroma)

                if twoChordsAgo != oneChordAgo && oneChordAgo == chord {
                    onChordChanged(chord)
                }

                twoChordsAgo = oneChordAgo
                oneChordAgo = chord
            }
        }
        
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
