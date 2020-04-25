//
//  ContentView.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private(set) var prospects = Prospects()
    
    
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem{
                    Image(systemName: "person.3")
                    Text("Everyone")
            }
            ProspectsView(filter: .contancted)
                .tabItem{
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
            }
            ProspectsView(filter: .uncontacted)
                .tabItem{
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
            }
            MeView()
                .tabItem{
                    Image(systemName:"person.crop.square")
                    Text("Me")
            }
        }.environmentObject(prospects)
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
