//
//  User.swift
//  UsersApp
//
//  Created by Leonid on 26.08.2025.
//

import Foundation

struct User: Codable {
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    init(name: String, username: String, email: String, phone: String, website: String, address: Address, company: Company) {
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }
    
    init(userDetails: [String: Any]) {
        name = userDetails["name"] as? String ?? ""
        username = userDetails["username"] as? String ?? ""
        email = userDetails["email"] as? String ?? ""
        phone = userDetails["phone"] as? String ?? ""
        website = userDetails["website"] as? String ?? ""
        
        let addressJSON = userDetails["address"] as? [String: Any] ?? [:]
        let companyJSON = userDetails["company"] as? [String: Any] ?? [:]
        
        address = Address(addressDetails: addressJSON)
        company = Company(companyDetails: companyJSON)
    }
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }
    
    init(addressDetails: [String: Any]) {
        street = addressDetails["street"] as? String ?? ""
        suite = addressDetails["suite"] as? String ?? ""
        city = addressDetails["city"] as? String ?? ""
        zipcode = addressDetails["zipcode"] as? String ?? ""
        
        let geoJSON = addressDetails["geo"] as? [String: Any] ?? [:]
        
        geo = Geo(geoDetails: geoJSON)
    }
}

struct Geo: Codable {
    let lat: String
    let lng: String
    
    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    
    init(geoDetails: [String: Any]) {
        lat = geoDetails["lat"] as? String ?? ""
        lng = geoDetails["lng"] as? String ?? ""
    }
}

struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }
    
    init(companyDetails: [String: Any]) {
        name = companyDetails["name"] as? String ?? ""
        catchPhrase = companyDetails["catchPhrase"] as? String ?? ""
        bs = companyDetails["bs"] as? String ?? ""
    }
}
