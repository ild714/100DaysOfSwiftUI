//
//  AddView.swift
//  Project7_iExpence_practice
//
//  Created by Ильдар Нигметзянов on 05.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct AddView: View {
    
    @ObservedObject var expenses: Expenses
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    static let types = ["Business","Personal"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name",text: $name)
                Picker("Type",selection: $type){
                    ForEach(Self.types,id:\.self){
                        Text($0)
                    }
                }
                TextField("Amount",text:$amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save"){
                if let actualAmount = Int(self.amount){
                    let item = ExpenseItem(name:self.name,type:self.type,amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses:Expenses())
    }
}
