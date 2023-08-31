//
//  Coordinates.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Represents geographic coordinates using latitude and longitude.
struct Coordinates: Codable {
    /// Latitude value of the coordinates.
    let lat: Double
    
    /// Longitude value of the coordinates.
    let lng: Double
}

