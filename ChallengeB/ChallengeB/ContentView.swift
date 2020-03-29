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
                //print(data)
                if let dates = try? json.decode([Person].self,from: data){
                    self.people = dates
                    
//                    for person in self.people {
//                        let person1 = PersonData(context: self.moc)
//                        person1.name = person.name
//                            try? self.moc.save()
//                    }
                }
            } else{
                print(error?.localizedDescription ?? "No data")
            }
            
        }.resume()
    }
    
    func update() {
//        for person in people{
//        let person1 = PersonData(context: moc)
//        person1.name = person.name
//        do {
//            try moc.save()
//        } catch {
//            print(error)
//        }}
    }
}


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: PersonData.entity(), sortDescriptors: []) var peopleMain : FetchedResults<PersonData>
    
    var people : People
    
    init(){
        //self.save()
        people = People()
//        do{
//            sleep(3)
//        }
//        for person in self.people.people{
//        let person1 = PersonData(context: self.moc)
//        person1.name = person.name
//        do {
//            try self.moc.save()
//        } catch {
//            print(error)
//        }}
        
//        for person in people.people {
//            let person1 = PersonData(context: self.moc)
//            //person1.id = person.id
//            //person1.isActive = person.isActive
//            person1.name = person.name
//            //person1.age = person.age
//            //person1.company = person.company
//            person1.email = person.email
//            person1.address = person.address
//            person1.about = person.about
//            person1.registered = person.registered
//            do{
//            try self.moc.save()
//            } catch {
//                print(error)
//            }
//        }
    }
    
    
    var body: some View {
        NavigationView{
            List(peopleMain,id:\.self){ person in
                //createPerson(person: person)
                //NavigationLink(destination: Detail(aboutInfo: person.about ?? "No", company: person.company ?? "No",active: person.isActive,adress:person.address ?? "No",registered:person.registered ?? "No")){
                VStack(alignment:.leading){
                    Text(person.wrappedName)
                    
                        
                    
                    //                            .font(.headline)
                    //Text("Age: \(person.age)")
                    //Text("Email: \(person.email ?? "no")")
                }
                
                //}
                //            }
                //            .navigationBarTitle(Text("Information"))
            }
            .navigationBarItems(leading: Button(action: {
                for person in self.people.people{
                    let person1 = PersonData(context: self.moc)
                       person1.name = person.name
                       do {
                        try self.moc.save()
                       } catch {
                           print(error)
                       }}
            }){
                Text("Update")
            })
        }
    }
    
//    func save(){
//        let people = People()
//        do{
//            sleep(5)
//        }
//        //for person in people.people {
//            let person1 = PersonData(context: moc)
//            person1.name = "test"
//            do {
//            try self.moc.save()
//            } catch {
//                print(error)
//            }
//        //}
//    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
