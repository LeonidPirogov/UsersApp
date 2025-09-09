//
//  UserPinView.swift
//  UsersApp
//
//  Created by Leonid on 09.09.2025.
//

import MapKit

final class UserPinView: MKMarkerAnnotationView {
    static let reuseID = "UserPin"

    override var annotation: MKAnnotation? {
        didSet {
            guard let userAnnotation = annotation as? UserAnnotation else { return }
            canShowCallout = true
            glyphImage = UIImage(systemName: "person.fill")
            markerTintColor = .systemBlue

            let avatar = UIImageView(image: UIImage(systemName: "person.circle"))
            avatar.tintColor = .secondaryLabel
            avatar.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
            leftCalloutAccessoryView = avatar

            detailCalloutAccessoryView = UserCalloutView(user: userAnnotation.user)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
    }
}
