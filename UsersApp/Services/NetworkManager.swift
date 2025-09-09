//
//  NetworkManager.swift
//  UsersApp
//
//  Created by Leonid on 02.09.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if error != nil {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
