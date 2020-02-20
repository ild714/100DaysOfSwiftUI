//
//  ContentView.swift
//  Project3_ViewsAndModifiers_learn
//
//  Created by Ильдар Нигметзянов on 20.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View{
        Text(text)
            .font(.largeTitle)
        .padding()
            //.foregroundColor(.white)
            .background(Color.blue)
        .clipShape(Capsule())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View{
        content
            .font(.largeTitle)
    }
}

struct ContentView: View {
    var body: some View {
//        Text("Hello, World!")
//            .frame(maxWidth:.infinity,maxHeight:.infinity)
//            .background(Color.green)
//            .edgesIgnoringSafeArea(.all)
        
//        Button("Hello world"){
//            print(type(of: self.body))
//        }
//        .frame(width:200,height:200)
//        .background(Color.red)
//
        
//        Text("Hello world")
//        .padding()
//            .background(Color.red)
//        .padding()
//            .background(Color.blue)
//        .padding()
//            .background(Color.green)
        
//        VStack {
//            Text("test")
//                .font(.largeTitle)
//            Text("test")
//        }
//
        VStack(spacing:10){
            
            CapsuleText(text:"First")
                .foregroundColor(.yellow)
            CapsuleText(text:"Second")
                .titleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View{
    func titleStyle() -> some View{
    self.modifier(Title())
    }
}
