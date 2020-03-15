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
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack{
            Form{
                Text("Title")
                TextField("Title",text: $title)
                Text("Description")
                TextField("Description",text: $description)
                Text("Time")
                TextField("Time",text: $time)
                
            }
            Spacer(minLength: CGFloat(10))
            Button("save",action: {
                
                let habit = Habit(title: self.title, description: self.description, time: Int(self.time) ?? 0)
                self.habits.items.append(habit)
                
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habits: Habits())
    }
}
