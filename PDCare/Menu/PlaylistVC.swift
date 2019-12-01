//
//  PlaylistVC.swift
//  PDCare
//
//  Created by Russell Ho on 2019-10-25.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This view is currently empty, and a placeholder for Version 3
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/PlaylistVC.swift

import UIKit

class PlaylistVC: UIViewController {
    @IBAction func pToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainPlaylistFunc()

    }
    
    func mainPlaylistFunc() {
        let session = URLSession.shared
        let urlGame1 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=russel&game=1")!
        let urlGame2 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=russel&game=2")!
        let urlGame3 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=russel&game=3")!
        let games = [urlGame1, urlGame2, urlGame3]
        
        var scoreArr = [[Int]]()
        var tmpArr = [Int]()
        
        let task = session.dataTask(with: urlGame1, completionHandler: { data, response, error in
                do {
                    let jsonArr = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                    for dic in jsonArr {
                        for (key, val) in dic {
                            if key == "score" {
                                tmpArr.append((val as! NSString).integerValue)
                            }
                        }
                    }
                    print(tmpArr)


                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
        })
        task.resume()
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
