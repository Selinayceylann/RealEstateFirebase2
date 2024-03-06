//
//  ViewController.swift
//  RealEstateFirebase2
//
//  Created by selinay ceylan on 5.03.2024.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func goitClicked(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
}

