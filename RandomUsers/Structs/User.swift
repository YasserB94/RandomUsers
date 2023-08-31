//
//  User.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation

/// Represents a user with various personal and account-related information.
struct User: Codable {
    /// Unique numerical identifier for the user.
    let id: Int
    
    /// Unique identifier as a string for the user.
    let uid: String
    
    /// User's password.
    let password: String
    
    /// User's first name.
    let firstName: String
    
    /// User's last name.
    let lastName: String
    
    /// User's chosen username.
    let username: String
    
    /// User's email address.
    let email: String
    
    /// URL or path to the user's avatar image.
    let avatar: String
    
    /// User's gender.
    let gender: String
    
    /// User's phone number.
    let phoneNumber: String
    
    /// User's social insurance number (if applicable).
    let socialInsuranceNumber: String
    
    /// User's date of birth.
    let dateOfBirth: String
    
    /// Information about the user's employment.
    let employment: Employment
    
    /// User's address information.
    let address: Address
    
    /// User's credit card information.
    let creditCard: CreditCard
    
    /// Information about the user's subscription.
    let subscription: Subscription
    
    /// Coding keys to customize the property names when encoding/decoding.
    enum CodingKeys: String, CodingKey {
        case id, uid, password
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email, avatar, gender
        case phoneNumber = "phone_number"
        case socialInsuranceNumber = "social_insurance_number"
        case dateOfBirth = "date_of_birth"
        case employment, address
        case creditCard = "credit_card"
        case subscription
    }
}
