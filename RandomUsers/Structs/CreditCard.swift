//
//  CreditCard.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Represents credit card information.
struct CreditCard: Codable {
    /// Credit card number.
    let ccNumber: String
    
    /// Coding key to customize the property name when encoding/decoding.
    enum CodingKeys: String, CodingKey {
        case ccNumber = "cc_number"
    }
}
