//
//  NetworkManager.swift
//  UsersApp
//
//  Created by Leonid on 02.09.2025.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case requestFailed(AFError)
    case noData
    case parsingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users"
        
        AF.request(url).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .failure(let afError):
                completion(.failure(.requestFailed(afError)))
            case .success(let data):
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let array = jsonObject as? [[String: Any]] else {
                        completion(.failure(.parsingError))
                        return
                    }
                    
                    let users = array.map { User(userDetails: $0) }
                    completion(.success(users))
                } catch {
                    completion(.failure(.parsingError))
                }
            }
        }
    }
}
