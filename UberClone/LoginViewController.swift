//
//  LoginViewController.swift
//  UberClone
//
//  Created by Eslam Moemen on 2018-06-30.
//  Copyright © 2018 Eslam Moemen. All rights reserved.
//
import UIKit
import FirebaseAuth
import MBProgressHUD

class LoginViewController: ViewController {
    
    @IBOutlet weak var uberLogin: UILabel!
    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //  MARK: LOG IN BUTTON
    
    @IBAction func login(_ sender: Any) {
            
        
            
        
            performSegue(withIdentifier: "goLocation", sender: self)
            //load MBProgressHUD
            progressHUD()
            
            // check for empty entery
            if emailLogin.text == "" || passwordLogin.text == "" {
                self.displayAlert(title: "Error", message: "you should fill up your data")
                MBProgressHUD.hide(for: self.view, animated: true)
            }
            
            Auth.auth().signIn(withEmail: emailLogin.text!, password: passwordLogin.text!) { (user, error) in
                
                if error != nil {
                    
                    self.displayAlert(title: "Error", message: error!.localizedDescription)
                    MBProgressHUD.hide(for: self.view, animated: true)
                }else{
                    
                    self.displayAlert(title: "Login Success!", message: "")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                }
            }
        
    
    
    
            
            
        
    
    
        }
        
        
    }
    

   
    

