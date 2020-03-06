//
//  ContentView.swift
//  Project7_iExpence_practice
//
//  Created by Ильдар Нигметзянов on 05.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class Expenses:ObservableObject {
    
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self,from:items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
    
    @Published var items: [ExpenseItem]{
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded,forKey: "Items")
            }
        }
    }
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(expenses.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        if item.amount <= 10 {
                        Text("$\(item.amount)")
                            .foregroundColor(.green)
                        }else if item.amount > 101 {
                            Text("$\(item.amount)")
                                .foregroundColor(.red)
                        }
                        else {
                            Text("$\(item.amount)")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading:
                
                Button(action:{
                    self.showingAddExpense = true
                    
                },label: {Image(systemName: "plus")}),trailing:
                EditButton()
            )
                .sheet(isPresented: $showingAddExpense){
                    AddView(expenses: self.expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
