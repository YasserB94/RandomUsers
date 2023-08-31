//
//  Employment.swift
//  RandomUsersApp
//
//  Created by Yasser Bal on 31/08/2023.
//

import Foundation
/// Represents employment details.
struct Employment: Codable {
    /// Job title.
    let title: String
    
    /// Key skill or specialization related to the job.
    let keySkill: String
    
    /// Coding key to customize the property names when encoding/decoding.
    enum CodingKeys: String, CodingKey {
        case title
        case keySkill = "key_skill"
    }
}

