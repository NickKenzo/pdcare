//
//  MemoryGameController.swift
//  SimonSays
//
//  Created by nskinner on 10/25/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MemoryGameVC: UIViewController {
    // Holds the sequence of button to be pressed
    var sequence: [Int] = []
    var gameOver = false
    
    // unpressed == -1
    // red == 0
    // blue == 1
    // green == 2
    var lastPressedButton = -1
    var buttonCount = 0
    var newPress = false
    
    // Used to wait for 3 seconds before displayig the next button to press to the user
    var sequenceCount = 0
    var sequenceTime = 3
    var sequenceDisplayTimer = Timer()
    
    
    // Used for the initial countdown displayed before the game starts
    var startTime = 3
    var startTimer = Timer()
    
    // Used as a time limit between button presses of the player
    var gameTime = 5
    var gameTimer = Timer()


    //@IBOutlet weak var watchOrPlayLabel: UILabel!
    @IBOutlet weak var startCounter: UILabel!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    
    var buttons = [UIButton]()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastPressedButton = -1
        newPress = false
        gameTime = 5
        buttonCount = 0
        sequenceCount = 0
        
        buttons = [red, blue, green]
        startTime = 3
        sequence.append(Int.random(in: 0 ... 2))
        self.disableAndHideButtons(flag: true)
        
        startCounter.text = String(startTime)
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.startGameTimer), userInfo: nil, repeats: true)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @objc func startGameTimer() {
        startTime -= 1
        startCounter.text = String(startTime)
        
        if startTime == 0 {
            startTimer.invalidate()
            self.disableAndHideButtons(flag: false)
            self.showSequence()
            //gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
        }
    }
    
    func showSequence() {
        //watchOrPlayLabel.text = "Watch!"
        self.disableEnableButtons(flag: true)
        sequenceDisplayTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MemoryGameVC.sequenceCountDown), userInfo: nil, repeats: true)
        
        //self.disableEnableButtons(flag: false)
        
    }
    
    @objc func sequenceCountDown() {
        self.flashButton(myButtonTag: sequence[sequenceCount])
        sequenceCount += 1
        if sequenceCount == sequence.count {
            print(sequence)
            sequenceDisplayTimer.invalidate()
            self.disableEnableButtons(flag: false)
            //watchOrPlayLabel.text = "Repeat!"
            sequenceCount = 0
            gameTime = 5
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
        }
    }

    @IBAction func redPressed(_ sender: Any) {
        self.flashButton(myButtonTag: 0)
        lastPressedButton = 0
        self.genericButtonPress()
    }

    @IBAction func bluePressed(_ sender: Any) {
        self.flashButton(myButtonTag: 1)
        lastPressedButton = 1
        self.genericButtonPress()
    }
    
    @IBAction func greenPressed(_ sender: Any) {
        self.flashButton(myButtonTag: 2)
        lastPressedButton = 2
        self.genericButtonPress()
    }
    
    func genericButtonPress() {
        gameTimer.invalidate()
        if lastPressedButton == sequence[buttonCount] {
            buttonCount += 1
            if buttonCount == sequence.count {
                sequence.append(Int.random(in: 0 ... 2))
                self.showSequence()
                buttonCount = 0
            }
            else {
                gameTime = 5
                gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
            }
        }
        else {
            print("show game over scene wrong sequence")
            print("Your Score")
            print(sequence.count - 1)
        }
    }
    
    @objc func playGameTimer() {
        gameTime -= 1
        if gameTime == 0 {
            gameTimer.invalidate()
            print("show game over scene time's up")
            print("Your Score")
            print(sequence.count - 1)
        }
    }
    
    func disableAndHideButtons(flag: Bool) {
        red.isHidden = flag
        red.isEnabled = !flag
        blue.isHidden = flag
        blue.isEnabled = !flag
        green.isHidden = flag
        green.isEnabled = !flag
        startCounter.isHidden = !flag
    }
    
    // If flag is true, disable buttons else, enable
    func disableEnableButtons(flag: Bool) {
        red.isEnabled = !flag
        blue.isEnabled = !flag
        green.isEnabled = !flag
    }
    
    func flashButton(myButtonTag: Int) {
        let viewToAnimate = buttons[myButtonTag]
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0.5, usingSpringWithDamping: 0.2, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
        }
    }
} // End of MemoryGameVC
