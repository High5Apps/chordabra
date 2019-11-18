//
//  KeyboardRangeNoteTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/14/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

class KeyboardRangeNoteTap: ConstantQTransformTap {
    
    init(_ input: AKNode, analysisCompletionBlock: @escaping ([Float]) -> ()) {
        let standardKeyboardNoteCount = 88
        let notesPerOctave = 12
        let qualityMultiplier = 2 // Two frequency components per semitone as recommended by this paper:  http://academics.wellesley.edu/Physics/brown/pubs/cq1stPaper.pdf
        let binCount = Int32(qualityMultiplier * notesPerOctave)
        let bufferSize: UInt32 = 4096
        let sampleFrequency = Float(44100)
        
        let minFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: 0))
        let maxFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: standardKeyboardNoteCount - 1))
        super.init(input, minFrequency: minFrequency, maxFrequency: maxFrequency, inputBufferSize: bufferSize, bins: binCount, sampleFrequency: sampleFrequency) { (powers) in
            var scaleDegreePowers = [Float](zeros: notesPerOctave)
            for (i, power) in powers.enumerated() {
                scaleDegreePowers[(i / qualityMultiplier) % notesPerOctave] += power
            }
            
            var maxScaleDegreePower: Float = 0.0
            for power in scaleDegreePowers {
                if power > maxScaleDegreePower {
                    maxScaleDegreePower = power
                }
            }
            
            let normalizedScaleDegreePowers = scaleDegreePowers.map { $0 / maxScaleDegreePower }
            analysisCompletionBlock(normalizedScaleDegreePowers)
        }
    }
    
    // Note: 0 indexed keys. i.e. A0, the lowest key on a standard keyboard is at index 0
    class func getKeyboardNoteFrequencyWithIndex(i: Int) -> Double {
        return 440 * pow(2, (i - 48.0) / 12.0)
    }
}
