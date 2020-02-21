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

//struct Title: ViewModifier {
//    func body(content: Content) -> some View{
//        content
//            .font(.largeTitle)
//    }
//}

struct largeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .heavy, design: .default))
            .foregroundColor(.blue)
            
    }
}

extension View {
    func largeFont() -> some View {
        self.modifier(largeTitle())
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
        .padding()
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier{
    var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int,Int) -> Content
    
    var body: some View {
        VStack{
            ForEach(0..<rows,id: \.self){row in
                HStack{
                    ForEach(0..<self.columns,id:\.self){
                        column in
                            self.content(row,column)
                    }
                }
            }
        }
    }
    init(rows: Int,columns: Int,@ViewBuilder content: @escaping
        (Int,Int) -> Content){
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

struct ContentView: View{
    var body: some View{
//        GridStack(rows:4,columns: 3){row,col in
//
//                Image(systemName: "\(row*4 + col).circle")
//                Text("R\(row) C\(col)")
//
//        }
        Text("Hello")
        .largeFont()
    }
}

//struct ContentView: View {
//    @State private var useRedText = false
//    var motto1 : some View {Text("Draco dor")}
//    let motto2 = Text("nuclear")
//
//    var body: some View {
//        Text("Hello, World!")
//            .frame(maxWidth:.infinity,maxHeight:.infinity)
//            .background(Color.green)
//            .edgesIgnoringSafeArea(.all)
        
//        Button("Hello world"){
//            print(type(of: self.body))
//        }
//        .background(Color.red)
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
//        VStack(spacing:10){
//
//            CapsuleText(text:"First")
//                .foregroundColor(.yellow)
//            CapsuleText(text:"Second")
//                .titleStyle()
//        }
        
        
//       Button("Hello"){
//           self.useRedText.toggle()
//       }
//      .foregroundColor(useRedText ? .red : .blue)
        
//        VStack {
//            Text("1")
//            Text("2")
//        }
//        .font(.title)
//        VStack{
//            motto1
//            motto2
//        }
//        VStack(spacing:20){
//            VStack(spacing: 10){
//                CapsuleText(text: "First")
//                    .foregroundColor(.green)
//                CapsuleText(text: "Second")
//            }
//            VStack(spacing:10){
//                CapsuleText(text: "1")
//                CapsuleText(text: "2")
//            }
//        }
//        Color.blue
//            .frame(width: 300,height: 200)
//        .watermarked(with: "Swift")
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

extension View {
    func watermarked(with text:String) -> some View {
        self.modifier(Watermark(text: text))
    }
}
