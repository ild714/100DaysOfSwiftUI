//
//  Resort.swift
//  Project19_Ski_resorts_practice
//
//  Created by Ильдар Нигметзянов on 04.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable{
    
   var facilityTypes: [Facility] {
       facilities.map(Facility.init)
   }
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
}
