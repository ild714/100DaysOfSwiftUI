//
//  Detail.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct Detail: View {
    
    @FetchRequest(entity: PersonData.entity(), sortDescriptors: []) var peopleMain : FetchedResults<PersonData>
    
    let isActive: Bool
    let age: Int16
    let company: String
    let address: String
    let about: String
    let registered: String
    let tags : [Tag]
    let friends: [FriendData]
    let people : People
    
    var body: some View {
            List{
                Section(header: Text("Detail info")) {
                    Text(about)
                }
                Section(header: Text("Age")) {
                    Text(String(age))
                }
                Section(header: Text("Active")) {
                    Text(String(isActive))
                }
                Section(header: Text("address")) {
                    Text(address)
                }
                Section(header: Text("Registered")) {
                    Text(registered)
                }
                
                
                Section(header:Text("Friends")){
                    ForEach(friends,id:\.self){friend in
                        ForEach(self.people.people){ person1 in
                            if (friend.wrappedId == person1.id)  {
                                NavigationLink(destination:DetailFriend(about: person1.about)){
                                    Text(friend.wrappedName)
                                }
                            }
                        }
                    }
                }
                
                Section(header:Text("Tags")){
                    ForEach(tags,id:\.self){tag in
                        Text(tag.wrappedName)
                    }
                }
            }
    }
}


