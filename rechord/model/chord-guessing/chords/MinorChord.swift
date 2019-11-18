//
//  MinorChord.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class MinorChord: Chord {
    
    override var description : String {
        return "MinorChord(\(rootName))"
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
