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

class PlaylistVC: UITableViewController {
    var scoreArr = [[Int](), [Int](), [Int]()]
    var games = [URL]()
    var gameArr:[(score:Int, name:String)] = []
    
    // Label outlets
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    // Button outlets
    @IBAction func b1(_ sender: UIButton) {
        self.buttonAction(gameToPlay: self.gameArr[0].name)
    }
    @IBAction func b2(_ sender: UIButton) {
        self.buttonAction(gameToPlay: self.gameArr[1].name)
    }
    @IBAction func b3(_ sender: UIButton) {
        self.buttonAction(gameToPlay: self.gameArr[2].name)
    }
    
    @IBAction func pToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openSettings(_ sender: Any) {
        performSegue(withIdentifier: "SettingsSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
             self.label1.text = ""
             self.label2.text = ""
             self.label3.text = ""
         }
        self.mainPlaylistFunc()
    }
    
    func buttonAction(gameToPlay: String){
        if gameToPlay == "Memory" {
            performSegue(withIdentifier: "memorySegue", sender: self)
        }
        else if gameToPlay == "Balance" {
            performSegue(withIdentifier: "balanceSegue", sender: self)
        }
        else {
            performSegue(withIdentifier: "drawingSegue", sender: self)
        }
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
    
    func populateTableView() {
        DispatchQueue.main.async {
            self.label1.text = self.gameArr[0].name
            self.label2.text = self.gameArr[1].name
            self.label3.text = self.gameArr[2].name
        }
    }
    
    func resumePullingScores() {
        print(self.scoreArr)
//        let balanceGame = (score: self.getImprovement(arr: self.scoreArr[0]), name: "Balance")
//        let memoryGame = (score: self.getImprovement(arr: self.scoreArr[1]), name: "Memory")
//        let drawingGame = (score: self.getImprovement(arr: self.scoreArr[2]), name: "Drawing")
        
        self.gameArr = [(self.getImprovement(arr: self.scoreArr[0]), "Balance"),
                                                  (self.getImprovement(arr: self.scoreArr[1]), "Memory"),
                                                  (self.getImprovement(arr: self.scoreArr[2]), "Drawing")]
        self.gameArr.sort(by: {$0.score < $1.score})
        print(self.gameArr)
        self.populateTableView()
    }
    
    func getImprovement(arr: [Int]) -> Int {
        if arr.count <= 1 {
            if arr.count == 1 {
                return arr[0]
            }
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
