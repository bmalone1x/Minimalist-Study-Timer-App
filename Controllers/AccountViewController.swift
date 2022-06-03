//
//  AccountViewController.swift
//  Minimalist Study Timer
//
//  Created by Bradley Malone on 4/15/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        navigationController?.isNavigationBarHidden = true
        tabBarController?.selectedIndex = 0
        
        if(DatabaseBrain.isUserLoggedIn())
        {
            
            print()
            print("User Signed in")
            self.performSegue(withIdentifier: "GoToAccountOverview", sender: self)
        
        }
        else
        {
            print()
            print("No User Signed in")
        }
    }

}
