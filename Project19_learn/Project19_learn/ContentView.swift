//
//  ContentView.swift
//  Project19_learn
//
//  Created by Ильдар Нигметзянов on 03.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Text("Hello, World!")
                .navigationBarTitle("Primary")
            Text("Secondary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
