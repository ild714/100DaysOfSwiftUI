//
//  Card.swift
//  Project17_Flashzilla_practice_main
//
//  Created by Ильдар Нигметзянов on 26.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
