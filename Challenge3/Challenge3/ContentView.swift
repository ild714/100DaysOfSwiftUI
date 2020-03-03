//
//  ContentView.swift
//  Challenge3
//
//  Created by Ильдар Нигметзянов on 03.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @State private var level = 0
    @State private var questions = ["5","10","20","all"]
    @State private var selected = 0
    @State private var showQuestion = false
    @State private var answer = ""
    @State private var counter = 0
    @State private var score = 0
    @State private var res = 0
    @State private var random1 = 0
    @State private var random2 = 0
    
    var body: some View {
        NavigationView{
            Form {
                if !showQuestion {
                    
                    Section(header:Text("Choose your level") .font(.headline)){
                        Stepper(value: $level, in: 0...12,step: 1){
                            Text("\(level)")
                        }
                    }
                    
                    Section(header:Text("Choose amount of questions")){
                        Picker("Amount",selection: $selected) {
                            ForEach(0..<questions.count){
                                Text("\(self.questions[$0])")
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
                if showQuestion {
                    
                   
                    Section(header: Text("Question type:\(Int(selected)+1)")){
                        Text("\(random1) x \(random2) = ?")
                    }
                    Section{
                        TextField("Answer",text:$answer)
                            .keyboardType(.decimalPad)
                    }
                    
                    Button("Check result"){
                        if self.selected == 0 {
                            self.counter += 1
                            if self.counter == 5 {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.showQuestion = false
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }else {
                                    self.showQuestion = false
                                    self.random()
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }
                            } else {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.random()
                                    self.answer = ""
                                }else {
                                    self.random()
                                    self.answer = ""
                                }
                            }
                        } else if self.selected == 1 {
                            self.counter += 1
                            if self.counter == 10 {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.showQuestion = false
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }else {
                                    self.showQuestion = false
                                    self.random()
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }
                            } else {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.random()
                                    self.answer = ""
                                }else {
                                    self.random()
                                    self.answer = ""
                                }
                            }
                        } else if self.selected == 2 {
                            self.counter += 1
                            if self.counter == 20 {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.showQuestion = false
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }else {
                                    self.showQuestion = false
                                    self.random()
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }
                            } else {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.random()
                                    self.answer = ""
                                }else {
                                    self.random()
                                    self.answer = ""
                                }
                            }
                        } else if self.selected == 3 {
                            self.counter += 1
                            if self.counter == 5 {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.showQuestion = false
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }else {
                                    self.showQuestion = false
                                    self.random()
                                    self.score = 0
                                    self.answer = ""
                                    self.counter = 0
                                }
                            } else {
                                if Int(self.answer) == (self.random1 * self.random2) {
                                    self.score += 1
                                    self.random()
                                    self.answer = ""
                                }else {
                                    self.random()
                                    self.answer = ""
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarItems(trailing: Button("Start game"){
                self.startGame()
                self.random()
            })
            
           
            
            .navigationBarTitle("Your score: \(score)")
        
        }
    }
    
    func startGame() {
        showQuestion = true
        
    }
    
    func random() {
        self.random1 = Int.random(in: 0...level)
        self.random2 = Int.random(in: 0...level)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
