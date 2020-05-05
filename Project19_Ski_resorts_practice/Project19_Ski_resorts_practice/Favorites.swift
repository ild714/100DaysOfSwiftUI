//
//  Favorites.swift
//  Project19_Ski_resorts_practice
//
//  Created by Ильдар Нигметзянов on 05.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
    
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init(){
        let res = UserDefaults.standard.object(forKey: saveKey) as? [String] ?? [String]()
        self.resorts = []
        for i in res {
            self.resorts.insert(i)
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        var array : [String] = []
        for i in resorts{
            array.append(i)
        }
        UserDefaults.standard.set(array, forKey: saveKey)
    }
}
