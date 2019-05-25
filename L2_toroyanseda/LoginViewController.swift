//
//  LoginViewController.swift
//  L2_toroyanseda
//
//  Created by Seda on 04/03/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore



class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    
    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passLogError: UILabel!
    
    
    @IBOutlet weak var dot1Image: UIImageView!
   
    
    @IBOutlet weak var dot2Image: UIImageView!
    
    @IBOutlet weak var dot3Image: UIImageView!
    
    var listener: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
     // жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
     
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        
    }


    
    
    // Появление клавиатуры
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // когда клавиатура изчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener = Auth.auth().addStateDidChangeListener{ _, user in
            if user != nil{
                self.performSegue(withIdentifier: "loginSegue", sender: self)
            }
        }
        
        // уведомления о появлении и исчезновении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        Auth.auth().removeStateDidChangeListener(listener!)
        
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //исчезновение клавиатуры при клике по пустому месту
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
   

    @IBAction func registerButton(_ sender: Any) {
        guard let login = loginField.text,
        let password = passwordField.text
            else{
                return
        }
        Auth.auth().createUser(withEmail: login, password: password) { (result, error) in
            
            
            print("result",result)
            print(error)
        }
        
        
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
       /* UIView.animate(withDuration: 1, delay:0.2,options:.repeat, animations: {
            self.dot1Image.alpha = 1
        })
        UIView.animate(withDuration: 1, delay: 0.4, options:.repeat,  animations: {
            self.dot2Image.alpha = 1
        })
        UIView.animate(withDuration: 1, delay: 0.6, options:.repeat, animations: {
           self.dot3Image.alpha = 1
        })*/
        guard let login = loginField.text,
            let password = passwordField.text
            else{
                return
        }
 
        Auth.auth().signIn(withEmail: login, password: password) { (result, error) in
           
           print(result)
            print(error)
        }
  
    }
}
