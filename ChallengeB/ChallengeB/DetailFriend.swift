//
//  DetailFriend.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct DetailFriend: View {
    
    var about: String
    
    var body: some View {
        List{
            Section(header:Text("Info")){
                Text(about)
            }
        }
    }
}

