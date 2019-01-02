//
//  StudentDetailsTblCell.swift
//  FindFriends
//
//  Created by vasu on 02/01/19.
//  Copyright © 2019 Vasu. All rights reserved.
//

import UIKit

class StudentDetailsTblCell: UITableViewCell {

    @IBOutlet weak var mContentView: UIView!
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mName: UILabel!
    
    @IBOutlet weak var mProfileLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mContentView.layer.cornerRadius = 4.0
        // Initialization code
    }

    func configureUIwith(name: String,profileLink:String)  {
        mName.text = name
        mProfileLbl.text = profileLink
    }
    
    
}
