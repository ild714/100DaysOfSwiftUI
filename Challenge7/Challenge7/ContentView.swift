//
//  ContentView.swift
//  Challenge7
//
//  Created by Ильдар Нигметзянов on 02.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var firstCube = 0
    @State var secondCube = 0
    
    var body: some View {
        
        TabView{
            
            VStack{
                Button(action: {
                    self.shuffle()
                }){
                    Text("Roll dice")
                }
                HStack{
                    
                    Text("")
                        .frame(width:30,height:30)
                        .background(Color.blue)
                    
                    Text("")
                        .frame(width:30,height:30)
                        .background(Color.blue)
                }
            }
            .tabItem{
                Image(systemName: "app")
                Text("Rolled")
            }
            HStack{
                Text("\(self.firstCube)")
                    .frame(width:30,height:30)
                    .background(Color.blue)
                
                Text("\(self.secondCube)")
                    .frame(width:30,height:30)
                    .background(Color.blue)
            }
            .tabItem{
                Image(systemName: "app.fill")
                Text("Roll dice")
            }
        }
        .onAppear(perform: self.load)
    }
    
    func shuffle() {
        
        self.firstCube = Int.random(in:0...6)
        self.secondCube = Int.random(in:0...6)
        UserDefaults.standard.set(self.firstCube, forKey: "firstCube")
        UserDefaults.standard.set(self.secondCube, forKey: "secondCube")
    }
    
    func load() {
        self.firstCube = UserDefaults.standard.integer(forKey: "firstCube")
        self.secondCube = UserDefaults.standard.integer(forKey: "secondCube")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
