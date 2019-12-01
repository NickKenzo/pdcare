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

// Set persistent user settings
let defaults = UserDefaults.standard

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var LoginUsername: UITextField!
    @IBOutlet weak var LoginPassword: UITextField!
    @IBOutlet weak var SignUpEmail: UITextField!
    @IBOutlet weak var SignUpFirstName: UITextField!
    @IBOutlet weak var SignUpUsername: UITextField!
    @IBOutlet weak var SignUpPassword: UITextField!
    @IBOutlet weak var SaveCredentials: UISwitch?
    

    @IBAction func changeSaveCredentials(_ sender: UISwitch) {
        defaults.set(SaveCredentials!.isOn, forKey: "saveCredentials")
    }
    
    @IBAction func openSignUpScreen(_ sender: Any) {
        performSegue(withIdentifier: "LoginScreenSegue", sender: self)
    }
    
    @IBAction func openMainMenuLogin(_ sender: Any) {
        
        guard let textLoginUsername = LoginUsername.text else { return }
        guard let textLoginPassword = LoginPassword.text else { return }
        
        if(callLogin(username: textLoginUsername, password: textLoginPassword)){

            performSegue(withIdentifier: "MainMenuSegue", sender: self)
        }
    }
    
    @IBAction func openMainMenuSignUp(_ sender: Any) {
        
        guard let textSignUpEmail = SignUpEmail.text else { return }
        guard let textSignUpFirstName = SignUpFirstName.text else { return }
        guard let textSignUpUsername = SignUpUsername.text else { return }
        guard let textSignUpPassword = SignUpPassword.text else { return }
           
        if(callSignUp(email: textSignUpEmail, firstName: textSignUpFirstName, username: textSignUpUsername, password: textSignUpPassword)){
            
            performSegue(withIdentifier: "MainMenuSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        SaveCredentials?.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        if !(exist(key: "saveCredentials")){
            defaults.set(false, forKey: "saveCredentials")
        }
        SaveCredentials?.isOn = defaults.bool(forKey: "saveCredentials")
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if ((SaveCredentials?.isOn ?? false) && exist(key: "username") && exist(key: "password")){
            
            if(callLogin(username: defaults.string(forKey: "username")!, password: defaults.string(forKey: "password")!)){

                performSegue(withIdentifier: "MainMenuSegue", sender: self)
            }
        }        
    }
    
    
}


//API call for Logging in
func callLogin(username: String, password: String) -> Bool {
        
    var Success = false
    let initURL = "http://pdcare14.com/api/login.php?username=pdcareon_admin&password=pdcareadmin&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        let APIdata = String(data: data, encoding: .utf8)!
        
        //Validating login
        if APIdata.contains("{") {
            
            defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"uid\":\"(.+)\",\"name"), forKey: "userID")
            defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"uname\":\"(.+)\",\"upwd"), forKey: "username")
            defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"upwd\":\"(.+)\",\"create"), forKey: "password")
            defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"email\":\"(.+)\",\"uname"), forKey: "email")
            defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"name\":\"(.+)\",\"email"), forKey: "firstName")
                
            Success = true
        }
    }
    task.resume()
    sleep(1) //to make the http request happen before returning
    return Success
}

//API call for Signing in
func callSignUp(email: String, firstName: String, username: String, password: String) -> Bool {
        
    var Success = false
    let initURL = "http://pdcare14.com/api/createprofile.php?username=pdcareon_admin&password=pdcareadmin&name=\(firstName)&email=\(email)&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        
        //Validating login
        if String(data: data, encoding: .utf8)!.contains("There is already a user with that email or username.") == false {
            
            defaults.set(username, forKey: "username")
            defaults.set(password, forKey: "password")
            defaults.set(email, forKey: "email")
            defaults.set(firstName, forKey: "firstName")
            
            Success = true
        }
    }
    task.resume()
    sleep(1) //to make the http request happen before returning
    return Success
}

//String Parse
func GrabUserData(userData: String, inputRegex: String) -> String {

    let regex = try! NSRegularExpression(pattern: inputRegex)
    let result = regex.matches(in:userData, range:NSMakeRange(0, userData.utf16.count))
    let range = result[0].range(at: 1)
    let output = (userData as NSString).substring(with: range)
    return output
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




