//
//  EditedCell.swift
//  Challenge4
//
//  Created by Ильдар Нигметзянов on 17.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct EditedCell: View {
    
    var habit : Habit
   
    
    var body: some View {
       
            Form{
                Section(header:Text("Description:")){
                    Text(habit.description)
                }
                
                Section(header:Text("Amount")){
                    Text(String(habit.amount))
                }
            }
        
    }
}

struct EditedCell_Previews: PreviewProvider {
    static var previews: some View {
        EditedCell(habit:Habit(title: "test", description: "test", amount: 10))
    }
}
