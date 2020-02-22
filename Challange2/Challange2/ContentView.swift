//
//  ContentView.swift
//  Challange2
//
//  Created by Ильдар Нигметзянов on 22.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    private var objects = ["rock","paper","scissors"]
    
    @State private var current = 0
    @State private var checkWin = false
    @State private var random = Int.random(in: 0...2)
    
    @State private var score = 0
    
    var body: some View {
        VStack(spacing:10) {
            Text("Your score :\(score)")
            Text(objects[random])
            Text(checkWin ? "win" : "lose")
            
            Button(action: {
                if self.checkWin == false && self.random == 0 {
                    self.score+=0
                }
                else if self.checkWin == false && self.random == 1 {
                    self.score-=1
                }
                else if self.checkWin == false && self.random == 2 {
                    self.score-=1
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score+=0
                }
                else if self.checkWin == true && self.random == 1 {
                    self.score+=1
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score+=1
                }
                self.rand()
            }
            ){
               Text("rock")
            }
            Button(action: {
                if self.checkWin == false && self.random == 0 {
                    self.score+=1
                }
                else if self.checkWin == false && self.random == 1 {
                    self.score-=0
                }
                else if self.checkWin == false && self.random == 2 {
                    self.score+=1
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score-=1
                }
                else if self.checkWin == true && self.random == 1 {
                    self.score-=0
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score-=1
                }
                self.rand()
            }
            ){
               Text("paper")
            }
            Button(action: {
                if self.checkWin == false && self.random == 0 {
                    self.score+=1
                }
                else if self.checkWin == false && self.random == 1 {
                    self.score+=1
                }
                else if self.checkWin == false && self.random == 2 {
                    self.score+=0
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score-=1
                }
                else if self.checkWin == true && self.random == 1 {
                    self.score-=1
                }
                else if self.checkWin == true && self.random == 0 {
                    self.score-=0
                }
                self.rand()
            }
            ){
               Text("scissors")
            }
        }
    }
    func rand() {
        random = Int.random(in: 0...2)
        checkWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
