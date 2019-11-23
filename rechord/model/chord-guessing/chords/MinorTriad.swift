//
//  MinorChord.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class MinorTriad: Chord {
    
    override class var enabledByDefault: Bool {
        return true
    }
    
    override class var friendlyName: String {
        return "Minor Triad"
    }
    
    override var description : String {
        return "MinorTriad(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)m"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        
        scaleDegrees[root] = 1
        scaleDegrees[(root + 3) % notesPerOctave] = 1
        scaleDegrees[(root + 7) % notesPerOctave] = 1
    }
}
