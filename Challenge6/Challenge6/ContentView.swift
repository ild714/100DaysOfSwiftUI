//
//  ContentView.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var persons = Persons()
    
    @State private var showImagePicker: Bool = false
    @State var image: UIImage?
    
    var body: some View {
        
        NavigationView{
            List(){
                ForEach(0..<persons.persons.count,id: \.self){id in
                    NavigationLink(destination:Detail(persons:self.persons,id:id)){
                        HStack{
                            Image(uiImage: UIImage(data:self.persons.persons[id].dataImage!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width:60,height: 60,alignment: .leading)
                                .clipShape(Circle())
                            VStack(alignment:.leading){
                                TextField("Fill name",text:self.$persons.persons[id].name)
                                TextField("Fill birthday date",text:self.$persons.persons[id].birthday)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: loadImageFromDiskWith)
            .navigationBarTitle("Family and frinends",displayMode: .inline)
            .navigationBarItems(leading: Button(action:{
                self.showImagePicker = true
            }){
                Image(systemName: "plus")
            })
               
        }
        .sheet(isPresented:$showImagePicker,onDismiss:appendPerson){
            PickerImage(isShown: self.$showImagePicker, image: self.$image)
        }
    }
    func appendPerson() {
        persons.persons.append(Person(name: "", birthday: "",dataImage: image?.jpegData(compressionQuality: 0.8)))
        
        let json = JSONEncoder()
        let dataJson = try! json.encode(persons.persons)
        
        guard let documentDirectory = FileManager.default.urls(for:.documentDirectory,in:.userDomainMask).first else {return}
        
        let fileURL = documentDirectory.appendingPathComponent("test")
     
        do {
            try dataJson.write(to:fileURL)
        }catch let error {
            print("error saving json",error)
        }
    }
    
    func loadImageFromDiskWith(){
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first{
            let url = URL(fileURLWithPath: dirPath).appendingPathComponent("test")
            
            let json = JSONDecoder()
            if let data = try? Data(contentsOf: url){
            self.persons.persons = try! json.decode([Person].self, from: data)
            }else {
                return
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
