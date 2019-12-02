//
//  ProfileVC.swift
//  PDCare
//
//  Created by Daniel Wan on 11/3/19.
//  Copyright © 2019 PDCare. All rights reserved.
//
//  This view is currently empty, and a placeholder for Version 3
//  Known Bugs: None
//
//  Change history and authors who worked on this file can
//  be found in the Git history here:
//  https://github.com/NickKenzo/pdcare/commits/Version2/PDCare/ProfileVC.swift

import UIKit


class ProfileVC: UIViewController, UITextFieldDelegate {
    
    @IBAction func sToMainMenu(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var UpdateEmail: UITextField!
    @IBOutlet weak var UpdateUsername: UITextField!
    @IBOutlet weak var UpdatePassword: UITextField!    
    @IBOutlet weak var UpdateSuccessful: UILabel!
    
    @IBAction func SaveEdit(_ sender: UIButton) {
        
        guard let textPassword = UpdatePassword.text else { return }
        
        UpdateSuccessful.isHidden = false
        updateUserDetails(userID: defaults.string(forKey: "userID")!, email: defaults.string(forKey: "email")!, username: defaults.string(forKey: "username")!, password: textPassword)
    }
    
    @IBAction func SignOut(_ sender: Any) {
        defaults.set(false, forKey: "saveCredentials")
        performSegue(withIdentifier: "returnToLogin", sender: self)        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserID(username: defaults.string(forKey: "username")!, password: defaults.string(forKey: "password")!)
        UpdateEmail.text = defaults.string(forKey: "email")!
        UpdateUsername.text = defaults.string(forKey: "username")!
        UpdateSuccessful.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        self.UpdatePassword?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //Set allowed characters for textfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.-_")
        return allowedCharacters.isSuperset(of: CharacterSet(charactersIn: string))
    }
    
    //Closes keyboard when return is tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

func setUserID(username: String, password: String){
    
    let initURL = "http://pdcare14.com/api/login.php?username=pdcareon_admin&password=pdcareadmin&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        guard let data = data else { return }
        let APIdata = String(data: data, encoding: .utf8)!
        
        //Storing User Information
        defaults.set(GrabUserData(userData: APIdata, inputRegex: "\"uid\":\"(.+)\",\"name"), forKey: "userID")
    }
    task.resume()
}


func updateUserDetails(userID: String, email: String, username: String, password: String) {
        
    let initURL = "http://pdcare14.com/api/editprofile.php?username=pdcareon_admin&password=pdcareadmin&uid=\(userID)&email=\(email)&uname=\(username)&upwd=\(password)"
    let url = URL(string: initURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        
        defaults.set(password, forKey: "password")
        
    }
    task.resume()
    return
}
