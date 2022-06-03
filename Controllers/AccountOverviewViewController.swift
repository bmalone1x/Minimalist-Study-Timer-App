//
//  AccountOverviewViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/17/22.
//

import UIKit
import FirebaseAuth

class AccountOverviewViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        userNameLabel.text = Auth.auth().currentUser?.displayName
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tabBarController?.selectedIndex = 0
        
    }
    

    @IBAction func logOutButtonPress(_ sender: UIButton) {
        
        do
        {
            try Auth.auth().signOut()
            
        }
        catch let e
        {
            let alert = UIAlertController(title: "Error Logging Out", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
             
             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
             
             self.present(alert, animated: true, completion: nil)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}

