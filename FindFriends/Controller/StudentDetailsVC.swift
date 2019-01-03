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
    
    var mTableDataSource : [StudentDetailsResponse]?
    let cell_Identifier = "StudentDetailsTblCell"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        regiterNib()
        fetchData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = false
        
        
        let editImage    = UIImage(named: "plus")!
        let reloadImage  = UIImage(named: "reload")!
        
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapEditButton))
        let searchButton = UIBarButtonItem(image: reloadImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapSearchButton))
        
        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapEditButton))
        
        self.navigationItem.leftBarButtonItem = logoutBtn
        
        self.navigationItem.rightBarButtonItems = [editButton,searchButton]
        
    }
    @objc func didTapEditButton() {
        
    }
    @objc func didTapSearchButton() {
        
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
        
        if Engine.mDataSource == nil{
            self.showHideloader(show: true)
            Engine.getUsersLocation { (studentData, error) in
                self.showHideloader(show: false)
                guard studentData != nil else{
                    print("User locations error : \(error?.localizedDescription ?? "errorrr")")
                    return
                }
                self.mTableDataSource = studentData?.results
                self.mTableView.reloadData()
            }
        }
        else{
            mTableDataSource = Engine.mDataSource
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
        
        let data = mTableDataSource?[indexPath.row]
        
        if let data = data {
           cell?.configureUIwith(name: data.firstName ?? "", profileLink: data.mediaURL ?? "")
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mTableDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selected call .....")
    }
    
}
