//
//  Prospect.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"
    
    init(){
        if let data = UserDefaults.standard.data(forKey: Self.saveKey){
            if let decoded = try? JSONDecoder().decode([Prospect].self,from: data){
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people){
            UserDefaults.standard.set(encoded,forKey: Self.saveKey)
        }
    }
    
    func toggle(_ prospect: Prospect){
           objectWillChange.send()
           prospect.isContacted.toggle()
            save()
       }
    
    func add(_ prospect: Prospect){
        people.append(prospect)
        save()
    }
}


class Prospect: Identifiable, Codable{
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}
