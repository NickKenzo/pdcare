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




    


    @IBOutlet weak var startCounter: UILabel!
    @IBOutlet weak var red: UIButton!
    @IBOutlet weak var blue: UIButton!
    @IBOutlet weak var green: UIButton!
    
    var buttons = [UIButton]()
    
    
    

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
        if lastPressedButton == sequence[buttonCount] {
            gameTimer.invalidate()
            buttonCount += 1
            if buttonCount == sequence.count {
                sequence.append(Int.random(in: 0 ..< 3))
                self.showSequence()
                buttonCount = 0
            }
            gameTime = 5
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
            
        }
        else {
            print("show game over scene wrong sequence")
            gameTimer.invalidate()
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lastPressedButton = -1
        newPress = false
        gameTime = 5
        buttonCount = 0
        
        buttons = [red, blue, green]
        startTime = 3
        sequence.append(Int.random(in: 0 ..< 3))
        self.disableAndHideButtons(flag: true)
        
        startCounter.text = String(startTime)
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.startGameTimer), userInfo: nil, repeats: true)

    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    @objc func startGameTimer() {
        startTime -= 1
        startCounter.text = String(startTime)
        
        if startTime == 0 {
            startTimer.invalidate()
            self.disableAndHideButtons(flag: false)
            self.showSequence()
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func playGameTimer() {
        gameTime -= 1
        if gameTime == 0 {
            gameTimer.invalidate()
            print("show game over scene time's up")
            print(sequence)
        }
    }
    
    func showSequence() {
        self.disableEnableButtons(flag: true)
//        for i in 0 ... (sequence.count - 1) {
//            self.flashButton(myButtonTag: self.sequence[i], myDelay: 3)
//        }
        
//        var i = 0
//        while i < sequence.count {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                self.flashButton(myButtonTag: self.sequence[i])
//                i += 1
//            }
//        }
        
        sequenceDisplayTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MemoryGameVC.sequenceCountDown), userInfo: nil, repeats: true)
        
        
        
        
        
        self.disableEnableButtons(flag: false)

    }
    
    @objc func sequenceCountDown() {
        if sequenceCount == sequence.count {
            sequenceDisplayTimer.invalidate()
            sequenceCount = 0
        }
        self.flashButton(myButtonTag: sequence[sequenceCount])
        sequenceCount += 1
        
        
    }
    

    
    func flashButton(myButtonTag: Int) {
        let viewToAnimate = buttons[myButtonTag]
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            
        }) { (_) in
            UIView.animate(withDuration: 0.15, delay: 0.5, usingSpringWithDamping: 0.3, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
        }
    }
    
    func playerTurn() {
//        var currentPos = 0
//        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryGameVC.playGameTimer), userInfo: nil, repeats: true)
//        while currentPos < sequence.count {
//            if newPress {
//                if sequence[currentPos] == lastPressedButton {
//                    gameTime = 3
//                    newPress = false
//                    currentPos += 1
//                }
//                else {
//                    gameOver = true
//                    break
//                }
//            }
//        }
    }
    
    func playing() {
        while !gameOver {
            self.showSequence()
            self.playerTurn()
            gameOver = true
        }
    }
    
    
    
    
    
    
    
//    func setTitle(_ title: String){
//        print(title)
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    var isWatching = true{
//        didSet{
//            if isWatching{
//                setTitle("Watch!")
//            }
//            else{
//                setTitle("Repeat!")
//            }
//        }
//    }
//    var sequence = [UIButton]()
//    var sequenceIndex = 0
//    func playNextButton(){
//        guard sequenceIndex < sequence.count else{
//            isWatching = false
//            sequenceIndex = 0
//            return
//        }
//        let button = sequence[sequenceIndex]
//        sequenceIndex += 1
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
//            self?.touchdown(button)
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                self?.touchdown(button)
//                self?.playNextButton()
//            }
//        }
//    }
}
