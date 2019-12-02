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
        
        let defaults = UserDefaults.standard
        let userName = defaults.string(forKey:"username")!
        let urlGame1 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=1")!
        let urlGame2 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=2")!
        let urlGame3 = URL(string: "http://pdcare14.com/api/getscores.php?username=pdcareon_admin&password=pdcareadmin&uname=" + userName + "&game=3")!
        self.games.append(urlGame1)
        self.games.append(urlGame2)
        self.games.append(urlGame3)
        
        
        
        self.writeScoreArr(gameUrl: self.games[0], index: 0)
    }
    
    func resumePullingScores() {
        print(self.scoreArr)
//        let balanceGame = (score: self.getImprovement(arr: self.scoreArr[0]), name: "Balance")
//        let memoryGame = (score: self.getImprovement(arr: self.scoreArr[1]), name: "Memory")
//        let drawingGame = (score: self.getImprovement(arr: self.scoreArr[2]), name: "Drawing")
        
        var gameArr:[(score:Int, name:String)] = [(self.getImprovement(arr: self.scoreArr[0]), "Balance"),
                                                  (self.getImprovement(arr: self.scoreArr[1]), "Memory"),
                                                  (self.getImprovement(arr: self.scoreArr[2]), "Drawing")]
        gameArr.sort(by: {$0.score < $1.score})
        print(gameArr)
    }
    
    func getImprovement(arr: [Int]) -> Int {
        if arr.isEmpty {
            return -1
        }
        var curImprovement = 0
        var diff = 0
        for i in 1...(arr.count - 1) {
            diff = arr[i] - arr[i-1]
            curImprovement += diff
        }
        return curImprovement
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
}
