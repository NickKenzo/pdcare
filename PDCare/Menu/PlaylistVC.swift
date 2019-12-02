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
    var scoreArr = [[Int](), [Int](), [Int]()]
    var games = [URL]()
    
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
        
        let userName = "russel"
        let urlGame1 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=1")!
        let urlGame2 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=2")!
        let urlGame3 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=3")!
        self.games.append(urlGame1)
        self.games.append(urlGame2)
        self.games.append(urlGame3)
        
        
        
        self.writeScoreArr(gameUrl: self.games[0], index: 0)
        
        
        
        
        
        
        
        
        
        
//        let serialQueue = DispatchQueue(label: "serialQueue")
//        for i in 0...2 {
//            serialQueue.sync {
//                self.writeScoreArr(gameUrl: games[i], index: i)
//            }
//
//        }
//        serialQueue.sync {
//            self.resumePullingScores()
//        }
    }
    
    func resumePullingScores() {
        print(self.scoreArr)
    }
    
    func writeScoreArr(gameUrl: URL, index: Int) {
        var tmpArr = [Int]()
        
        let session = URLSession.shared
        let task = session.dataTask(with: gameUrl, completionHandler: { data, response, error in
                do {
                    let jsonArr = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String: Any]]
                    for dic in jsonArr {
                        for (key, val) in dic {
                            if key == "score" {
                                tmpArr.append((val as! NSString).integerValue)
                            }
                        }
                    }
                    self.scoreArr[index] = tmpArr
                    let newIndex = index + 1
                    if newIndex < 3 {
                        self.writeScoreArr(gameUrl: self.games[newIndex], index: newIndex)
                    }
                    else {
                        self.resumePullingScores()
                    }

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
