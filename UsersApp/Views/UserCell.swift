//
//  UserCell.swift
//  UsersApp
//
//  Created by Leonid on 02.09.2025.
//

import UIKit

final class UserCell: UITableViewCell {
    
    @IBOutlet var userFullNameLabel: UILabel!
    @IBOutlet var userNameCityLabel: UILabel!
    
    func configure(with user: User) {
        userFullNameLabel.text = user.name
        userNameCityLabel.text = "@\(user.username)   ·   \(user.address.city)"
    }
}
