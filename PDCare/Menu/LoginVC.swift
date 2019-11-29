//
//  ViewController.swift
//  PDCare
//  CMPT 275 Group 14 "P.D. Caretakers"
//
//  Created by Daniel Wan on 2019-11-27.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This file is the view controller for the main application
//  This file currently only contains the option to move to the games menu
//
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version1/PDCare/LoginVC.swift

import UIKit

class LoginVC: UIViewController {

    @IBAction func openSignUpScreen(_ sender: Any) {
        performSegue(withIdentifier: "LoginScreenSegue", sender: self)
    }
    
    @IBAction func openMainMenu(_ sender: Any) {
        performSegue(withIdentifier: "MainMenuSegue", sender: self)     
    }
    
    @IBOutlet weak var TitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.red,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeWidth : -4.0,
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
            as [NSAttributedString.Key : Any]
        //Making outline here
        TitleLabel.attributedText = NSMutableAttributedString(string: "Welcome to P.D. Care", attributes: strokeTextAttributes)
        
        
        
    }    
    
    
}

//Adds UI button color, width, radius attributes to storyboard editor

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

//dismiss keyboard when tapping anywhere

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


