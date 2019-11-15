//
//  KeyboardRangeNoteTap.swift
//  rechord
//
//  Created by Julian Tigler on 11/14/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation
import AudioKit

protocol KeyboardRangeNoteTapDelegate {
    func onKeyboardRangeNoteTapUpdated()
}

class KeyboardRangeNoteTap: ConstantQTransformTap, ConstantQTransformTapDelegate {
    
    // MARK: Properties
    var delegate: KeyboardRangeNoteTapDelegate?
    var scaleDegreePowers = [Float]()
        
    private let standardKeyboardNoteCount = 88
    private let notesPerOctave = 12

    
    init(_ input: AKNode) {
        let minFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: 0))
        let maxFrequency = Float(KeyboardRangeNoteTap.getKeyboardNoteFrequencyWithIndex(i: standardKeyboardNoteCount - 1))
        super.init(input, minFrequency: minFrequency, maxFrequency: maxFrequency, inputBufferSize: 4096)
        super.constantQTransformTapDelegate = self
    }
    
    // Note: 0 indexed keys. i.e. A0, the lowest key on a standard keyboard is at index 0
    class func getKeyboardNoteFrequencyWithIndex(i: Int) -> Double {
        return 440 * pow(2, (i - 48.0) / 12.0)
    }
    
    func onInputBufferAnalyzed(powers: [Float]) {
        analyze(notePowers: powers)
        self.delegate?.onKeyboardRangeNoteTapUpdated()
    }
    
    func analyze(notePowers: [Float]) {
        scaleDegreePowers = [Float](zeros: notesPerOctave)
        
        for (i, notePower) in notePowers.enumerated() {
            scaleDegreePowers[i % notesPerOctave] += notePower
        }
    }
    // !!!Start here: Determine which scale degrees are important to the chord and set as importantScaleDegrees property

}
