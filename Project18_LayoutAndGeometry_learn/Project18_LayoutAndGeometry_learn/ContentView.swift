//
//  ContentView.swift
//  Project18_LayoutAndGeometry_learn
//
//  Created by Ильдар Нигметзянов on 30.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

extension VerticalAlignment{
    struct MidAccountAndName: AlignmentID{
        static func defaultValue(in d: ViewDimensions) -> CGFloat{
            d[.top]
        }
    }
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct OuterView: View {
    var body: some View {
        VStack{
            Text("Top")
            InnerView()
                .background(Color.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack{
            Text("Left")
            GeometryReader{
                geo in
                Text("Center")
                    .background(Color.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                        
                }
            }
            .background(Color.orange)
            Text("Right")
        }
    }
}

struct ContentView: View {
    let colors: [Color] = [.red,.green,.gray,.orange,.pink,.yellow,.purple]
    var body: some View {
        GeometryReader{fullView in
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(0..<50){ index in
                        GeometryReader{geo in
                            Rectangle()
                                .fill(self.colors[index % 7])
                                .frame(height: 150)
                                .rotation3DEffect(.degrees(-Double(geo.frame(in:.global).midX - fullView.size.width / 2)/10),axis:(x:0,y:1,z:0))
                            
                        }
                        .frame(width:150)
                    }
                }
                .padding(.horizontal,(fullView.size.width - 150)/2)
            }
        }
        .edgesIgnoringSafeArea(.all)
//        GeometryReader{fullView in
//            ScrollView(.vertical){
//                ForEach(0..<50){ index in
//                    GeometryReader{
//                        geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(width: geo.size.width)
//                            .background(self.colors[index % 7])
//
//                            .rotation3DEffect(.degrees(Double(geo.frame(in:.global).minY - fullView.size.height / 2)/5),axis:(x:0,y:1,z:0))
//                        .onTapGesture {
//                                print("Global center: \(geo.frame(in: .global).minX) x \(geo.frame(in: .global).minY)")
//                                print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
//                                print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
//
//                        }
//                    }
//                    .frame(height: 40)
//                }
//            }
//
//        }
//        OuterView()
//            .background(Color.red)
//            .coordinateSpace(name: "Custom")
//        Text("Hello, World!")
//            .background(Color.red)
//            .padding(20)
//        Color.red
//        Text("Live long and prosper")
//            .frame(width: 300, height: 300,alignment:.topLeading)
//            .offset(x:200,y:100)
        
//        HStack(alignment:.firstTextBaseline){
//            Text("Live")
//                .font(.caption)
//            Text("long")
//            Text("and")
//                .font(.title)
//            Text("prosper")
//                .font(.largeTitle)
//        }
//        VStack(alignment: .leading){
//            ForEach(0..<10) {position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading){
//                        _ in CGFloat(position) * -10
//                }
//            }
//            Text("Hello, world!")
//                .alignmentGuide(.leading){
//                    d in d[.trailing]
//            }
//            Text("This is a longer line of text")
//        }
//        .background(Color.red)
//        .frame(width:400,height:400)
//        .background(Color.blue)
//        HStack(alignment:.midAccountAndName){
//            VStack{
//                Text("water")
//                    .alignmentGuide(.midAccountAndName){d in d[VerticalAlignment.center]
//                }
//                Image("water")
//                    .resizable()
//                    .frame(width: 64,height: 64)
//            }
//            VStack{
//                Text("Full name:")
//                Text("Paul huds")
//                    .alignmentGuide(.midAccountAndName){d in d[VerticalAlignment.center]}
//                    .font(.largeTitle)
//            }
//        }
//        Text("Hello")
//            .background(Color.red)
//            .position(x:100,y:100)
//        Text("Hello, world!")
//            .background(Color.red)
//            .offset(x:100,y:100)
//        GeometryReader { geo in
//            Text("Hello, World!")
//                .frame(width: geo.size.width * 0.9)
//                .background(Color.red)
//
//        }
//        VStack{
//            GeometryReader{geo in
//                Text("Hello, World!")
//                    .frame(width: geo.size.width * 0.9, height: 40)
//                    .background(Color.red)
//            }
//            .background(Color.green)
//            Text("More text")
//                .background(Color.blue)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
