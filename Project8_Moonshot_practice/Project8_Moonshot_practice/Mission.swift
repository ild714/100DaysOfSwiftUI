//
//  Mission.swift
//  Project8_Moonshot_practice
//
//  Created by Ильдар Нигметзянов on 08.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable{
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var name : String {
        "Crew names: \(crew[0].name),\(crew[1].name),\(crew[2].name)"
    }
 
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}


