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
import Foundation

class LoginVC: UIViewController {
    
    // Set persistent user settings
    let defaults = UserDefaults.standard

    @IBAction func openSignUpScreen(_ sender: Any) {
        performSegue(withIdentifier: "LoginScreenSegue", sender: self)
    }
    
    @IBAction func openMainMenuLogin(_ sender: Any) {
        
        guard let textLoginUsername = LoginUsername.text else { return }
        guard let textLoginPassword = LoginPassword.text else { return }
        
        if(callLogin(username: textLoginUsername, password: textLoginPassword)){

            defaults.set(textLoginUsername, forKey: "username")
            performSegue(withIdentifier: "MainMenuSegue", sender: self)
        }
    }
    
    @IBAction func openMainMenuSignUp(_ sender: Any) {
        
        guard let textSignUpEmail = SignUpEmail.text else { return }
        guard let textSignUpFirstName = SignUpFirstName.text else { return }
        guard let textSignUpUsername = SignUpUsername.text else { return }
        guard let textSignUpPassword = SignUpPassword.text else { return }
           
        if(callSignUp(email: textSignUpEmail, firstname: textSignUpFirstName, username: textSignUpUsername, password: textSignUpPassword)){
            
            defaults.set(textSignUpUsername, forKey: "username")
            performSegue(withIdentifier: "MainMenuSegue", sender: self)
        }
    }

    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBOutlet weak var SignUpEmail: UITextField!
    @IBOutlet weak var SignUpFirstName: UITextField!
    @IBOutlet weak var SignUpUsername: UITextField!
    @IBOutlet weak var SignUpPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.hideKeyboardWhenTappedAround()
        
        
        
    }    
    
    
}


func callLogin(username: String, password: String) -> Bool {
        
    var Success = false
    let initURL = "http://pdcare14.com/api/login.php?username=pdcareon_admin&password=pdcareadmin&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        
        //Validating login
        if String(data: data, encoding: .utf8)!.contains("{") {
            Success = true
        }
    }
    task.resume()
    sleep(1) //to make the http request happen before returning
    return Success
}

func callSignUp(email: String, firstname: String, username: String, password: String) -> Bool {
        
    var Success = false
    let initURL = "http://pdcare14.com/api/createprofile.php?username=pdcareon_admin&password=pdcareadmin&name=\(firstname)&email=\(email)&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        
        //Validating login
        if String(data: data, encoding: .utf8)!.contains("There is already a user with that email or username.") == false {
            Success = true
        }
    }
    task.resume()
    sleep(1) //to make the http request happen before returning
    return Success
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

//extension String
//{
//    func hashtags() -> [String]
//    {
//          
//    }
//}

//dismiss keyboard when tapping anywhere
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}




