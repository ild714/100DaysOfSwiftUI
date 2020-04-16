//
//  EditedPerson.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 16.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct EditedPerson: View {

    
    @ObservedObject var persons: Persons
    var image: UIImage?
    @State var name: String = ""
    @State var birthday: String = ""
    @Binding var isShown: Bool
    @Binding var activeSheet: ActiveSheet
    
    init(persons:Persons,image: UIImage,isShown: Binding<Bool>,activeSheet:Binding<ActiveSheet>){
        self.persons = persons
        self.image = image
        _isShown = isShown
        _activeSheet = activeSheet
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Name")){
                    TextField("Fill name", text: $name)
                }
                Section(header: Text("Birthday")){
                    TextField("Fill birthday", text: $birthday)
                }
            }
            .navigationBarItems(leading: Button(action:{
                self.appendPerson()
                self.isShown = false
            }){
               Text("Add")
            })
            .navigationBarTitle("Fill all fields",displayMode: .inline)
        }
        
    }
    
    func appendPerson(){
        self.persons.persons.append(Person(name: name, birthday: birthday,dataImage: image?.jpegData(compressionQuality: 0.8)))
        
        let json = JSONEncoder()
            let dataJson = try! json.encode(persons.persons.sorted())
           
           guard let documentDirectory = FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first else {return}
           
           let fileURL = documentDirectory.appendingPathComponent("test")
        
           do {
               try dataJson.write(to:fileURL)
           }catch let error {
               print("error saving json",error)
           }
        
        self.activeSheet = .first
    }
    
    
}

