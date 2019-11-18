//
//  PowerChord.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class PowerChord: Chord {
    
    override var description : String {
        return "PowerChord(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)5"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        
        scaleDegrees[root] = 1
        scaleDegrees[(root + 7) % notesPerOctave] = 1
    }
}
