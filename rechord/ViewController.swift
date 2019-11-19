//
//  ViewController.swift
//  rechord
//
//  Created by Julian Tigler on 11/11/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import UIKit
import AudioKit
import AudioKitUI

class ViewController: UIViewController {
    
    var chordAnalyzer: ChordAnalyzer!
    
    @IBOutlet weak var chordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chordAnalyzer = ChordAnalyzer(onChordChanged: { (chord) in
            DispatchQueue.main.async {
               self.chordLabel.text = chord.symbol
            }
        })
        self.chordAnalyzer.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.chordAnalyzer.stop()
    }
}
