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
    @IBOutlet weak var mActivityIndicator: UIActivityIndicatorView!
    
    var mDataSource : [StudentDetailsResponse]?
    let cell_Identifier = "StudentDetailsTblCell"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        regiterNib()
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func configureUI(){
        showHideloader(show: false)
        mTableView.delegate = self
        mTableView.dataSource = self
    }
    func regiterNib(){
        
        let CellNib = UINib.init(nibName: cell_Identifier, bundle: nil)
        mTableView.register(CellNib, forCellReuseIdentifier: cell_Identifier)
    }
    
    func fetchData(){
        showHideloader(show: true)
        Engine.getUsersLocation { (studentData, error) in
            self.showHideloader(show: false)
            guard studentData != nil else{
                print("User locations error : \(error?.localizedDescription ?? "errorrr")")
                return
            }
            self.mDataSource = studentData?.results
            self.mTableView.reloadData()
        }
    }
    
    func showHideloader(show :Bool){
        
        if show {
            mActivityIndicator.isHidden =  false
            mActivityIndicator.startAnimating()
        }
        else{
            mActivityIndicator.isHidden =  true
            mActivityIndicator.stopAnimating()
        }
    }
}

extension StudentDetailsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_Identifier) as? StudentDetailsTblCell
        
        let data = mDataSource?[indexPath.row]
        
        if let data = data {
           cell?.configureUIwith(name: data.firstName ?? "", profileLink: data.mediaURL ?? "")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected call .....")
    }
    
}
