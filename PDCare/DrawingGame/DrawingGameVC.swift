//
//  BalanceGameVC.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import SpriteKit




class DrawingGameVC: UIViewController,GameOverDelegate{
    func goback() {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func gToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    
    
    @IBOutlet weak var doneOutlet: UILabel!
    @IBOutlet weak var scoreOutlet: UILabel!
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 1.0   //thickness of the drawn lines
    var opacity: CGFloat = 1.0
    var swiped = false
    
    //var game_over : GameOverDelegate?
    
    var gameOverButtons = [UIButton]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
              
        if let view = self.view as! SKView? {
            self.hideGameOverLables()
            // Load the SKScene from 'DrawingGameScene.sks'
            if let scene = DrawingGameScene(fileNamed: "DrawingGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }

    }
    func setUpGame() {
        // Disable and hide buttons initially
        //self.disableAndHideButtons(flag: true)
        mainImageView.image = nil
        self.hideGameOverLables()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Actions
    
    @IBAction func resetPressed(_ sender: Any) { //Reset button
        mainImageView.image = nil
    }
    

    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        tempImageView.image?.draw(in: view.bounds)
        
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        context.strokePath()
        
        tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        tempImageView.alpha = opacity
        
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = false
        lastPoint = touch.location(in: view)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
        //print(currentPoint)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       // if !swiped {
            // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
            gameOver()
            
       // }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
    
    func gameOver() {
        //self.hideAndDisableButtons()
//        if let view = self.view as! SKView? {
//            let scene =
//            view.presentScene(scene)
//
//        }
        self.showGameOverLables()
        self.generateGameOverButtons()
        
    }
    
    func generateGameOverButtons() {
        // Try again button
        let tryAgainButton: UIButton = UIButton(frame: CGRect(x: 90, y: 500, width: 100, height: 50))
        tryAgainButton.backgroundColor = UIColor.red
        tryAgainButton.setTitle("Try Again", for: .normal)
        tryAgainButton.addTarget(self, action: #selector(tryAgainAction), for: .touchUpInside)
        tryAgainButton.tag = 11
        self.view.addSubview(tryAgainButton)
        
        gameOverButtons.append(tryAgainButton)
        
        // Quit button
        let quitButton: UIButton = UIButton(frame: CGRect(x: 210, y: 500, width: 100, height: 50))
        quitButton.backgroundColor = UIColor.red
        quitButton.setTitle("Quit", for: .normal)
        quitButton.addTarget(self, action: #selector(quitAction), for: .touchUpInside)
        quitButton.tag = 12
        self.view.addSubview(quitButton)
        
        gameOverButtons.append(quitButton)
    }
    
    @objc func tryAgainAction(sender: UIButton!) {
        while gameOverButtons.count > 0 {
            gameOverButtons.popLast()?.removeFromSuperview()
        }
        self.setUpGame()
    }
    
    @objc func quitAction(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
    
    func showGameOverLables() {
        doneOutlet.isHidden = false
        //scoreOutlet.text = "Score: " + String(sequence.count - 1)
        scoreOutlet.isHidden = false
    }
    
    func hideGameOverLables() {
        doneOutlet.isHidden = true
        scoreOutlet.isHidden = true
    }
}



