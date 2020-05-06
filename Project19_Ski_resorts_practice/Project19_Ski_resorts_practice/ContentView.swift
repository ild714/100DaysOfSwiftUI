//
//  ContentView.swift
//  Project19_Ski_resorts_practice
//
//  Created by Ильдар Нигметзянов on 04.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    @ObservedObject var favorities = Favorites()
    @State var resorts: [Resort] = Bundle.main.decode("resorts.json")
    var copyOfResorts : [Resort] = Bundle.main.decode("resorts.json")
    @State private var isSorted = false
    @State private var isFiltered = false
    @State var sizeType = Size.large
    @State var price = Price.oneDollad
    
    var body: some View {
        NavigationView{
            List(resorts) {resort in
                NavigationLink(destination: ResortView(resort: resort)){
                    Image(resort.country)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black,lineWidth: 1))
                    VStack(alignment: .leading){
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }.layoutPriority(1)
                    if self.favorities.contains(resort){
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .sheet(isPresented:$isFiltered,onDismiss: updateUI){
                FilterView(sizeType: self.$sizeType,price: self.$price)
            }
        
            .navigationBarTitle("Resorts")
            .navigationBarItems(leading: Button(action: {
                self.isSorted.toggle()
            }){
                Text("Sort")
                },trailing:Button(action: {
                    self.isFiltered.toggle()
                }){
                    Text("Filter")
            })
                .actionSheet(isPresented: $isSorted){
                    ActionSheet(title: Text("Choose type of sorting"), message: nil, buttons: [.cancel(),.default(Text("Sort by country"), action: sortByCountry),.default(Text("Sort by alphabet"),action: sortByAlphabet),.default(Text("Sort by default"),action: sortByDefault)])
            }
            WelcomeView()
        }
    .environmentObject(favorities)
    .phoneOnlyStackNavigation()
    }
    
    func sortByCountry() {
        self.resorts.sort{
            $0.country < $1.country
        }
    }
    
    func sortByAlphabet(){
        self.resorts.sort{
            $0.name < $1.name
        }
    }
    
    func sortByDefault(){
        self.resorts = self.copyOfResorts
    }
    
    func updateUI(){
        self.resorts = Bundle.main.decode("resorts.json")
        var resortFiltered : [Resort] = [Resort]()
        if sizeType == .small && price == .oneDollad{
            for resort in self.resorts{
                if resort.size == 1 && resort.price == 1{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .small && price == .twoDollars{
            for resort in self.resorts{
                if resort.size == 1 && resort.price == 2{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .small && price == .threeDollars{
            for resort in self.resorts{
                if resort.size == 1 && resort.price == 3{
                    resortFiltered.append(resort)
                }
            }
        }
        else if sizeType == .average && price == .oneDollad{
            for resort in self.resorts{
                if resort.size == 1 && resort.price == 1{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .average && price == .twoDollars{
            for resort in self.resorts{
                if resort.size == 2 && resort.price == 2{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .average && price == .threeDollars{
            for resort in self.resorts{
                if resort.size == 2 && resort.price == 3{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .large && price == .oneDollad{
            for resort in self.resorts{
                if resort.size == 2 && resort.price == 1{
                    resortFiltered.append(resort)
                }
            }
        } else if sizeType == .large && price == .twoDollars{
            for resort in self.resorts{
                if resort.size == 3 && resort.price == 2{
                    resortFiltered.append(resort)
                }
            }
        } else {
            for resort in self.resorts{
                if resort.size == 3 && resort.price == 3{
                    resortFiltered.append(resort)
                }
            }
        }
        self.resorts = resortFiltered
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

extension View {
    func phoneOnlyStackNavigation() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone{
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
