//
//  DetailFriend.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 28.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct DetailFriend: View {
    
    let name: String
    let age : Int
    let company: String
    let about: String
    
    var body: some View {
        
        VStack{
            List{
                Section(header: Text("Name")) {
                    Text(name)
                }
                Section(header: Text("age")) {
                    Text(String(age))
                }
                Section(header: Text("company")) {
                    Text(company)
                }
                Section(header: Text("Detail info")) {
                    Text(about)
                }
            }
            .font(.headline)
        }
    }
}

