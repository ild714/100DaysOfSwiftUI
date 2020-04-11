//
//  ContentView.swift
//  Project15_learn
//
//  Created by Ильдар Нигметзянов on 11.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
//    let pictures = [
//    "alex-krivec-15949",
//    "galina-n-189483",
//    "kevin-horstmann-141705",
//    "nicolas-tissot-335096"
//    ]
//
//    let labels = [
//        "Tulips",
//        "Frozen tree buds",
//        "Sunflowers",
//        "Fireworks"
//    ]
//
//    @State private var selectedPicture = Int.random(in:0...3)
    
    @State private var rating = 3
    var body: some View {
//        Image(pictures[selectedPicture])
//            .resizable()
//            .scaledToFit()
//            .accessibility(label:Text(labels[selectedPicture]))
//            .accessibility(addTraits: .isButton)
//            .onTapGesture {
//                self.selectedPicture = Int.random(in: 0...3)
//        }
//        Image(decorative:"character")
//        .accessibility(hidden: true)
        
//        VStack{
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }.accessibilityElement(children: .ignore)
//        .accessibility(label: Text("Your score is 1000"))
        
        Stepper("Rate our service: \(rating)/5",value:$rating,in:1...5)
            .accessibility(value:Text("\(rating) out of 5"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
