//
//  MemoryGameController.swift
//  SimonSays
//
//  Created by nskinner on 10/25/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MemoryGameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    @IBAction func touchdown(_ sender: UIButton) {
        print(sender.accessibilityLabel)
    }
    
    
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func setTitle(_ title: String){
        print(title)
    }
    var isWatching = true{
        didSet{
            if isWatching{
                setTitle("Watch!")
            }
            else{
                setTitle("Repeat!")
            }
        }
    }
    var sequence = [UIButton]()
    var sequenceIndex = 0
    func playNextButton(){
        guard sequenceIndex < sequence.count else{
            isWatching = false
            sequenceIndex = 0
            return
        }
        let button = sequence[sequenceIndex]
        sequenceIndex += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.touchdown(button)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.touchdown(button)
                self?.playNextButton()
            }
        }
    }
}
