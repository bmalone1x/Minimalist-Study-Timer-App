//
//  LoginViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/15/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.becomeFirstResponder()
        
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
    }
    
    @IBAction func loginButtonPress(_ sender: UIButton) {
        
        if let email = emailTxtField.text, let password = passwordTxtField.text
        {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error
                {
                    let alert = UIAlertController(title: "Error Logging In", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                     
                     alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                     
                     self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    print("Successfully Logged In")
                    self.emailTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.emailTxtField.becomeFirstResponder()
                    self.performSegue(withIdentifier: "SuccessfullyLoggedIn", sender: self)
                }
        }
        
        
    }
    

}
    
}


extension LoginViewController : UITextFieldDelegate
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
        
        return true
        
    }
}
