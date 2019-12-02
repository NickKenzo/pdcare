//
//  BalanceGameScene.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Kyle Smolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file has all of the set up and working code for the balance game.
//  Player, goal and wall are all sprite nodes on the BalanceGameScene and all have physics and collision detection with each other.
//  The basic logic decrements the score the longer the game goes on and also decrements when a player makes contact with a wall.
//  The game ends as soon as the ball makes contact with the goal.
//
//  Known Bugs: - Score will rarely not decrement when the ball hits the wall
//              - When holding a collision with a portruding corner, points
//                will rapidly sink to 0
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/BalanceGameScene.swift

import SpriteKit
import CoreMotion

protocol GameOverDelegate {
    
    func goback()
}

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
    var quitbutton=SKSpriteNode()
    var score = 1000000
    var resetPos = false
    var startingPos = CGPoint(x: 0, y: 0)
    var scoreDisplay = SKLabelNode()
    var mapNum = 0
    var game_over : GameOverDelegate?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        mapNum = Int.random(in: 0 ..< 8)
        
        // Initialize sprites
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        map[0] = self.childNode(withName: "map0") as! SKSpriteNode
        goal[0] = self.childNode(withName: "goal0") as! SKSpriteNode
        map[1] = self.childNode(withName: "map1") as! SKSpriteNode
        goal[1] = self.childNode(withName: "goal1") as! SKSpriteNode
        map[2] = self.childNode(withName: "map2") as! SKSpriteNode
        goal[2] = self.childNode(withName: "goal2") as! SKSpriteNode
        map[3] = self.childNode(withName: "map3") as! SKSpriteNode
        goal[3] = self.childNode(withName: "goal3") as! SKSpriteNode
        map[4] = self.childNode(withName: "map4") as! SKSpriteNode
        goal[4] = self.childNode(withName: "goal4") as! SKSpriteNode
        map[5] = self.childNode(withName: "map5") as! SKSpriteNode
        goal[5] = self.childNode(withName: "goal5") as! SKSpriteNode
        map[6] = self.childNode(withName: "map6") as! SKSpriteNode
        goal[6] = self.childNode(withName: "goal6") as! SKSpriteNode
        map[7] = self.childNode(withName: "map7") as! SKSpriteNode
        goal[7] = self.childNode(withName: "goal7") as! SKSpriteNode
        
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
            gameOver()
        }
    }
    
    func gameOver() {
        if let view = self.view {
            if let scene = BalanceGameOverScene(fileNamed: "BalanceGameOverScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.score=score
                scene.game_over=game_over
                // Present the scene
                view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1))
                
            }
        }
    }
    
    
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if score <= 0 {
            gameOver()
        }
        
        ball.physicsBody?.contactTestBitMask = UInt32(Int(pow(2, Double(mapNum))))
        ball.physicsBody?.categoryBitMask = UInt32(pow(2, Double(mapNum)))
        ball.physicsBody?.collisionBitMask = UInt32(pow(2, Double(mapNum)))
        score -= 500
        scoreDisplay = self.childNode(withName: "scoreDisplay") as! SKLabelNode
        if score <= 0 {
            scoreDisplay.text = "Score: 0"
        }
        else {
            scoreDisplay.text = "Score: " + String(score)
        }
        scoreDisplay.fontSize = 65;
        
        self.physicsWorld.gravity = CGVector(dx: ((manager.accelerometerData?.acceleration.x ?? 0) * 5), dy: ((manager.accelerometerData?.acceleration.y ?? 0) * 5))
    }
}

