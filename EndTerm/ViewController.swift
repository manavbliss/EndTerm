//
//  ViewController.swift
//  EndTerm
//
//  Created by Manav Sethi on 2019-12-04.
//  Copyright © 2019 Manav Sethi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lblPasswordValid: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    var validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPassword.isSecureTextEntry = true
        self.hideKeyboardWhenTappedAround()
    
        // Do any additional setup after loading the view.
    }

    @IBAction func LogIn(_ sender: Any) {
        guard  let email = txtEmail.text, let password = txtPassword.text else {
            return
            
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false) {
            let alert = UIAlertController(title:"Alert", message: "please enter a valid Email", preferredStyle: .alert)
                      let action = UIAlertAction(title: "Ok", style: .default, handler:nil)
                      
                          alert.addAction(action)
            present(alert, animated: true, completion: nil)
           return
        }
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
           let alert = UIAlertController(title:"Alert", message: "please enter a valid Password with Minimum 8 characters at least 1 Alphabet and 1 Number", preferredStyle: .alert)
           let action = UIAlertAction(title: "Ok", style: .default, handler:nil)
                      
               alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        self.performSegue(withIdentifier: "login", sender: self)
        
    }
    
    @IBAction func SignUp(_ sender: Any) {
        guard  let email = txtEmail.text, let password = txtPassword.text else {
            return
            
        }
        let isValidateEmail = self.validation.validateEmailId(emailID: email)
        if (isValidateEmail == false) {
            let alert = UIAlertController(title:"Alert", message: "please enter a valid Email", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler:nil)
            
                alert.addAction(action)

             present(alert, animated: true, completion: nil)
          
           return
        }
        let isValidatePass = self.validation.validatePassword(password: password)
        if (isValidatePass == false) {
            let alert = UIAlertController(title:"Alert", message: "please enter a valid Password with Minimum 8 characters at least 1 Alphabet and 1 Number", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler:nil)
                       
                alert.addAction(action)
            present(alert, animated: true, completion: nil)
           
           return
        }
        self.performSegue(withIdentifier: "signup", sender: self)
        
    }
}
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

