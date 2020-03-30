//
//  Person.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 29.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct Person: Codable,Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int16
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}
