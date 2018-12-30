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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureUI()  {
        mPasswordField.isSecureTextEntry = true
        mLogInBtn.layer.cornerRadius = 4.0;
    }

}

