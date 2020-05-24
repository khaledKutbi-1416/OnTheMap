//  ViewController.swift
//  OnThaMap
//  Created by Khaled Kutbi on 17/09/1441 AH.
//  Copyright © 1441 udacity. All rights reserved.


import UIKit

class LogInViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var usenameTextField: TextFields!
    @IBOutlet weak var passwordTextField: TextFields!
  
    //MARK: - Properties
    let activityView = UIActivityIndicatorView(style: .medium)
    
       
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideKeyboardOnTap()
        
    }
    //MARK:- Actions
   
    @IBAction func signupAction(_ sender: Any) {
        UIApplication.shared.open(UdacityClient.Endpoints.Signup.url)
    }
    @IBAction func loginAction(_ sender: Any) {
    
        if usenameTextField.text == "" || passwordTextField.text == ""{
            showALert(title: "Messgae", message: "Please make sure to fill all the requaired fields ")
         
        }else{
            DispatchQueue.main.async {
                UdacityClient.loginRequest(username: self.usenameTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.hanleLoginResponse(success:error:))
                self.activityView.stopAnimating()
            }
        }
        
    }
    //MARK:- Handlers
    
    func hanleLoginResponse(success: Bool,error:Error?){
        
        if success {
            self.performSegue(withIdentifier: "toMap", sender: nil)
            
        }else{
            showALert(title: "Messgae", message: error?.localizedDescription ?? "")
        }
    }

}

