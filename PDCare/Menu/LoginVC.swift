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
    
    @IBAction func openMainMenuLogin(_ sender: Any) {
        var textLoginUsername = LoginUsername.text
        var textLoginPassword = LoginPassword.text
        performSegue(withIdentifier: "MainMenuSegue", sender: self)     
    }
    
    @IBAction func openMainMenuSignUp(_ sender: Any) {
        var textSignUpEmail = SignUpEmail.text
        var textSignUpFirstName = SignUpFirstName.text
        var textSignUpUsername = SignUpUsername.text
        var textSignUpPassword = SignUpPassword.text
        performSegue(withIdentifier: "MainMenuSegue", sender: self)
    }

    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBOutlet weak var SignUpEmail: UITextField!
    @IBOutlet weak var SignUpFirstName: UITextField!
    @IBOutlet weak var SignUpUsername: UITextField!
    @IBOutlet weak var SignUpPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        
        
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


