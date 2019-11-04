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
//  Known Bugs: Score will rarely not decrement when the ball hits the wall
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version1/PDCare/BalanceGameScene.swift

import SpriteKit
import CoreMotion

class BalanceGameScene: SKScene, SKPhysicsContactDelegate{
    
    //Initialize Motion Manager (CM)
    let manager = CMMotionManager()
    //Initialize sprite variables
    var ball = SKSpriteNode()
    var map = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
               SKSpriteNode()]
    var goal = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode(), SKSpriteNode(), SKSpriteNode(),
                SKSpriteNode()]
    var scoreDisplay = SKLabelNode()
    //Initialize other starting variables
    var score = 1000000
    var resetPos = false
    var startingPos = CGPoint(x: 0, y: 0)
    var mapNum = 0
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        mapNum = Int.random(in: 0 ..< 2)
        
        // Initialize sprites
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        map[0] = self.childNode(withName: "map0") as! SKSpriteNode
        goal[0] = self.childNode(withName: "goal0") as! SKSpriteNode
        map[1] = self.childNode(withName: "map1") as! SKSpriteNode
        goal[1] = self.childNode(withName: "goal1") as! SKSpriteNode
        //Random generation for which map to use
        for i in 1...map.count {
            if i != mapNum + 1 {
                map[i - 1].isHidden = true
                goal[i - 1].isHidden = true
            }
        }
        
        startingPos = ball.position
        //Set up for use of accelerometer 
        manager.startAccelerometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main){
            (data, error) in
        }
    }
    //Check to see if the ball has made contact with either the wall or the goal
    func didBegin(_ contact: SKPhysicsContact) {
        // Deduct points for hitting the wall
        if (contact.bodyB.node?.parent?.name == map[mapNum].name) || (contact.bodyA.node?.parent?.name == map[mapNum].name) {
            score -= 50000
        }
        // End the game for hitting the goal
        if contact.bodyA.node?.name == goal[mapNum].name || contact.bodyB.node?.name == goal[mapNum].name {
            gameOver()
        }
    }
    
    //Called when hitting the goal or score becomes 0
    func gameOver() {
        if let view = self.view {
            //Change the scene to the game over with score
            if let scene = SKScene(fileNamed: "BalanceGameOverScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene, transition: SKTransition.crossFade(withDuration: 1))
                scoreDisplay = scene.childNode(withName: "scoreDisplay") as! SKLabelNode
                if score <= 0 {
                    scoreDisplay.text = "Score: 0"
                }
                //Display the proper score
                else {
                    scoreDisplay.text = "Score: " + String(score)
                }
                scoreDisplay.fontSize = 65
            }
        }
    }
    //Called before every frame is rendered
    override func update(_ currentTime: CFTimeInterval) {
        //First see if the score is 0 or less and the game should end
        if score <= 0 {
            gameOver()
        }
        
        ball.physicsBody?.contactTestBitMask = UInt32(Int(pow(2, Double(mapNum))))
        ball.physicsBody?.categoryBitMask = UInt32(pow(2, Double(mapNum)))
        ball.physicsBody?.collisionBitMask = UInt32(pow(2, Double(mapNum)))
        //Subtract score each frame 
        score -= 500
        //Maintain score display
        scoreDisplay = self.childNode(withName: "scoreDisplay") as! SKLabelNode
        if score <= 0 {
            scoreDisplay.text = "Score: 0"
        }
        else {
            scoreDisplay.text = "Score: " + String(score)
        }
        scoreDisplay.fontSize = 65;
        //Change the gravity depending on how the phone is being tilted
        self.physicsWorld.gravity = CGVector(dx: ((manager.accelerometerData?.acceleration.x ?? 0) * 5), dy: ((manager.accelerometerData?.acceleration.y ?? 0) * 5))
    }
}
