//
//  LoginViewController.swift
//  L1_TS
//
//  Created by Seda on 01/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

   
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleAppName: UILabel!
    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
   
    @IBOutlet weak var passLogError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func signInButton(_ sender: Any) {
        guard loginField.text != "", passwordField.text != "" else{
            passLogError.text = "Fill in the login and password"
            passLogError.textColor = UIColor.red
            return
        }
       
        if(loginField.text=="seda" && passwordField.text == "12345"){
            passLogError.text = "Valid login and password"
            passLogError.textColor = UIColor.green
        }
        
        else {
            passLogError.text = "Incorrect login or password"
            passLogError.textColor = UIColor.red
     }
        
        
    }
}
    

