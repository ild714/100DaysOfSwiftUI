//
//  ContentView.swift
//  Project12_CoreDataProject_learn2
//
//  Created by Ильдар Нигметзянов on 26.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack{
            List{
                ForEach(countries,id:\.self){country in
                    Section(header:Text(country.wrappedFullName)){
                        ForEach(country.candyArray,id:\.self){candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add"){
                let candy1 = Candy(context: self.moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: self.moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: self.moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: self.moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: self.moc)
                candy3.name = "Tablerone"
                candy3.origin = Country(context: self.moc)
                candy3.origin?.shortName = "CH"
                candy3.origin?.fullName = "Switzerland"
                
                try? self.moc.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
