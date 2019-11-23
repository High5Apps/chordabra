//
//  DiminishedTriad.swift
//  rechord
//
//  Created by Julian Tigler on 11/19/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class DiminishedTriad: Chord {
    
    override class var friendlyName: String {
        return "Diminished Triad"
    }
    
    override var description : String {
        return "DiminishedTriad(\(rootName))"
    }
    
    override var symbol: String {
        get {
            "\(rootName)°"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        
        scaleDegrees[root] = 1
        scaleDegrees[(root + 3) % notesPerOctave] = 1
        scaleDegrees[(root + 6) % notesPerOctave] = 1
    }
}
