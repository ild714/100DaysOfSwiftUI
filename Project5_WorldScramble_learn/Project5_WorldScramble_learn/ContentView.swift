 //
//  ContentView.swift
//  Project5_WorldScramble_learn
//
//  Created by Ильдар Нигметзянов on 26.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn","Liza","Liza"]
    
    var body: some View {
//        List {
//            Section(header:Text("Section 1")){
//                Text("Static")
//            }
//            Section(header:Text("Section 2")){
//                ForEach(0..<5) {
//                    Text("Dynamic row \($0)")
//                }
//            }
//            Section(header:Text("Section 3")){
//                Text("Static")
//            }
//
//        }
//        .listStyle(GroupedListStyle())
        
//        List(0..<5){
//            Text("Dynamic \($0)")
//        }
        
//        List(people, id:\.self){
//            Text($0)
//        }
        
//        let input = "a b c"
//        let letters = input.components(separatedBy: " ")
//        let letter = letters.randomElement()
//        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let word = "swift"
//        let checker = UITextChecker()
//
//        let range = NSRange(location: 0, length: word.utf16.count)
//
//        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
//
//        let allGood = misspelledRange.location == NSNotFound
//
//        if let fileURL = Bundle.main.url(forResource:"some-file",withExtension: "txt") {
//            if let fileContents = try? String(contentsOf: fileURL){
//
//            }
//        }
        Text("test")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
