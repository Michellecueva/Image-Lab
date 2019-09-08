//
//  UsersDetailViewController.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class UsersDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userLargeImage: UIImageView!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UITextView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setImage()

    }
    
    private func setLabels() {
        nameLabel.text = user.getFullName()
        ageLabel.text = user.dob.age.description
        phoneLabel.text = user.phone
        cellLabel.text = user.cell
        locationLabel.text = user.getFullAddress()
    }
    
    private func setImage() {
        ImageHelper.shared.getImage(urlStr: user.picture.large) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    self.userLargeImage.image = imageFromOnline
                }
            }
        }
    }
}
