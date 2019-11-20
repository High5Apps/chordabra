//
//  DominantSeventh.swift
//  rechord
//
//  Created by Julian Tigler on 11/19/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class DominantSeventh: Chord {
    
    override var description : String {
        return "DominantSeventh(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)7"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        
        scaleDegrees[root] = 1
        scaleDegrees[(root + 4) % notesPerOctave] = 1
        scaleDegrees[(root + 7) % notesPerOctave] = 1
        scaleDegrees[(root + 10) % notesPerOctave] = 1
    }
}
