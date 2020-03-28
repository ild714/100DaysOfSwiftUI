//
//  ContentView.swift
//  Challenge5
//
//  Created by Ильдар Нигметзянов on 28.03.2020.
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
                }
            } else{
                print(error?.localizedDescription ?? "No data")
            }
            
        }.resume()
    }
}

struct ContentView: View {
    
    let people = People()
    
    var body: some View {
        NavigationView{
            List(people.people){ person in
                NavigationLink(destination: Detail(people:self.people, aboutInfo: person.about, friends: person.friends, company: person.company,active: person.isActive,adress:person.address,registered:person.registered,tags: person.tags)){
                    VStack(alignment:.leading){
                        Text(person.name)
                            .font(.headline)
                        Text("Age: \(person.age)")
                        //Text("Company: \(person.company)")
                        //Text("Address: \(person.address)")
                        Text("Email: \(person.email)")
                    }
                }
            }
            .navigationBarTitle(Text("Information"))
                   //.font(.largeTitle)
        }
       
    }
    
    func request(url:String){
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
