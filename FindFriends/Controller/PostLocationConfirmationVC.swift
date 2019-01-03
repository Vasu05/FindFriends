//
//  PostLocationConfirmationVC.swift
//  FindFriends
//
//  Created by vasu on 04/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit
import MapKit

class PostLocationConfirmationVC: UIViewController {

    @IBOutlet weak var mMapView: MKMapView!
    @IBOutlet weak var finishBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configureUI(){
        finishBtn.layer.cornerRadius = 4.0
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
