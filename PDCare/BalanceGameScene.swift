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
    var mazeEnd = SKSpriteNode()
    var score = 1000000
    var resetPos = false
    var startingPos=CGPoint(x: 0, y: 0)
    var firstmove=true
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        // Initialize sprites
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        wall = self.childNode(withName: "wall") as! SKSpriteNode
        
        startingPos=ball.position
        
        // Initialize physics bodies
        //ball.physicsBody = SKPhysicsBody(circleOfRadius: 32)
        
        // Initialize masks
        ball.physicsBody?.contactTestBitMask = 1
        ball.physicsBody?.categoryBitMask = 1
        wall.physicsBody?.contactTestBitMask = 0
        wall.physicsBody?.categoryBitMask = 1
        
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
    
    func didEnd(_ contact: SKPhysicsContact) {
        // Called when one object ends contact with another
        if contact.bodyA.node?.name == "ball" || contact.bodyB.node?.name == "ball" {
            score -= 5000
            
            /*** Ball position below does not get set and we need to figure out why ***/
            //ball.position = CGPoint(x: 256.67, y: -640)
            resetPos = true
            
        }
    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        print(score);
        
                
        //this works
        //self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        if (resetPos){
            ball.position = startingPos
            ball.physicsBody?.velocity = CGVector(dx: 0,dy: 0)
            resetPos = false
        }
    }
}
