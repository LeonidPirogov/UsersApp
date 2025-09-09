//
//  UserCalloutView.swift
//  UsersApp
//
//  Created by Leonid on 07.09.2025.
//

import UIKit

final class UserCalloutView: UIView {
    private let emailLabel = UILabel()
    private let cityLabel = UILabel()
    init(user: User) {
        super.init(frame: .zero)
        let stack = UIStackView(arrangedSubviews: [emailLabel, cityLabel])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
        emailLabel.font = .systemFont(ofSize: 13)
        cityLabel.font  = .systemFont(ofSize: 13)
        cityLabel.textColor = .secondaryLabel
        emailLabel.text = "📧 \(user.email)"
        cityLabel.text  = "🏙️  \(user.address.city)"
    }
    @available(*, unavailable) required init?(coder: NSCoder) { nil }
}
