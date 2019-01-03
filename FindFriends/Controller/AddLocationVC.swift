//
//  AddLocationVC.swift
//  FindFriends
//
//  Created by vasu on 03/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit

class AddLocationVC: UIViewController {

    @IBOutlet weak var mLocationLbl: UITextField!
    @IBOutlet weak var mProfileLinkLbl: UITextField!
    @IBOutlet weak var mFindLocBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    

    
    func configureUI(){
        mFindLocBtn.layer.cornerRadius = 4.0;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        let logoutBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapEditButton))
        
        self.navigationItem.leftBarButtonItem = logoutBtn
    }
    
    @objc func didTapEditButton() {
       
        self.navigationController?.popViewController(animated: true)
    }
    
    func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Location Adding failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }

    @IBAction func findLocationBtnPressed(_ sender: Any) {
        
        guard mLocationLbl.text!.count<2 || mProfileLinkLbl.text!.count < 2 else {
            showLoginFailure(message: "Enter correct Details")
            return
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
