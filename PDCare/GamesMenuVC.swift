//
//  GamesMenuVC.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file handles the view controller for the games menu.
//  This file contains any segues to any of the games (just balance for now)
//
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version1/PDCare/GamesMenuVC.swift

import UIKit

class GamesMenuVC: UIViewController {
    
    @IBAction func gToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMemoryGame(_ sender: Any) {
        performSegue(withIdentifier: "memorySegue", sender: self)
    }
    
    @IBAction func openBalanceGame(_ sender: Any) {
        performSegue(withIdentifier: "balanceSegue", sender: self)
    }
    
    @IBAction func openDrawingGame(_ sender: Any) {
        performSegue(withIdentifier: "drawingSegue", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
