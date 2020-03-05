//
//  ExpenseItem.swift
//  Project7_iExpence_practice
//
//  Created by Ильдар Нигметзянов on 05.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable,Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}


