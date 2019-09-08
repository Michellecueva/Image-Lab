//
//  UserViewController.swift
//  ImagesLab
//
//  Created by Michelle Cueva on 9/8/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    
    var users = [User]() {
        didSet {
            userTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadData()
    }
    
    private func configureTableView() {
        userTableView.dataSource = self
        userTableView.rowHeight = 120
        userTableView.tableFooterView = UIView()
        
    }
    
    private func loadData() {
        
        UserAPIHelper.shared.getUser { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let userFromJSON):
                    self.users = userFromJSON
                }
            }
        }
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UsersTableViewCell
        let user = users[indexPath.row]
        cell.nameLabel.text = user.getFullName()
        cell.ageLabel.text = "Age: \(user.dob.age)"
        cell.cellPhoneLabel.text = "Cell: \(user.cell)"
        
        ImageHelper.shared.getImage(urlStr: user.picture.thumbnail) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let imageFromOnline):
                    cell.userImage.image = imageFromOnline
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "userSegue":
            guard let DetailVC = segue.destination as? UsersDetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = userTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            
            let user = users[selectedIndexPath.row]
            
            DetailVC.user = user
        default:
            fatalError("unexpected segue identifies")
        }
    }
}

extension UserViewController: UITableViewDelegate{}
