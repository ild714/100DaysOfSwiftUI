//
//  DetailView.swift
//  Challenge4
//
//  Created by Ильдар Нигметзянов on 15.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    var habits : Habits
    @State var title: String = ""
    @State var description : String = ""
    @State var time : String = ""
    
    @State var inccorectInput = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Title")){
                     TextField("Your title",text: $title)
                }
                Section(header: Text("Description")){
                    TextField("Your description",text: $description)
                }
                Section(header: Text("Amount")){
                    TextField("Your times of doing this activity",text: $time)
                }
            }
                
            .alert(isPresented:$inccorectInput){
                Alert(title: Text("Incorrect input"), message: Text("Change amount"), dismissButton: .default(Text("Got it")))
            }
            .navigationBarItems(trailing: Button("save",action: {
                
                
                if let amount = Int(self.time){
                let habit = Habit(title: self.title, description: self.description, amount: amount)
                self.habits.items.append(habit)
                
                    self.presentationMode.wrappedValue.dismiss()}
                else{
                    self.inccorectInput = true
                }
            }))
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: Habits())
    }
}
