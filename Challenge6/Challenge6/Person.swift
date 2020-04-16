//
//  Person.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation
import SwiftUI


struct Person:Codable,Identifiable,Comparable {
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    var id = UUID()
    var name: String
    var birthday: String
    var dataImage: Data?
    
    init(name:String,birthday:String,dataImage:Data?){
        self.name = name
        self.birthday = birthday
        self.dataImage = dataImage
    }
    
}



