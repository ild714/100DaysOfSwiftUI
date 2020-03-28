//
//  ContentView.swift
//  Project12_CoreDataProject_learn
//
//  Created by Ильдар Нигметзянов on 25.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import CoreData

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
    
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
//   @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: Ship.entity(),sortDescriptors: [],predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
       
//        VStack{
//            List(wizards, id: \.self){ wizard in
//                Text(wizard.name ?? "Unknown")
//            }
//            Button("Add"){
//                let wizard = Wizard(context: self.moc)
//                wizard.name = "Harry"
//            }
//
//            Button("Save"){
//                do {
//                    try self.moc.save()
//                } catch {
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
//        VStack{
//            List(ships,id:\.self){ship in
//                Text(ship.name ?? "Unknown name")
//            }
//
//            Button("Add Examples"){
//                let ship1 = Ship(context: self.moc)
//                ship1.name = "Enterprise"
//                ship1.universe = "Star Trek"
//
//                let ship2 = Ship(context: self.moc)
//                ship2.name = "Defiant"
//                ship2.universe = "Star Trek"
//
//                let ship3 = Ship(context: self.moc)
//                ship2.name = "Millennum Falcon"
//                ship2.universe = "Star Wars"
//
//                let ship4 = Ship(context: self.moc)
//                ship2.name = "Executor"
//                ship2.universe = "Star Wars"
//
//                try? self.moc.save()
//            }
//        }
        
        VStack{
            FilteredList(filterKey:"lastName",filterValue: lastNameFilter,predict:.beginsWith){ (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples"){
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A"){
                self.lastNameFilter = "A"
            }
            
            Button("Show S"){
                self.lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
