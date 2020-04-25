//
//  Prospect.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    static let saveKey = "SavedData"
    
    init(){
//                if let data = UserDefaults.standard.data(forKey: Self.saveKey){
        do{
            let path = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask)
            let url = path[0].appendingPathComponent("message")
            let data = try Data(contentsOf: url)
                if let decoded = try? JSONDecoder().decode([Prospect].self,from: data){
                    self.people = decoded
                    return
                }
            
        }catch {
            print("error")
        }
        
        self.people = []
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,in:.userDomainMask)
        return paths[0]
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people){
//            UseDefaults.standard.set(encoded,forKey: Self.saveKey)
            let url = self.getDocumentDirectory().appendingPathComponent("message")
            do {
                try encoded.write(to: url)
                
            } catch {
                print(error.localizedDescription)
            }
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


class Prospect: Identifiable, Codable,Comparable{
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name
    }
    
    
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool{
        lhs.name < rhs.name
    }
}
