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
        var previousChord: Chord?
        self.keyboardRangeNoteTap = KeyboardRangeNoteTap(self.mic) { (centeredScaleDegreeMaxs) in
            let guesser = ChordGuesser(centeredScaleDegreeMaxs)
            let chord = guesser.guessChord()
            
            if previousChord == nil || previousChord! != chord {
                previousChord = chord
                onChordChanged(chord)
            }
        }
        
        let silence = AKBooster(self.mic, gain: 0)
        AudioKit.output = silence
    }
    
    private class func snr(wantedScaleDegrees: [Int], scaleDegreePowers: [Float]) -> Double {
        var signal = 0.0
        var noise = 0.0
        for (i, power) in scaleDegreePowers.enumerated() {
            if wantedScaleDegrees.contains(i) {
                signal += Double(power)
            } else {
                noise += Double(power)
            }
        }
        return signal / noise
    }
    
    func start() {
        self.mic.start()

        do {
            try AudioKit.start()
        } catch {
            print("Failed to start AudioKit")
        }
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
