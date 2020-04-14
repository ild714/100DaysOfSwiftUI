//
//  Detail.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Detail: View {
    var person : Person
    
    init(person:Person){
        self.person = person
    }
    
    var body: some View {
        VStack{
            Text(person.name)
            Text(person.birthday)
        }
    }
}

//struct Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Detail()
//    }
//}
