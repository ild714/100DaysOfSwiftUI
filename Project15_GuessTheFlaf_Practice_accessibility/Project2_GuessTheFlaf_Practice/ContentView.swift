//
//  ContentView.swift
//  Project2_GuessTheFlaf_Practice
//
//  Created by Ильдар Нигметзянов on 18.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

enum ActiveAlert {
    case first, second
}

//struct Image:ViewModifier {
//
//    func body(content:Content) -> some View {
//        content
//        .renderingMode(.original)
//        .clipShape(Capsule())
//        .overlay(Capsule().stroke(Color.black,lineWidth: 1))
//        .shadow(color:.black,radius:2)
//    }
//}



struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var showMistake = false
    @State private var score = 0
    @State private var current = 0
    
    @State private var activeAlert: ActiveAlert = .first
    
    let labels = [
        "Estonia":"Flag with three horizontal stripes of equal size. Top stripe blue,middle stripe black,bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green,middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green. middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with trhee horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK:": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack{
            LinearGradient(gradient:Gradient(colors: [.blue,.black]),startPoint: .top,endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing:30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){number
                    in Button(action:{
                        if number == self.correctAnswer{
                        withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                                           self.animationAmount += 360
                                      }
                        }
                        self.current = number
                        self.flagTapped(number)
                        
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color:.black,radius:2)
                            .accessibility(label:Text(self.labels[self.countries[number],default: "Unknown flag"]))
                             
                    }
                  
                    
                   // .rotation3DEffect(.degrees(self.animationAmount), axis: (x:0, y:1, z: 1))
                    
                }
                 
                Text("Your score:\(score)").foregroundColor(.white)
                Spacer()
            }
        }
        
        .alert(isPresented: $showingScore){
            switch activeAlert {
            case .first:
                return Alert(title:Text(scoreTitle),message:Text("Your score is \(score)"),dismissButton: .default(Text("Continue")){
                    self.askQuestion()
                    })
            case .second:
                return  Alert(title: Text("Wrong!"), message: Text("That's the flag of \(countries[current])"), dismissButton: .default(Text("Continue")){
                    self.askQuestinonAfterMistake()
                    })
            }
        }
        
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score+=1
            self.activeAlert = .first
            
            
        } else {
            //scoreTitle = "Wrong"
            score-=1
            self.activeAlert = .second
        }
        showingScore = true
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in:0...2)
    }
    
    func askQuestinonAfterMistake(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
