//
//  AnnotationIndex.swift
//  UsersApp
//
//  Created by Leonid on 09.09.2025.
//

import Foundation

struct AnnotationIndex {
    private(set) var all: [UserAnnotation] = []
    private var byUsername: [String: UserAnnotation] = [:]

    mutating func rebuild(from userAnnotations: [UserAnnotation]) {
        all = userAnnotations
        byUsername = Dictionary(uniqueKeysWithValues: userAnnotations.map { ($0.user.username, $0) })
    }

    func find(_ user: User) -> UserAnnotation? { byUsername[user.username] }
}
