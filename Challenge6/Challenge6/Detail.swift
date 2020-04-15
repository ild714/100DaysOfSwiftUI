//
//  Detail.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Detail: View {
    
    var id: Int
    @ObservedObject var persons: Persons
    
    init(persons:Persons,id:Int){
        self.id = id
        self.persons = persons
    }
    
    var body: some View {
        Form{
            Section(header: Text("Name")){
                TextField("Fill name",text:$persons.persons[id].name)
            }
            Section(header: Text("Birthday")){
                TextField("Fill birthday date",text:$persons.persons[id].birthday)
            }
        }
    }
}

//struct Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Detail()
//    }
//}
