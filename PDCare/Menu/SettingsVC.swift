//
//  SettingsVC.swift
//  PDCare
//
//  Created by Daniel Wan on 11/3/19.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This view contains the settings for our app
//
//  Known bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/SettingsVC.swift

import UIKit
import Foundation
import UserNotifications

class SettingsVC: UITableViewController{
    
    @IBAction func openProfile(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
    
    @IBOutlet weak var audioSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    
    // Set persistent user settings
    let defaults = UserDefaults.standard
       
    @IBAction func changeAudioSetting(_ sender: UISwitch) {
        defaults.set(audioSwitch.isOn, forKey: "audio")
    }
    
    @IBAction func changeNotificationSetting(_ sender: UISwitch) {
        defaults.set(notificationSwitch.isOn, forKey: "notification")
        let center = UNUserNotificationCenter.current()
        guard notificationSwitch.isOn else {
            center.removeAllPendingNotificationRequests()
            return
        }
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                center.removeAllPendingNotificationRequests()
                return
            }
            guard settings.alertSetting == .enabled else {
                return
            }
            
            // Create notification content
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Play more games!", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "You can do it! Playing more often will help mitigate the symptoms of Parkinsons disease.", arguments: nil)
            
            // Create notification trigger
            var date = DateComponents()
            date.hour = 2
            date.minute = 18
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            // Create the request object
            let request = UNNotificationRequest(identifier: "GameReminder", content: content, trigger: trigger)
            
            // Send the notification request to the OS
            center.add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        notificationSwitch.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        
        if !(exist(key: "audio")){
            defaults.set(true, forKey: "audio")
            defaults.set(false, forKey: "notification")
        }
        audioSwitch.isOn = defaults.bool(forKey: "audio")
        notificationSwitch.isOn = defaults.bool(forKey: "notification")
    }
}

func exist(key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}



    
    

