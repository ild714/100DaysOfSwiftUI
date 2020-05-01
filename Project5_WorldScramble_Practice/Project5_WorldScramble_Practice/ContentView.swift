//
//  ContentView.swift
//  Project5_WorldScramble_Practice
//
//  Created by Ильдар Нигметзянов on 27.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var sumLetters = 0
    let colors: [Color] = [.red,.green,.gray,.orange,.pink,.yellow,.purple]
    var body: some View {
        NavigationView{
            VStack {
                TextField("Enter your word",text: $newWord,onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                Text("Amount of words: \(usedWords.count), amount of letters: \(sumLetters)")
                
                List(usedWords,id:\.self){ word in
                 
                        Image(systemName:"\(word.count).circle")
                            . background(Color.red)
                        Text(word)
                            .alignmentGuide(.leading){
                                _ in CGFloat(word.count) * -10
                        }
                }
            }
            .navigationBarItems(leading: Button("Restart"){
                self.startGame()
            })
        .navigationBarTitle(rootWord)
        .onAppear(perform: startGame)
            .alert(isPresented:$showingError){
                Alert(title: Text(errorTitle),message: Text(errorMessage),dismissButton: .default(Text("Ok")))
            }
        }
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word:answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title:"Word not possible",message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(answer,at:0)
        self.sumLetters+=answer.count
        newWord = ""
    }
    
    func startGame() {
        usedWords.removeAll()
        sumLetters = 0
        if let startWordsURL = Bundle.main.url(forResource:"start",withExtension: "txt"){
            if let startWords = try? String(contentsOf:startWordsURL){
                let allWords = startWords.components(separatedBy:"\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
    fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0,length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound && word.count > 3 && word != rootWord
    }
    
    func wordError(title: String,message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
