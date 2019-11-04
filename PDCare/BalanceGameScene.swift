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
    var map = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode()]
    var goal = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode()]
    var score = 1000000
    var resetPos = false
    var startingPos = CGPoint(x: 0, y: 0)
    var scoreDisplay = SKLabelNode()
    var mapNum = 0
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        mapNum = Int.random(in: 0 ..< 2)
        
        // Initialize sprites
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        map[0] = self.childNode(withName: "map0") as! SKSpriteNode
        goal[0] = self.childNode(withName: "goal0") as! SKSpriteNode
        map[1] = self.childNode(withName: "map1") as! SKSpriteNode
        goal[1] = self.childNode(withName: "goal1") as! SKSpriteNode
        
        for i in 1...map.count {
            if i != mapNum + 1 {
                map[i - 1].isHidden = true
                goal[i - 1].isHidden = true
            }
        }
        
        startingPos = ball.position
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // Called when one object begins contact with another
        if (contact.bodyB.node?.parent?.name == map[mapNum].name) || (contact.bodyA.node?.parent?.name == map[mapNum].name) {
            score -= 50000
        }
        
        if contact.bodyA.node?.name == goal[mapNum].name || contact.bodyB.node?.name == goal[mapNum].name {
            if let view = self.view {
                if let scene = SKScene(fileNamed: "BalanceGameOverScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view.presentScene(scene)
                    scoreDisplay = scene.childNode(withName: "scoreDisplay") as! SKLabelNode
                    scoreDisplay.text = "Score:" + String(score)
                    scoreDisplay.fontSize = 65
                }
            }
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        ball.physicsBody?.contactTestBitMask = UInt32(Int(pow(2, Double(mapNum))))
        ball.physicsBody?.categoryBitMask = UInt32(pow(2, Double(mapNum)))
        ball.physicsBody?.collisionBitMask = UInt32(pow(2, Double(mapNum)))
        score -= 500
        scoreDisplay = self.childNode(withName: "scoreDisplay") as! SKLabelNode
        scoreDisplay.text = "Score:" + String(score)
        scoreDisplay.fontSize = 65;
        
        self.physicsWorld.gravity = CGVector(dx: ((manager.accelerometerData?.acceleration.x ?? 0) * 5), dy: ((manager.accelerometerData?.acceleration.y ?? 0) * 5))
    }
}
