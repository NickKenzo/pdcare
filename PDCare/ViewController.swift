//
//  ViewController.swift
//  PDCare
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func OpenGamesMenu(_ sender: Any) {
        performSegue(withIdentifier: "GamesMenuSegue", sender: self)
    }
    
    @IBAction func OpenScores(_ sender: Any) {
        performSegue(withIdentifier: "ScoresSegue", sender: self)
    }
    
    @IBAction func OpenPlaylist(_ sender: Any) {
        performSegue(withIdentifier: "PlaylistSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

