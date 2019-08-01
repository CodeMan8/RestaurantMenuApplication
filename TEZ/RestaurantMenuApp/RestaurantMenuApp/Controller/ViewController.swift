//
//  ViewController.swift
//  RestaurantMenuApp
//
//  Created by Bartu akman on 12.10.2018.
//  Copyright © 2018 Bartu akman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var gmailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var isSignIn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func showMessage(message: String){
        
        let alertcontroller =  UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        let action =  UIAlertAction(title: "Sorry ", style: UIAlertActionStyle.cancel, handler: nil)
        alertcontroller.addAction(action)
        present(alertcontroller, animated: true, completion: nil)
    }

    @IBAction func login(_ sender: UIButton) {
 
        if let email = gmailText.text, let  pass = passwordText.text {
             Auth.auth().signIn(withEmail: email, password: pass, completion: { (user, err) in
                if err != nil {
                    
                    self.showMessage(message: err!.localizedDescription)
                }
                if user != nil {
                     if AuthProvider.Instance.currentUserID() == Constans.ADMIN_ID {
                        self.performSegue(withIdentifier: "goAdmin", sender: nil)

                     } else {
                        self.performSegue(withIdentifier: "GotoMenu", sender: nil)

                        
                     }
                } else {
                    self.showMessage(message: "Please type email and password")

                    // show message
                }
                
               
            })
           
            
 
    }
        
        
    }
    @IBAction func signUP(_ sender: UIButton) {
 
        if let email = gmailText.text, let  pass = passwordText.text {

        Auth.auth().createUser(withEmail: email, password: pass, completion: { (user, err) in
            if err != nil {
                self.showMessage(message: err!.localizedDescription)
            }
            if user != nil {
                DBProvider.Instance.saveUser(withID: (user?.user.uid)!, email: email, password: pass)
                self.performSegue(withIdentifier: "GotoMenu", sender: nil)
                
            } else {
                // show message
               self.showMessage(message: "Please type email and password")

            }
            
            
        })
        }
        
        
        
    }
    func initiation() {
        gmailText.text = ""
        passwordText.text = ""
         
    }
    
}

