//
//  ContentView.swift
//  Project2_GuessTheFlag
//
//  Created by Ильдар Нигметзянов on 17.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    var body: some View {
        Button("Show Alert"){
            self.showingAlert = true
        }.alert(isPresented:$showingAlert){
        Alert(title: Text("Hello"), message: Text("Text"), dismissButton: .default(Text("ok")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
