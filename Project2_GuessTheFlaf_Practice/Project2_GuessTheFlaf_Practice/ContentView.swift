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
    
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var showMistake = false
    @State private var score = 0
    @State private var current = 0
    
    @State private var activeAlert: ActiveAlert = .first
    
    
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
                        self.current = number
                        self.flagTapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color:.black,radius:2)
                    }
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
