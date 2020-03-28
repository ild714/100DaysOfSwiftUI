//
//  Detail.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 28.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Detail: View {
    
    let people : People
    
    let aboutInfo: String
    let friends: [Friend]
    let company: String
    let active: Bool
    let adress: String
    let registered: String
    let tags: [String]
    
    var body: some View {
        
            VStack(alignment:.leading){
                List{
                    Section(header:Text("Detail info")){
                        Text(aboutInfo)
                    }
                    
                    Section(header:Text("Active")){
                        Text(String(active))
                    }
                    
                    Section(header:Text("Address")){
                        Text(adress)
                    }
                    
                    Section(header:Text("Redistered")){
                        Text(registered)
                    }
                    
                    Section(header:Text("Company")){
                        Text(company)
                    }
                    
                    Section(header: Text("Friends:")){
                        ForEach(friends){ friend in
                            ForEach(self.people.people){ person in
                                if friend.id == person.id{
                                    NavigationLink(destination:DetailFriend(name:person.name,age:person.age,company: person.company,about: person.about)){
                                        Text(friend.name)
                                    }
                                }
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Tags")){
                        ForEach(tags,id: \.self){tag in
                            Text(tag)
                        }
                    }
                }
                .font(.headline)
            }
        
    }
}

//struct Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Detail(aboutInfo: "Test")
//    }
//}
