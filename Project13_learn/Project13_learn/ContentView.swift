//
//  ContentView.swift
//  Project13_learn
//
//  Created by Ильдар Нигметзянов on 31.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image"){
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented:$showingImagePicker){
            ImagePicker()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
