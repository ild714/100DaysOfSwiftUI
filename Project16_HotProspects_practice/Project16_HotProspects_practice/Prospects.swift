//
//  Prospects.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init(){
        self.people = []
    }
}
