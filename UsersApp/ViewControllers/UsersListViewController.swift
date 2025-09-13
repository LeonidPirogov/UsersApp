//
//  ViewController.swift
//  UsersApp
//
//  Created by Leonid on 26.08.2025.
//

import UIKit

final class UsersListViewController: UITableViewController {
    
    private var users: [User] = []
    private let spinner = UIActivityIndicatorView(style: .medium)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        spinner.hidesWhenStopped = true
        tableView.backgroundView = spinner
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        loadUsers()
    }
    
    @objc private func refresh() {
            loadUsers()
        }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        guard let cell = cell as? UserCell else { return UITableViewCell() }
        let user = users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetail",
           let detailVC = segue.destination as? UserDetailsViewController,
           let indexPath = tableView.indexPathForSelectedRow {
                detailVC.user = users[indexPath.row]
            }
    }
}

// MARK: - Networking
private extension UsersListViewController {
    func loadUsers() {
        if !(refreshControl?.isRefreshing ?? false) { spinner.startAnimating() }

        NetworkManager.shared.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.spinner.stopAnimating()
                self.refreshControl?.endRefreshing()

                switch result {
                case .success(let users):
                    self.users = users
                    self.tableView.reloadData()
                case .failure(let error):
                    print("❌ Error:", error)
                }
            }
        }
    }
}


