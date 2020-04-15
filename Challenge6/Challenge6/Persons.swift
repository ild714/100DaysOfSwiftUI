//
//  Persons.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation
import SwiftUI

enum CodingKeys: CodingKey{
    case person
}

class Persons:ObservableObject,Codable{
    @Published var persons : [Person]
    
    init(){
        persons = [Person]()
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.persons = try values.decode([Person].self,forKey:.person)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(persons,forKey:.person)
    }
    
    
}
