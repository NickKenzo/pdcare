//
//  SettingsVC.swift
//  PDCare
//
//  Created by Daniel Wan on 11/3/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
//import AVFoundation

class SettingsVC: UIViewController {
    
    @IBAction func sToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
           
    @IBAction func OpenProfile(_ sender: Any) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
             
    @IBOutlet weak var GameVolumeLabel: UILabel!
    @IBOutlet weak var Stepper: UIStepper!
    @IBAction func GameVolumeChanged(_ sender: UIStepper) {
        self.GameVolumeLabel.text = Int(sender.value).description
    }
        
    @IBOutlet weak var Switch1: UISwitch!
    @IBOutlet weak var Switch2: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Stepper.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        Switch1.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        Switch2.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // Do any additional setup after loading the view.
        
        
//        var bombSoundEffect: AVAudioPlayer?
        
//        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
//            bombSoundEffect?.play()
//        } catch {
//            // couldn't load file :(
//        }
    }
    
}
    
    

