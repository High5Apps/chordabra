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
    var chord = AKMixer()
    var oscillators = [AKOscillator]()
    var keyboardRangeNoteTap: KeyboardRangeNoteTap
    
    init() {
        self.chord = AKMixer()
        for i in [51, 55, 58, 60] {
            let oscillator = ChordAnalyzer.getOscillator(for: i)
            self.oscillators.append(oscillator)
            self.chord.connect(input: oscillator)
        }
                
        self.keyboardRangeNoteTap = KeyboardRangeNoteTap(self.chord) { (normalizedScaleDegreePowers) in
            var importantScaleDegrees = [Int]()

            for (i, normalizedPower) in normalizedScaleDegreePowers.enumerated() {
                if normalizedPower > 0.5 {
                    importantScaleDegrees.append(i)
                }
            }
            print(importantScaleDegrees)
            print(normalizedScaleDegreePowers)
        }
        
        let silence = AKBooster(self.chord, gain: 0)
        AudioKit.output = silence
    }
    
    private class func getOscillator(for noteIndex: Int) -> AKOscillator {
        let oscillator = AKOscillator()
        oscillator.frequency = 440 * pow(2, (noteIndex - 48) / 12.0)
        oscillator.amplitude = 0.85
        return oscillator
    }
    
    func start(onChordChanged: (String) -> ()) {
        do {
            try AudioKit.start()
        } catch {
            print("Failed to start AudioKit")
        }
        
        for oscillator in oscillators {
            oscillator.start()
        }
    }
    
    func stop() {
        do {
            try AudioKit.stop()
        } catch {
            print("Failed to stop AudioKit")
        }
    }
}
