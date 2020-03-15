//
//  Habit.swift
//  Challenge4
//
//  Created by Ильдар Нигметзянов on 15.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation

struct Habit:Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let time: Int
}
