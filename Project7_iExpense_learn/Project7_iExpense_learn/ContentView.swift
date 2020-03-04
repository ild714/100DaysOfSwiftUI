//
//  ContentView.swift
//  Project7_iExpense_learn
//
//  Created by Ильдар Нигметзянов on 04.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct User1:Codable {
    
    var firstName: String
    var lastName: String
    
   
    
    
}

struct SecondView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button("Dismiss"){
                   self.presentationMode.wrappedValue.dismiss()
               }
        
    }
}

struct ContentView: View {
    
    //@ObservedObject var user = User()
//    @State private var showingSheet = false
//
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
    
    @State private var user = User1(firstName:"s1",lastName:"s2")
    
    var body: some View {
//        VStack{
//        Text("Your name is \(user.firstName) \(user.lastName).")
//
//        TextField("First name",text: $user.firstName)
//        TextField("Last name",text: $user.lastName)
//        }
        
//        Button("Show Sheet"){
//            self.showingSheet.toggle()
//            }
//            .sheet(isPresented: $showingSheet){
//                SecondView(name: "Ildar")
//            }
        
//        NavigationView{
//            VStack{
//                List{
//                    ForEach(numbers,id: \.self){
//                        Text("\($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add Number"){
//                    self.numbers.append(self.currentNumber)
//                    self.currentNumber += 1
//                }
//            }
//            .navigationBarItems(leading: EditButton())
//
//        }
        
//        Button("Tap count: \(tapCount)"){
//            self.tapCount += 1
//            UserDefaults.standard.set(self.tapCount,forKey: "Tap")
//        }
//    }
//
//    func removeRows(at offsets: IndexSet){
//        numbers.remove(atOffsets: offsets)
//    }
        
        Button("Save User"){
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(self.user){
                UserDefaults.standard.set(data,forKey:"UserData")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
