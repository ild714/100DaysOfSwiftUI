//
//  ContentView.swift
//  Project11_Bookworn_practice
//
//  Created by Ильдар Нигметзянов on 21.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @FetchRequest(entity:Student.entity(),sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack{
            List{
                Button("Add"){
                    let firstNames = ["Ginny","Harry","Hermione","Ron"]
                    let lastNames = ["Granger","Lovegood","Potter","Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: self.moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    
                    try? self.moc.save()
                }
                ForEach(students, id: \.id){ student in
                    Text(student.name ?? "Unknown")
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
