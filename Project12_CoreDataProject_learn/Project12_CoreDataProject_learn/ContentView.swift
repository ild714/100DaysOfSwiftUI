//
//  ContentView.swift
//  Project12_CoreDataProject_learn
//
//  Created by Ильдар Нигметзянов on 25.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
//    var body: some View {
//        List{
//            ForEach([2,4,6,8,10],id: \.self){
//                Text("\($0) is even")
//            }
//        }
//    }
    
//    let students = [Student(name:"Harry Potter"),Student(name:"Harry Potter")]
//
//    var body: some View{
//        List(students,id: \.self){ student in
//            Text(student.name)
//        }
//    }
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    var body: some View {
        VStack{
            List(wizards, id: \.self){ wizard in
                Text(wizard.name ?? "Unknown")
            }
            Button("Add"){
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry"
            }
            
            Button("Save"){
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
