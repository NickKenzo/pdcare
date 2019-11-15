//
//  BalanceGameVC.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import SpriteKit




class DrawingGameVC: UIViewController{
    
    @IBAction func gToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 1.0   //thickness of the drawn lines
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

//
//        let pi = CGFloat(Float.pi)
//        let start:CGFloat = 2.0
//        let end :CGFloat = pi
//
//        // circlecurve
//        let path_1: UIBezierPath = UIBezierPath();
//        path_1.addArc(
//            withCenter: CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2),//centre of screen
//            radius: 60,
//            startAngle: start,
//            endAngle: end,
//            clockwise: true
//        )
//        let layer_1 = CAShapeLayer()
//        layer_1.fillColor = UIColor.clear.cgColor
//        layer_1.strokeColor = UIColor.black.cgColor // color
//        layer_1.path = path_1.cgPath
//        self.view.layer.addSublayer(layer_1)
//
//
//
//        let path_2: UIBezierPath = UIBezierPath();
//        path_2.addArc(
//            withCenter: CGPoint(x:self.view.frame.width/2, y:self.view.frame.height/2),//centre of screen
//            radius: 80,
//            startAngle: start,
//            endAngle: end,
//            clockwise: true
//        )
//        let layer_2 = CAShapeLayer()
//        layer_2.fillColor = UIColor.clear.cgColor
//        layer_2.strokeColor = UIColor.black.cgColor // color
//        layer_2.path = path_2.cgPath
//        self.view.layer.addSublayer(layer_2)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'DrawingGameScene.sks'
            if let scene = DrawingGameScene(fileNamed: "DrawingGameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                //scene.game_over=self

                // Present the scene
                view.presentScene(scene)
            }

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let navController = segue.destination as? UINavigationController,
//            let settingsController = navController.topViewController as? DrawingGameSettingVC else {
//                return
//        }
//        settingsController.delegate = self
//        settingsController.brush = brushWidth
//        settingsController.opacity = opacity
//
//        var red: CGFloat = 0
//        var green: CGFloat = 0
//        var blue: CGFloat = 0
//        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
//        settingsController.red = red
//        settingsController.green = green
//        settingsController.blue = blue
//    }
    
    // MARK: - Actions
    
    @IBAction func resetPressed(_ sender: Any) {
        mainImageView.image = nil
    }
    
//    @IBAction func sharePressed(_ sender: Any) { //for share function
//        guard let image = mainImageView.image else {
//            return
//        }
//        let activity = UIActivityViewController(activityItems: [image], applicationActivities: nil)
//        present(activity, animated: true)
//    }
    
//    @IBAction func pencilPressed(_ sender: UIButton) {
//        guard let pencil = DrawingGamePencil(tag: sender.tag) else {
//            return
//        }
//        color = pencil.color
//        if pencil == .eraser {
//            opacity = 1.0
//        }
//    }
    
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
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            // draw a single point
            drawLine(from: lastPoint, to: lastPoint)
        }
        
        // Merge tempImageView into mainImageView
        UIGraphicsBeginImageContext(mainImageView.frame.size)
        mainImageView.image?.draw(in: view.bounds, blendMode: .normal, alpha: 1.0)
        tempImageView?.image?.draw(in: view.bounds, blendMode: .normal, alpha: opacity)
        mainImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tempImageView.image = nil
    }
}

// MARK: - SettingsViewControllerDelegate

//extension DrawingGameVC: SettingsViewControllerDelegate {
//    func settingsViewControllerFinished(_ settingsViewController: DrawingGameSettingVC) {
//        brushWidth = settingsViewController.brush
//        opacity = settingsViewController.opacity
//        color = UIColor(red: settingsViewController.red,
//                        green: settingsViewController.green,
//                        blue: settingsViewController.blue,
//                        alpha: opacity)
//        dismiss(animated: true)
//    }
    //

