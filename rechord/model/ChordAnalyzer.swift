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
        let lowPassFilter = AKLowPassButterworthFilter(self.mic, cutoffFrequency: 8200)

        var previousChord: Chord?
        self.keyboardRangeNoteTap = KeyboardRangeNoteTap(lowPassFilter) { (normalizedScaleDegreePowers) in
            let guesser = ChordGuesser(normalizedScaleDegreePowers)
            let chord = guesser.guessChord()
            
            if chord is Silence || chord is Noise {
                return
            }
            
            if previousChord == nil || previousChord! != chord {
                previousChord = chord
                onChordChanged(chord)
            }
        }
        
        let silence = AKBooster(lowPassFilter, gain: 0)
        AudioKit.output = silence
    }
    
    private class func getOscillator(for noteIndex: Int) -> AKOscillator {
        let oscillator = AKOscillator()
        oscillator.frequency = 440 * pow(2, (noteIndex - 48) / 12.0)
        oscillator.amplitude = 0.85
        return oscillator
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
