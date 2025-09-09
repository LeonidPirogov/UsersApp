//
//  ViewController.swift
//  UsersApp
//
//  Created by Leonid on 26.08.2025.
//

import UIKit

struct API {
    static let dataURL = URL(string: "https://jsonplaceholder.typicode.com/users")!
}

final class UsersListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
    }
    
    private func fetchUser() {
        URLSession.shared.dataTask(with: API.dataURL) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                dump(users)
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
}

