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
        
        setNavigationTitle("Chordabra", kern: 2)
        
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
    
    func setNavigationTitle(_ title: String, kern: CGFloat) {
        let titleLabel = UILabel()

        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .thin),
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: kern] as [NSAttributedString.Key : Any]

        let attributedTitle = NSAttributedString(string: title, attributes: attributes)

        titleLabel.attributedText = attributedTitle
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
}
