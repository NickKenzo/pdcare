//
//  ViewController.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file is the view controller for the main application
//  This file currently only contains the option to move to the games menu
//
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version1/PDCare/ViewController.swift

import UIKit

class ViewController: UIViewController {

    @IBAction func openGamesMenu(_ sender: Any) {
        performSegue(withIdentifier: "GamesMenuSegue", sender: self)
    }
    
    @IBAction func openScores(_ sender: Any) {
        performSegue(withIdentifier: "ScoresSegue", sender: self)
    }
    
    @IBAction func openPlaylist(_ sender: Any) {
        performSegue(withIdentifier: "PlaylistSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

