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
    
    // Holds references to pressable buttons
    var buttons = [UIButton]()
    
    var animateButtonTag = 0
    var colours = [[179.0, 0.0, 0.0], [0.0, 163.0, 204.0],
                   [0.0, 204.0, 102.0], [255.0, 0.0, 0.0],
                   [0.0, 204.0, 255.0], [0.0, 255.0, 0.0]]
    
    // unpressed == -1
    // red == 0
    // blue == 1
    // green == 2
    var lastPressedButton = -1
    var buttonCount = 0
    
    // Used to wait for 3 seconds before displayig the next button to press to the user
    var sequenceCount = 0
    var sequenceTime = 3
    var sequenceDisplayTimer = Timer()
    
    // Used for the initial countdown displayed before the game starts
    var startTime = 3
    var startTimer = Timer()
    
    // Used as a time limit between button presses of the player
    var gameTime = 4
    var gameTimer = Timer()
    
    // Used to wait some time to change button color
    var buttonColorTimer = Timer()
    
    // Game over label outlets
    @IBOutlet weak var gameOverOutlet: UILabel!
    @IBOutlet weak var scoreOutlet: UILabel!
    
    //@IBOutlet weak var watchOrPlayLabel: UILabel!
    @IBOutlet weak var startCounter: UILabel!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setUpGame()
    }
    
    func setUpGame() {
        // Disable and hide buttons initially
        self.disableAndHideButtons(flag: true)
        self.hideGameOverLables()
        
        red.backgroundColor = UIColor(red: CGFloat(colours[0][0])/255.0, green: CGFloat(colours[0][1])/255.0, blue: CGFloat(colours[0][2])/255.0, alpha: 0.5)
        blue.backgroundColor = UIColor(red: CGFloat(colours[1][0])/255.0, green: CGFloat(colours[1][1])/255.0, blue: CGFloat(colours[1][2])/255.0, alpha: 0.5)
        green.backgroundColor = UIColor(red: CGFloat(colours[2][0])/255.0, green: CGFloat(colours[2][1])/255.0, blue: CGFloat(colours[2][2])/255.0, alpha: 0.5)
        
        // Populate pressable buttons array
        buttons = [red, blue, green]
        
        // Add the first button to sequence
        sequence = []
        sequence.append(Int.random(in: 0 ... 2))
        
        lastPressedButton = -1 // No button is pressed
        gameTime = 4
        buttonCount = 0
        sequenceCount = 0
        
        startTime = 3 // Game countdown is 3 seconds
        startCounter.text = String(startTime)
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.startGameTimer), userInfo: nil, repeats: true)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // A timer which changes the text value of a label on the game screen
    // The label is used as a countdown timer to tell the player when the game will start
    @objc func startGameTimer() {
        startTime -= 1
        startCounter.text = String(startTime)
        
        if startTime == 0 {
            startTimer.invalidate()
            self.disableAndHideButtons(flag: false) // Enable and unhide buttons
            self.showSequence()
        }
    }
    
    // This function will be used to cycle through the sequence of buttons to be pressed and visually animate them to the player
    func showSequence() {
        self.disableEnableButtons(flag: true)
        sequenceDisplayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.sequenceCountDown), userInfo: nil, repeats: true)
    }
    
    // When this function is entered, the next button to display will be animated
    @objc func sequenceCountDown() {
        self.flashButton(myButtonTag: sequence[sequenceCount])
        sequenceCount += 1
        
        // Stop when the sequenceCount is equal to the length of the sequence array
        if sequenceCount == sequence.count {
            print(sequence)
            sequenceDisplayTimer.invalidate()
            self.disableEnableButtons(flag: false)
            sequenceCount = 0
            self.resetGameTimer()
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
                self.resetGameTimer()
            }
        }
        else {
            print("show game over scene wrong sequence")
            print("Your Score")
            print(sequence.count - 1)
            self.gameOver()
        }
    }
    
    func resetGameTimer() {
        gameTime = 4
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
    }
    
    @objc func playGameTimer() {
        gameTime -= 1
        if gameTime == 0 {
            gameTimer.invalidate()
            print("show game over scene time's up")
            print("Your Score")
            print(sequence.count - 1)
            self.gameOver()
        }
    }
    
    // If flag is true, all buttons are hidden and disabled
    // If flag is false, all buttons are shown and enabled
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
    
    func hideAndDisableButtons() {
        red.isHidden = true
        blue.isHidden = true
        green.isHidden = true
        red.isEnabled = false
        blue.isEnabled = false
        green.isEnabled = false
    }
    
    @objc func buttonAnimationTimer() {
        buttons[animateButtonTag].backgroundColor = UIColor(red: CGFloat(colours[animateButtonTag][0])/255.0, green: CGFloat(colours[animateButtonTag][1])/255.0, blue: CGFloat(colours[animateButtonTag][2])/255.0, alpha: 0.5)
        buttonColorTimer.invalidate()
    }
    
    // Used to animate a specified button
    func flashButton(myButtonTag: Int) {
        let viewToAnimate = buttons[myButtonTag] // get button from buttons array that is indexed by myButtonTag
        animateButtonTag = myButtonTag
        buttonColorTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(MemoryGameVC.buttonAnimationTimer), userInfo: nil, repeats: true)
        
        viewToAnimate.backgroundColor = UIColor(red: CGFloat(colours[myButtonTag + 3][0])/255.0, green: CGFloat(colours[myButtonTag + 3][1])/255.0, blue: CGFloat(colours[myButtonTag + 3][2])/255.0, alpha: 0.5)
        
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
        }
    }
       
    func gameOver() {
        self.hideAndDisableButtons()
    }
    
    func generateGameOverInfo() {
        self.showGameOverLables()
    }
    
    func showGameOverLables() {
        gameOverOutlet.isHidden = false
        scoreOutlet.text = "Score: " + String(sequence.count - 1)
        scoreOutlet.isHidden = false
    }
    
    func hideGameOverLables() {
        gameOverOutlet.isHidden = true
        scoreOutlet.isHidden = true
    }
    
} // End of MemoryGameVC
