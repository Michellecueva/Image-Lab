//
//  UsersTableViewCell.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var ageLabel: UILabel!
    
    
    @IBOutlet weak var cellPhoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
