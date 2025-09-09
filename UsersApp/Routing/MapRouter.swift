//
//  MapRouter.swift
//  UsersApp
//
//  Created by Leonid on 07.09.2025.
//

import UIKit

struct MapRouter {
    weak var navigationController: UINavigationController?

    func showDetails(for user: User) {
        let mapStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mapViewController = mapStoryboard.instantiateViewController(
            withIdentifier: "UserDetailsViewController"
        ) as? UserDetailsViewController else {
            assertionFailure("No VC with Storyboard ID 'UserDetailsViewController'")
            return
        }
        mapViewController.user = user
        mapViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(mapViewController, animated: true)
    }
}

