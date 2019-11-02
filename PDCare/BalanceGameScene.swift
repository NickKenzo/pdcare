//
//  BalanceGameScene.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import SpriteKit
import CoreMotion

class BalanceGameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var ball = SKSpriteNode()
    var wall = SKSpriteNode()
    var goal = SKSpriteNode()
    var score = 1000000
    var resetPos = false
    var startingPos=CGPoint(x: 0, y: 0)
    var scoreDisplay = SKLabelNode();
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Initialize sprites
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        wall = self.childNode(withName: "wall") as! SKSpriteNode
        goal = self.childNode(withName: "goal") as! SKSpriteNode
        
        startingPos=ball.position
        
        // Initialize physics bodies
        //ball.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        
        // Initialize masks
        ball.physicsBody?.contactTestBitMask = 1
        ball.physicsBody?.categoryBitMask = 1
        wall.physicsBody?.contactTestBitMask = 1
        wall.physicsBody?.categoryBitMask = 1
        goal.physicsBody?.contactTestBitMask = 1
        goal.physicsBody?.categoryBitMask = 1
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            /**** Currently physicsWorld.gravity does not override settings in sks file and we need to figure out why ****/
            /**** Works if you set it in the func update, see below ****/
            //self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 0, dy: CGFloat((data?.acceleration.y)!) * 0)
            //self.physicsWorld.gravity = CGVector(dx: CGFloat(0), dy: CGFloat(0))
            
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Called when one object ends contact with another
        if (contact.bodyB.node?.name == "wall") || (contact.bodyA.node?.name == "wall") {
            score -= 5000
            
            /*** Ball position below does not get set and we need to figure out why ***/
            //ball.position = CGPoint(x: 256.67, y: -640)
            resetPos = true
            
        }
        
        if contact.bodyA.node?.name == "goal" || contact.bodyB.node?.name == "goal" {
            if let view = self.view as! SKView? {
            if let scene = SKScene(fileNamed: "BalanceGameOverScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                scoreDisplay = scene.childNode(withName: "scoreDisplay") as! SKLabelNode;
                scoreDisplay.text = "Score:" + String(score);
                scoreDisplay.fontSize = 65;
            }
        }
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        score -= 100;
        scoreDisplay = self.childNode(withName: "scoreDisplay") as! SKLabelNode;
        scoreDisplay.text = "Score:" + String(score);
        scoreDisplay.fontSize = 65;
        
        //let accelerometerData = manager.accelerometerData
        self.physicsWorld.gravity = CGVector(dx: ((manager.accelerometerData?.acceleration.x ?? 0) * 5), dy: ((manager.accelerometerData?.acceleration.y ?? 0) * 5))
 
        //this works
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        if (resetPos){
            ball.position = startingPos
            ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            resetPos = false
        }
    }
}
