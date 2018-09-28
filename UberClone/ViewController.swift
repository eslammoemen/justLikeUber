//
//  ViewController.swift
//  UberClone
//
//  Created by Eslam Moemen on 2018-06-30.
//  Copyright © 2018 Eslam Moemen. All rights reserved.
//

import UIKit
import FirebaseAuth
import MBProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var uberLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var driverSwitch: UISwitch!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //progress HUD Method
    func progressHUD (){
       
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading"
        
    }
    
    //hide keyboard when click away
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    



    //Alert Method
    func displayAlert (title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)

        
    }
   
    // MARK: SIGN UP BUTTON
    @IBAction func signUp(_ sender: Any) {
       
        
        progressHUD()
        
        if email.text == "" || password.text == "" {
            
            displayAlert(title: "Missing Data", message: "you should fill up your data")
       
        }
        
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
            
            if error != nil {
                
                self.displayAlert(title: "Error", message: error!.localizedDescription)
                MBProgressHUD.hide(for: self.view, animated: true)

            }else{
              
                
               MBProgressHUD.hide(for: self.view, animated: true)
                
                self.displayAlert(title: "Sign up Success!", message: "")
                

            }
        }
        
        
        
    }
    
    
    
    // MARK: SIGN IN BUTTON
    @IBAction func logIn(_ sender: Any) {


        self.performSegue(withIdentifier: "goLogin", sender: self)

    }

    
    
}

