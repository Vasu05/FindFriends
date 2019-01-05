//
//  AddLocationVC.swift
//  FindFriends
//
//  Created by vasu on 03/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit
import MapKit

class AddLocationVC: UIViewController {

    @IBOutlet weak var mLocationLbl: UITextField!
    @IBOutlet weak var mProfileLinkLbl: UITextField!
    @IBOutlet weak var mFindLocBtn: UIButton!
    
    var localSearchRequest:MKLocalSearch.Request!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearch.Response!
   
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
    
    func showFailure(message: String) {
        let alertVC = UIAlertController(title: "Location Adding failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    @IBAction func findLocationBtnPressed(_ sender: Any) {
        
        guard mLocationLbl.text!.count>2 && mProfileLinkLbl.text!.count > 2 else {
            showFailure(message: "Enter correct Details")
            return
        }
        let locationStr =  mLocationLbl.text
        
        localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = locationStr
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            guard (localSearchResponse != nil) else{
                self.showFailure(message: "Place Not Found")
                return
            }
            
            
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostLocationConfirmationVC") as! PostLocationConfirmationVC
            vc.localSearchResponse = localSearchResponse
            vc.searchlocation = locationStr
            vc.mediaURL = self.mProfileLinkLbl.text!
            self.navigationController?.pushViewController(vc, animated: true)
           
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
