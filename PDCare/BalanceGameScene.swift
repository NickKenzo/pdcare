//
//  BalanceGameScene.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var ball = SKSpriteNode()
    var mazeEnd = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        
        self.physicsWorld.contactDelegate = self
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
            
            self.physicsWorld.gravity = CGVector.init(dx: CGFloat((data?.acceleration.x)!) * 10, dy: CGFloat((data?.acceleration.y)!) * 10)
            
        }
        
    }
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
