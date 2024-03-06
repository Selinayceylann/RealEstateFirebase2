//
//  AccountViewController.swift
//  RealEstateFirebase2
//
//  Created by selinay ceylan on 5.03.2024.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signInClicked(_ sender: Any) {
        performSegue(withIdentifier: "toEntryVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        performSegue(withIdentifier: "toEntryVC", sender: nil)
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
                  try Auth.auth().signOut()
                  self.performSegue(withIdentifier: "toVC", sender: nil)
                  
              } catch {
                  print("error")
              }
    }
}
