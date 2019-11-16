//
//  SettingsVC.swift
//  PDCare
//
//  Created by Daniel Wan on 11/3/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import Foundation

class SettingsVC: UITableViewController{
    
    @IBAction func openProfile(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    
    @IBOutlet weak var audioSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var offlineSwitch: UISwitch!
    
    
    let defaults = UserDefaults.standard
       
    @IBAction func audioSwitch(_ sender: UISwitch) {
        defaults.set(audioSwitch.isOn, forKey: "audio")
    }
    @IBAction func notificationSwitch(_ sender: UISwitch) {
        defaults.set(notificationSwitch.isOn, forKey: "notification")
    }
    @IBAction func offlineSwitch(_ sender: UISwitch) {
        defaults.set(offlineSwitch.isOn, forKey: "offline")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        notificationSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        offlineSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        
        if !(exist(key: "audio")){
            defaults.set(true, forKey: "audio")
            defaults.set(true, forKey: "notification")
            defaults.set(false, forKey: "offline")
        }
        audioSwitch.isOn = defaults.bool(forKey: "audio")
        notificationSwitch.isOn = defaults.bool(forKey: "notification")
        offlineSwitch.isOn = defaults.bool(forKey: "offline")
        
        
    }
}

func exist(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}



    
    

