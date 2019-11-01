//
//  BalanceGameScene.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import SpriteKit
import CoreMotion

class DrawingGameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
   
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        
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
    

    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
       
        
    }
}
