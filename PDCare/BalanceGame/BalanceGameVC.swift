//
//  BalanceGameVC.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Kyle Smolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This is the view controller for the Balance game.
//  This file handles things like filling the screen, rotating the screen if needed, and displaying buttons if needed.
//
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/BalanceGameVC.swift

import UIKit
import SpriteKit

class BalanceGameVC: UIViewController,GameOverDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = BalanceGameScene(fileNamed: "BalanceGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.game_over=self
                
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
    func goback() {
        self.dismiss(animated: true)
    }
}
