//
//  Silence.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class Silence: Chord {
    override var rootName: String {
        get {
            "S"
        }
    }
    
    override var symbol: String {
        get {
            "S"
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        scaleDegrees = [Int](zeros: 12)
    }
}
