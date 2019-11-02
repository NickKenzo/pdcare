//
//  BalanceGameVC.swift
//  PDCare
//
//  Created by ksmolko on 10/28/19.
//  Copyright © 2019 PDCare. All rights reserved.
//

import UIKit
import SpriteKit

class DrawingGameVC: UIViewController {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "DrawingGameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return .allButUpsideDown
//        } else {
//            return .all
//        }
//    }
    
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var lastPoint = CGPoint.zero
    var color = UIColor.black
    var brushWidth: CGFloat = 5.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }
    
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

