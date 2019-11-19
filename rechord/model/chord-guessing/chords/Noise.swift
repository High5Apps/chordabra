//
//  Noise.swift
//  rechord
//
//  Created by Julian Tigler on 11/18/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import Foundation

class Noise: Chord {
    
    override var description : String {
        return "Noise"
    }
    
    override var rootName: String {
        get {
            "N"
        }
    }
    
    override var symbol: String {
        get {
            ""
        }
    }
    
    required init(root: Int) {
        super.init(root: root)
        scaleDegrees = [Double](repeating: 0.5, count: 12)
    }
}
