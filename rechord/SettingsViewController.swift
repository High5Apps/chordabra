//
//  SettingsViewController.swift
//  rechord
//
//  Created by Julian Tigler on 11/22/19.
//  Copyright © 2019 High5! Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: Properties
    var chordSettings = [String: Bool]()
    var chordTypes: [Chord.Type]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        chordTypes = appDelegate.chordTypes
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chordTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ChordCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        let chordName = chordTypes[indexPath.row].friendlyName
        cell.textLabel?.text = chordName
        
        let isEnabled = UserDefaults.standard.bool(forKey: chordName)
        let accessoryType: UITableViewCell.AccessoryType = isEnabled ? .checkmark : .none
        cell.accessoryType = accessoryType

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.tableView.cellForRow(at: indexPath)!
        let isEnabled = cell.accessoryType == .checkmark
        
        // Require at least 1 chord type to be enabled
        if isEnabled && getEnabledCount() == 1 {
            return
        }
        
        cell.accessoryType = isEnabled ? .none : .checkmark
        UserDefaults.standard.set(!isEnabled, forKey: cell.textLabel!.text!)
    }
    
    private func getEnabledCount() -> Int {
        var enabledCount = 0
        
        let defaults = UserDefaults.standard
        for chordType in chordTypes {
            if defaults.bool(forKey: chordType.friendlyName) {
                enabledCount += 1
            }
        }
        
        return enabledCount
    }
}