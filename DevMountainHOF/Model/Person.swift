//
//  Person.swift
//  DevMountainHOF
//
//  Created by Devin Singh on 1/23/20.
//  Copyright © 2020 Devin Singh. All rights reserved.
//

import Foundation

struct Person: Codable {
    let personID: Int?
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case personID = "person_id"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
