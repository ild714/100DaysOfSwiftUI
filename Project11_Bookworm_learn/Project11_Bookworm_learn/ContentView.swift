//
//  ContentView.swift
//  Project11_Bookworm_learn
//
//  Created by Ильдар Нигметзянов on 21.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

//struct PushButton: View {
//
//    let title: String
//    @Binding var isOn: Bool
//
//    var onColors = [Color.red,Color.yellow]
//    var offColors = [Color(white: 0.6), Color(white:0.4)]
//
//    var body: some View {
//        Button(title){
//            self.isOn.toggle()
//        }
//        .padding()
//        .background(LinearGradient(gradient:Gradient(colors: isOn ? onColors : offColors),startPoint: .top,endPoint: .bottom))
//        .foregroundColor(.white)
//        .clipShape(Capsule())
//        .shadow(radius: isOn ? 0 : 5)
//    }
//}


struct ContentView: View{
//    @State private var rememberMe = false
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
//        VStack {
//            PushButton(title: "Remember me", isOn: $rememberMe)
//            Text(rememberMe ? "On":"off")
        if sizeClass == .compact {
            return AnyView(VStack{
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle))
        } else {
            return AnyView(HStack{
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle))
        }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
