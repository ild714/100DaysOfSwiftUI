//
//  ContentView.swift
//  ChallengeB
//
//  Created by Ильдар Нигметзянов on 29.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class People {
    var people = [Person]()
    
    init(){
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        URLSession.shared.dataTask(with: url){data,response,error in
            if let data = data  {
                let json = JSONDecoder()
        
                if let dates = try? json.decode([Person].self,from: data){
                    self.people = dates
                    UserDefaults.standard.set(true, forKey: "Check")
                }
            } else{
                print(error?.localizedDescription ?? "No data")
            }
        }.resume()
    }
}


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: PersonData.entity(), sortDescriptors: []) var peopleMain : FetchedResults<PersonData>
    
    var people : People
    
    init(){
        people = People()
        do{
            sleep(1)
        }
    }
    
    var body: some View {
        NavigationView{
            List(peopleMain,id:\.self){ person in
                //createPerson(person: person)
                NavigationLink(destination:Detail(isActive: person.isActive,age:person.age,company: person.wrappedCompany,address:person.wrappedAddress ,about:person.wrappedAbout,registered:person.wrappedRegistered,tags:person.tagArray,friends:person.friendArray,people:self.people)){
                    VStack(alignment:.leading){
                        Text(person.wrappedName)
                            .font(.headline)
                        Text(person.wrappedEmail)
//                        ForEach(person.tagArray,id:\.self){tag in
//                            Text(tag.wrappedName)
//                        }
                    }
                }
            }
            .navigationBarTitle(Text("Information"))
//                if UserDefaults.standard.bool(forKey: "Check"){
                .onAppear(perform: update)
//                }
        }
    }
    
    func update(){
        if UserDefaults.standard.bool(forKey: "Check"){
            
        for person in self.people.people{
            let personData = PersonData(context: self.moc)
            personData.about = person.about
            personData.name = person.name
            personData.isActive = person.isActive
            personData.age = person.age
            personData.company = person.company
            personData.email = person.email
            personData.registered = person.registered
            personData.address = person.address
            personData.id = person.id
            
            for tag in person.tags{
                let tagData = Tag(context: self.moc)
                tagData.name = tag
                tagData.person = personData
                try? self.moc.save()
            }
            
            for friend in person.friends{
                let friendData = FriendData(context: self.moc)
                friendData.name = friend.name
                friendData.id = friend.id
                friendData.person = personData
                try? self.moc.save()
            }
            
            do {
                try self.moc.save()
            } catch {
                print(error)
            }}
            UserDefaults.standard.set(false, forKey: "Check")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
