//
//  Address.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Represents an address with location details.
struct Address: Codable {
    /// City of the address.
    let city: String
    
    /// Name of the street.
    let streetName: String
    
    /// Complete street address.
    let streetAddress: String
    
    /// ZIP code of the area.
    let zipCode: String
    
    /// State or region of the address.
    let state: String
    
    /// Country of the address.
    let country: String
    
    /// Geographic coordinates (latitude and longitude) of the address.
    let coordinates: Coordinates
    
    /// Coding keys to customize the property names when encoding/decoding.
    enum CodingKeys: String, CodingKey {
        case city
        case streetName = "street_name"
        case streetAddress = "street_address"
        case zipCode = "zip_code"
        case state, country, coordinates
    }
}
