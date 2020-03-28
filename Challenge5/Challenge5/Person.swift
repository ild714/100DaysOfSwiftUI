//
//  Person.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 28.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct Person: Codable,Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
