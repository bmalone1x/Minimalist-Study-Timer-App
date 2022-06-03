//
//  RegisterViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/15/22.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var nameTxtField: UITextField!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        nameTxtField.delegate = self
    }
    

    @IBAction func registerButtonPress(_ sender: UIButton) {
        
        if let email = emailTxtField.text, let password = passwordTxtField.text,
           let name = nameTxtField.text
        {
            Auth.auth().createUser(withEmail: email, password: password)
            { authResult, error in
              
                if let e = error
                {
                    let alert = UIAlertController(title: "Error Registering", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                     
                     alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                     
                     self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("Successfully Registered.")
                    
                    self.emailTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.nameTxtField.text = ""
                    
                    let profileUpdater = authResult?.user.createProfileChangeRequest()
                    profileUpdater?.displayName = name
                    profileUpdater?.commitChanges()
                    
                    
                   let alert = UIAlertController(title: "Registration Successful", message: "Let's start studying!", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    self.tabBarController?.selectedIndex = 1
                }
            }
        }
        
        
        
    }
    

}

extension RegisterViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        if(textField.text != "")
        {
            textField.endEditing(true)
            textField.placeholder = ""
            return true
        }
        
        textField.endEditing(false)
        textField.placeholder = "Can't be empty"
        return false
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        if textField.text == ""
        {
            textField.placeholder = "Can't be empty"
            return false
        }
        
        return true
        
    }
}
