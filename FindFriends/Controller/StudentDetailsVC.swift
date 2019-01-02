//
//  StudentDetailsVC.swift
//  FindFriends
//
//  Created by vasu on 01/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import Foundation
import UIKit

class StudentDetailsVC : UIViewController{
    
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureUI(){
        mTableView.delegate = self
        mTableView.dataSource = self
    }
    
    func fetchData(){
        
    }
}

extension StudentDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
