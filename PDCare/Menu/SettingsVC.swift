//
//  SettingsVC.swift
//  PDCare
//
//  Created by Daniel Wan on 11/3/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
//import AVFoundation

class SettingsVC: UITableViewController{
    
    @IBAction func openProfile(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    
    @IBOutlet weak var audioSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var offlineSwitch: UISwitch!
    
    @IBOutlet weak var audioLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var offlineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        notificationSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        offlineSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
}
    
    

