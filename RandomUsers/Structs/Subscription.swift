//
//  Subscription.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Represents subscription details.
struct Subscription: Codable {
    /// Plan name of the subscription.
    let plan: String
    
    /// Status of the subscription.
    let status: String
    
    /// Payment method used for the subscription.
    let paymentMethod: String
    
    /// Term or duration of the subscription.
    let term: String
    
    /// Coding keys to customize the property names when encoding/decoding.
    enum CodingKeys: String, CodingKey {
        case plan, status
        case paymentMethod = "payment_method"
        case term
    }
}

