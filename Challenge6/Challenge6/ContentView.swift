//
//  ContentView.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var persons = Persons()
    
    @State private var showImagePicker: Bool = false
    @State var uimage :UIImage?
    
    var body: some View {
        NavigationView{
            List(persons.persons){ person in
                VStack{
                    NavigationLink(destination:Detail(person:person)){
                        Image(uiImage: self.uimage!)
                            .resizable()
                            .scaledToFit()
                        TextField("Enter name",text:person.$name)
                        TextField("Enter date",text:person.$birthday)
                    }
                }
            }
            .navigationBarTitle("Family and frinends")
            .navigationBarItems(leading: Button("Add"){
                self.showImagePicker = true
            })
        }
        .sheet(isPresented:$showImagePicker,onDismiss:appendPerson){
            PickerImage(isShown: self.$showImagePicker, image: self.$uimage)
        }
    }
    func appendPerson() {
        persons.persons.append(Person(photo:uimage!, name: "test", birthday: "test"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
