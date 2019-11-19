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
        let notesPerOctave = 12
        let qualityMultiplier = 3
        let binCount = Int32(qualityMultiplier * notesPerOctave)
        let bufferSize: UInt32 = 4096
        let sampleFrequency = Float(AKSettings.sampleRate)
        let minNote = 7 // Bass's Low E
        let maxNote = 75 // Double High C
        
        let minFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: minNote))
        let maxFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: maxNote))
        super.init(input, minFrequency: minFrequency, maxFrequency: maxFrequency, inputBufferSize: bufferSize, bins: binCount, sampleFrequency: sampleFrequency) { (powers) in
            var centeredScaleDegreeMaxs = [Float](zeros: notesPerOctave)
            for (i, power) in powers.enumerated() {
                let scaleDegree = (minNote + (i / qualityMultiplier)) % notesPerOctave
                
                if (i % qualityMultiplier == 1) { // 1 is the center component of the 3 frequency bins of each semitone
                    centeredScaleDegreeMaxs[scaleDegree] = max(centeredScaleDegreeMaxs[scaleDegree], power)
                }
            }
            
            let normalizedCenteredScaleDegreeMaxs = KeyboardRangeNoteTap.normalize(input: centeredScaleDegreeMaxs)
            analysisCompletionBlock(normalizedCenteredScaleDegreeMaxs)
        }
    }
    
    private class func normalize(input: [Float]) -> [Float] {
        var max: Float = 0.0
        for x in input {
            if x > max {
                max = x
            }
        }
        
        let normalized: [Float]
        if max > 0 {
            normalized = input.map { $0 / max }
        } else {
            normalized = input
        }
        
        return normalized
    }
    
    // Note: 0 indexed keys. i.e. A0, the lowest key on a standard keyboard is at index 0
    class func getKeyboardNoteFrequencyWithIndex(i: Int) -> Double {
        return 440 * pow(2, (i - 48.0) / 12.0)
    }
}
