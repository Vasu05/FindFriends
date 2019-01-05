//
//  ViewController.swift
//  FindFriends
//
//  Created by vasu on 30/12/18.
//  Copyright © 2018 Vasu. All rights reserved.
//

import UIKit

class LogInController: UIViewController {

    
    @IBOutlet weak var mNameField: UITextField!
    @IBOutlet weak var mPasswordField: UITextField!
    @IBOutlet weak var mLogInBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        showHideloader(show: false)
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func configureUI()  {
        mPasswordField.isSecureTextEntry = true
        mLogInBtn.layer.cornerRadius = 4.0;
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if !validation(){
            showLoginFailure(message: "Enter correct Details")
        }
        else{
            showHideloader(show: true)
            Engine.login(usrname: mNameField.text!, password: mPasswordField.text!) {
                (success, Error) in
                self.showHideloader(show: false)
                if success! {
                    print("login successfully")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier:"HomePageVC") as! HomePageVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                     self.showLoginFailure(message: Error!.localizedDescription)
                }
            }
        }
    }
    

    
    func validation() -> Bool {
        var shouldReturn : Bool = true
        
        if let namefield = mNameField.text{
            
            if namefield.count < 2{
                shouldReturn = false
            }
        }
        
        if let passfield = mPasswordField.text{
            
            if passfield.count < 2{
                shouldReturn = false;
            }
        }
        return shouldReturn
    }
    
    func showLoginFailure(message: String) {
      
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)

    }
    
    func showHideloader(show :Bool){
        
        if show {
            activityIndicator.isHidden =  false
            activityIndicator.startAnimating()
        }
        else{
            activityIndicator.isHidden =  true
            activityIndicator.stopAnimating()
        }
    }
}

