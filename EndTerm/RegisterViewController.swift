//
//  RegisterViewController.swift
//  EndTerm
//
//  Created by Manav Sethi on 2019-12-04.
//  Copyright © 2019 Manav Sethi. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var newPic: Bool?
    var emailAddress: String = ""
    var password: String = ""
       
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    //var image: UIImage?
    @IBOutlet weak var ConfirmPassTextField: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var BioTextField: UITextField!
    @IBOutlet weak var ProfilePic: UIImageView!
    override func viewDidLoad() {
          super.viewDidLoad()
        self.PasswordTextField.isSecureTextEntry = true
         self.ConfirmPassTextField.isSecureTextEntry = true
        self.hideKeyboardWhenTappedAround()
          // Do any additional setup after loading the view.
        addImageToUIImageView()
      }
    func addImageToUIImageView(){
        let emptyImage: UIImage = UIImage(named: "empty_profile")!
      ProfilePic.image = emptyImage
    }
    

    @IBAction func SetPicture(_ sender: Any) {
        let myAlert = UIAlertController(title:"Select image From ",message: "",preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title:"Camera",style: .default){ (action) in
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                let imagePicker = UIImagePickerController();
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                self.present(imagePicker,animated: true,completion: nil)
                self.newPic = true;
                
            }
        }
        let cameraRollAction = UIAlertAction(title:"Camera Roll",style: .default){ (action) in
                if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary)){
                    let imagePicker = UIImagePickerController();
                    imagePicker.delegate = self;
                    imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    imagePicker.mediaTypes = [kUTTypeImage as String]
                    imagePicker.allowsEditing = false
                    self.present(imagePicker,animated: true,completion: nil)
                    self.newPic = false;
                }
            }
            myAlert.addAction(cameraAction)
            myAlert.addAction(cameraRollAction)
            self.present(myAlert,animated: true)
        }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String){
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
           ProfilePic.image = image
        }
        self.dismiss(animated:true,completion: nil)
    }
    @IBAction func SignUp(_ sender: Any) {
         let email: String
        email = EmailTextField.text!
         
         let password: String
         password = PasswordTextField.text!
         
         let confPassword: String
         confPassword = ConfirmPassTextField.text!
         
         let username: String
         username = UsernameTextField.text!
         
         let shortBio: String
         shortBio = BioTextField.text!
        if (email == "" && password == "" && confPassword == "" && username == "" && shortBio == "") {
            let alert = UIAlertController(title: "Oops!!", message: "Please fill out the values and sign up!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (isValidEmail(emailStr: email) == false) {
            let alert = UIAlertController(title: "Invalid Email!!", message: "Please fill valid email and login!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            print("Sign up Success...")
            performSegue(withIdentifier: "homeSegue", sender: self)
        }
        
    }
    func isValidEmail(emailStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
  
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
    let nextViewController = segue.destination as! ProfileViewController
    nextViewController.image = ProfilePic.image
    nextViewController.username = UsernameTextField.text!
        nextViewController.bio = BioTextField.text!
    

    
}
}
