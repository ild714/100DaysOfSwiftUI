//
//  ContentView.swift
//  Project6_Animation_learn
//
//  Created by Ильдар Нигметзянов on 29.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    //@State private var animationAmount: CGFloat = 1
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        
//        Button("Tap me"){
//            self.animationAmount += 1
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//    .overlay(
//        Circle()
//            .stroke(Color.red)
//        .scaleEffect(animationAmount)
//        .opacity(Double(2-animationAmount))
//        .animation(Animation.easeInOut(duration: 1)
//        .repeatForever(autoreverses: false)))
//            .onAppear(){
//                self.animationAmount = 2
//        }
        //.scaleEffect(animationAmount)
        //.blur(radius: ((animationAmount - 1 ) * 3))
        //.animation(.interpolatingSpring(stiffness: 60, damping: 0.5))
        //.animation(.easeInOut(duration:2))
        //.animation(Animation.easeInOut(duration: 2).delay(1))
        //.animation(Animation.easeInOut(duration: 2).repeatCount(2,autoreverses: true))
//            .animation(Animation.easeInOut(duration: 1)
//                .repeatForever(autoreverses: true))
    
//        print(animationAmount)
//        return VStack{
//            Stepper("Scale amount",value: $animationAmount.animation(
//                Animation.easeInOut(duration: 1)
//                .repeatCount(3,autoreverses: true)),in:1...10)
//            Spacer()
//
//            Button("Tap me"){
//                self.animationAmount += 1
//            }
//
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//
//        }
        
       
            Button("Tap me"){
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
            }
            
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
        
            .rotation3DEffect(.degrees(animationAmount), axis: (x:0, y:1, z: 1))
       
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
