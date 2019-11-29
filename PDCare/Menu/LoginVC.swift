//
//  ViewController.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Daniel Wan on 2019-11-27.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file is the view controller for the main application
//  This file currently only contains the option to move to the games menu
//
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version1/PDCare/LoginVC.swift

import UIKit

class LoginVC: UIViewController {

    @IBAction func openMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "MainMenuSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}
