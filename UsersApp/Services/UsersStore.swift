//
//  UsersStore.swift
//  UsersApp
//
//  Created by Leonid on 09.09.2025.
//

import Foundation

final class UsersStore {
    private(set) var annotations: [UserAnnotation] = []
    private var indexByUsername: [String: UserAnnotation] = [:]

    func load(completion: @escaping (Result<[UserAnnotation], Error>) -> Void) {
        NetworkManager.shared.fetchUsers { [weak self] result in
            switch result {
            case .success(let users):
                let userAnnotations = users.map { UserAnnotation(user: $0) }
                self?.annotations = userAnnotations
                self?.indexByUsername = Dictionary(uniqueKeysWithValues: userAnnotations.map { ($0.user.username, $0) })
                completion(.success(userAnnotations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func annotation(for user: User) -> UserAnnotation? {
        indexByUsername[user.username]
    }
}
