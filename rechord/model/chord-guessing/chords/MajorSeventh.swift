//
//  MajorSeventh.swift
//  rechord
//
//  Created by Julian Tigler on 11/24/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class MajorSeventh: Chord {
    
    override class var friendlyName: String {
        return "Major Seventh"
    }
    
    override var description : String {
        return "MajorSeventh(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)M7"
        }
    }
    
    override var ghostNoteBias: Double {
        get {
            return 0.94
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
                
        scaleDegrees[root] = 1
        scaleDegrees[(root + 4) % notesPerOctave] = 1
        scaleDegrees[(root + 7) % notesPerOctave] = 1
        scaleDegrees[(root + 11) % notesPerOctave] = 1
    }
}
