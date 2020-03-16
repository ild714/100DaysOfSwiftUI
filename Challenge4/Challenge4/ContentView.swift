//
//  ContentView.swift
//  Challenge4
//
//  Created by Ильдар Нигметзянов on 15.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class Habits:ObservableObject {
    
    @Published var items : [Habit] {
        didSet{
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(items){
                UserDefaults.standard.set(data, forKey: "Date")
            }
        }
    }
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey:"Date"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Habit].self, from: data){
                self.items = decoded
                return
            }
        }
        
        self.items = []
    }
}

struct ContentView: View {
    
    @ObservedObject var habits = Habits()
    @State var showDetailView = false
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(habits.items){item in
                    HStack{
                        VStack(alignment: .leading){
                            Text("Title:")
                                .font(.headline)
                            Text(item.title)
                            Spacer(minLength: CGFloat(20))
                            Text("Description:")
                                .font(.headline)
                            Text(item.description)
                            
                        }
                        Spacer()
                        Text("Time: \(String(item.amount))")
                        NavigationLink(destination: DetailView(habits: habits))
                    }
                    
                }
                .onDelete(perform: remove)
            }
                
            .navigationBarItems(trailing: Button(action:{
                self.showDetailView = true
            },label: {
                Image(systemName: "plus")
            }))
                .sheet(isPresented: $showDetailView){
                    DetailView(habits: self.habits)
            }
        }
    }
    
    func remove(at index: IndexSet){
        habits.items.remove(atOffsets: index)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
