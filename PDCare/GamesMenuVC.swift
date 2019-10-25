//
//  GamesMenuVC.swift
//  PDCare
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit

class GamesMenuVC: UIViewController {
    @IBAction func gToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func OpenBalanceGame(_ sender: Any) {
        performSegue(withIdentifier: "BalanceSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
