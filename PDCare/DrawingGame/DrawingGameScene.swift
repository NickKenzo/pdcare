//
//  BalanceGameScene.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import SpriteKit
import CoreMotion



var drawingMap = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),SKSpriteNode()]


class DrawingGameScene: SKScene, SKPhysicsContactDelegate{
    
    let manager = CMMotionManager()
    var mapNum = 0
    var scoreDisplay = SKLabelNode()
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        mapNum = Int.random(in: 0 ..< 2)
        
        //Initialize sprites
        drawingMap[0] = self.childNode(withName: "map0") as! SKSpriteNode
        drawingMap[1] = self.childNode(withName: "map1") as! SKSpriteNode
        for i in 1...drawingMap.count {
            if i != mapNum + 1 {
                drawingMap[i - 1].isHidden = true
            }
        }
//        let temp = DrawingGameVC()
//        if mapNum == 0{
//            if temp.tryAgain == true{
//
//                drawingMap[1].isHidden = true
//            }
//            if temp.nextGame == true{
//                drawingMap [0].isHidden = true
//            }
//        }
//        if mapNum == 1{
//            if temp.tryAgain == true{
//
//                drawingMap[0].isHidden = true
//            }
//            if temp.nextGame == true{
//                drawingMap [1].isHidden = true
//            }
//        }
        
        

    }
    
    

}




