//
//  Detail.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI


struct Detail: View {
    
    var id: Int
    @ObservedObject var persons: Persons
    
    init(persons:Persons,id:Int){
        self.id = id
        self.persons = persons 
    }
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                Image(uiImage: UIImage(data:self.persons.persons[self.id].dataImage!)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white,lineWidth: 2))
                    .shadow(radius: 5)
                VStack(alignment:.leading){
                    
                    Section(header: Text("Name:")){
                        TextField("Name", text: self.$persons.persons[self.id].name,onEditingChanged: {_ in
                            let json = JSONEncoder()
                            let dataJson = try! json.encode(self.persons.persons)
                            
                            guard let documentDirectory = FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first else {return}
                            
                            let fileURL = documentDirectory.appendingPathComponent("test")
                            
                            do {
                                try dataJson.write(to:fileURL)
                            }catch let error {
                                print("error saving json",error)
                            }
                        })
                    }
                    Section(header: Text("Birthday:")){
                        TextField("Birthday", text: self.$persons.persons[self.id].birthday,onEditingChanged: {_ in
                            let json = JSONEncoder()
                            let dataJson = try! json.encode(self.persons.persons)
                            
                            guard let documentDirectory = FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first else {return}
                            
                            let fileURL = documentDirectory.appendingPathComponent("test")
                            
                            do {
                                try dataJson.write(to:fileURL)
                            }catch let error {
                                print("error saving json",error)
                            }
                        })
                    }
                    
                }
                MapView(title: self.persons.persons[self.id].name)
            }
        }
    }
}

