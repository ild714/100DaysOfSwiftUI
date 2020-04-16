//
//  ContentView.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

enum ActiveSheet{
    case first,second
}

struct ContentView: View {
    
    @ObservedObject var persons = Persons()
    
    @State private var showImagePicker: Bool = false
    @State var image: UIImage?
    @State private var activeSheet: ActiveSheet = .first
    
    var body: some View {
        
        NavigationView{
            List(){
                ForEach(0..<persons.persons.count,id: \.self){id in
                    NavigationLink(destination:Detail(persons:self.persons,id:id)){
                        HStack{
                            Image(uiImage: UIImage(data:self.persons.persons[id].dataImage!)!)
                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                                .frame(width:60,height: 60,alignment: .leading)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white,lineWidth: 3))
                                .shadow(radius: 5)
                            VStack(alignment:.leading){
                                Text(self.persons.persons[id].name)
                                Text(self.persons.persons[id].birthday)
                            }
                        }
                    }
                }
//                .onDelete(perform:delete)
               
            }
            .onAppear(perform: loadImageFromDiskWith)
            .navigationBarTitle("Family and frinends",displayMode: .inline)
            .navigationBarItems(leading: Button(action:{
                self.showImagePicker = true
                self.activeSheet = .first
            }){
                Image(systemName: "plus")
            })
               
        }
        .sheet(isPresented:$showImagePicker,onDismiss:test){
            if self.activeSheet == .first {
                PickerImage(isShown: self.$showImagePicker,image:self.$image,activeSheet:self.$activeSheet)
            }else {
                EditedPerson(persons: self.persons, image: self.image!,isShown:self.$showImagePicker,activeSheet:self.$activeSheet)
            }
        }
    }
    
    func test(){
        if activeSheet == .second{
            self.showImagePicker = true
        } else {
            self.showImagePicker = false
            loadImageFromDiskWith()
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
                let unwrappedData = try! json.decode([Person].self, from: data)
                self.persons.persons = Array(unwrappedData).sorted()
            }else {
                return
            }
        }
    }
    
    func delete(at offsets: IndexSet){
        persons.persons.remove(atOffsets: offsets)
        
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
