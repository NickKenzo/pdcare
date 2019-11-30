//
//  BalanceGameScene.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import SpriteKit
import CoreMotion

//protocol GameOverDelegate {
//
//    func goback()
//}

class DrawingGameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var score = 100
    var map = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    var game_over : GameOverDelegate?
    var mapNum = 0
    var scoreDisplay = SKLabelNode()
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        mapNum = Int.random(in: 0 ..< 2)
        
        //Initialize sprites
        map[0] = self.childNode(withName: "map0") as! SKSpriteNode
        map[1] = self.childNode(withName: "map1") as! SKSpriteNode
        for i in 1...map.count {
            if i != mapNum + 1 {
                map[i - 1].isHidden = true                
            }
        }
            
    }

    
    func gameOver() {
        if let view = self.view {
            if let scene = DrawingGameOverScene(fileNamed: "DrawingGameOverScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.score=score
                scene.game_over=game_over
                // Present the scene
                view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1))
                
            }
        }
    }
    
    
//    override func update(_ currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//        if score <= 0 {
//            gameOver()
//        }
//
//        score -= 500
//        scoreDisplay = self.childNode(withName: "scoreDisplay") as! SKLabelNode
//        if score <= 0 {
//            scoreDisplay.text = "Score: 0"
//        }
//        else {
//            scoreDisplay.text = "Score: " + String(score)
//        }
//        scoreDisplay.fontSize = 65;
//
//
//    }
}

    


