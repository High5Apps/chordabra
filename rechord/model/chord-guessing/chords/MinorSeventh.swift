//
//  MinorSeventh.swift
//  rechord
//
//  Created by Julian Tigler on 11/24/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class MinorSeventh: Chord {
    
    override class var friendlyName: String {
        return "Minor Seventh"
    }
    
    override var description : String {
        return "MinorSeventh(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)m7"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        
        scaleDegrees[root] = 1
        scaleDegrees[(root + 3) % notesPerOctave] = 1
        scaleDegrees[(root + 7) % notesPerOctave] = 1
        scaleDegrees[(root + 10) % notesPerOctave] = 1
    }
}
