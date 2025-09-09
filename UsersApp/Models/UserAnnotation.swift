//
//  UserAnnotation.swift
//  UsersApp
//
//  Created by Leonid on 05.09.2025.
//

import MapKit


final class UserAnnotation: MKPointAnnotation {
    let user: User
    init(user: User) {
        self.user = user
        super.init()
        title = user.name
        subtitle = "@\(user.username)"
        coordinate = .init(
            latitude: Double(user.address.geo.lat) ?? 0,
            longitude: Double(user.address.geo.lng) ?? 0
        )
    }
}
