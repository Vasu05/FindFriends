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
    var reloadBtnTapped:Bool = false
   
    
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
        
        let editButton   = UIBarButtonItem(image: editImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapAddButton))
        let searchButton = UIBarButtonItem(image: reloadImage,  style: .plain, target: self, action: #selector(StudentDetailsVC.didTapReloadButton))
        
        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogoutButton))
        
        self.navigationItem.leftBarButtonItem = logoutBtn
        
        self.navigationItem.rightBarButtonItems = [editButton,searchButton]
        
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
        
        if Engine.mDataSource == nil || reloadBtnTapped{
            self.showHideloader(show: true)
            Engine.getUsersLocation { (studentData, error) in
                self.showHideloader(show: false)
                guard studentData != nil else{
                    self.showFailure(message: error!.localizedDescription)
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
    
    
    @objc func didTapAddButton() {
        
        let addLocationVC = storyboard?.instantiateViewController(withIdentifier:"AddLocationVC") as! AddLocationVC
        navigationController?.pushViewController(addLocationVC, animated: true)
        
    }
    @objc func didTapLogoutButton() {
        let login = storyboard?.instantiateViewController(withIdentifier:"LogInController") as! LogInController
        
        navigationController?.pushViewController(login, animated: true)
    }
    @objc func didTapReloadButton() {
        reloadBtnTapped = true
        fetchData()
    }
    
    func showFailure(message: String) {
        
        let alertVC = UIAlertController(title: "Map Locations", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
        
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
        
        let studentDetails = mTableDataSource?[indexPath.row]
        
        let url = URL(string: studentDetails?.mediaURL ?? "")
        
        guard let urlvalue = url else{
            showFailure(message: "URL Missing...")
            return
        }
        let app = UIApplication.shared
        if app.canOpenURL(urlvalue){
            app.openURL(urlvalue)
        }
        else{
           showFailure(message: "Invalid URL...")
        }
       
    }
    
}
