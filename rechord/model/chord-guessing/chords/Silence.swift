//
//  Silence.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class Silence: Chord {
    
    override var description : String {
        return "Silence"
    }
    
    override var rootName: String {
        get {
            "S"
        }
    }
    
    override var symbol: String {
        get {
            ""
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        scaleDegrees = [Double](zeros: 12)
    }
}
