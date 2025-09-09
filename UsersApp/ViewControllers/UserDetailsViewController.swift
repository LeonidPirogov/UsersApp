//
//  UserDetailsViewController.swift
//  UsersApp
//
//  Created by Leonid on 03.09.2025.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    var user: User?
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        guard let user = user else { return }
        
        title = user.name
        
        userNameLabel.text = "\(user.username)"
        emailLabel.text = "\(user.email)"
        phoneLabel.text = "\(user.phone)"
        websiteLabel.text = "\(user.website)"
        
        addressLabel.text = """
            \(user.address.city), \(user.address.street)
            \(user.address.suite), \(user.address.zipcode)
            """
        
        companyLabel.text = """
            \(user.company.name)
            \(user.company.catchPhrase)
            \(user.company.bs)
            """
    }
    
    @IBAction func showLocationTapped() {
        guard let user = user else { return }

            guard let tabBarController = tabBarController, let viewControllers = tabBarController.viewControllers else {
                assertionFailure("TabBarController not found")
                return
            }

            for viewController in viewControllers {
                if let navigationController = viewController as? UINavigationController,
                   let mapVC = navigationController.viewControllers.first(where: { $0 is UsersMapViewController }) as? UsersMapViewController {
                    mapVC.singleUser = user
                    navigationController.popToRootViewController(animated: false)
                    tabBarController.selectedViewController = navigationController
                    return
                } else if let mapVC = viewController as? UsersMapViewController {
                    mapVC.singleUser = user
                    tabBarController.selectedViewController = mapVC
                    return
                }
            }

            let detailsStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let mapVC = detailsStoryboard.instantiateViewController(withIdentifier: "UsersMapViewController") as? UsersMapViewController else {
                assertionFailure("No viewController with Storyboard ID 'UsersMapViewController")
                return
            }
            mapVC.singleUser = user
            mapVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(mapVC, animated: true)
    }
}
