//
//  ResortView.swift
//  Project19_Ski_resorts_practice
//
//  Created by Ильдар Нигметзянов on 04.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @EnvironmentObject var favorities: Favorites
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var selectedFacility: Facility?
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing: 0){
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                Group{
                    HStack{
                        if sizeClass == .compact{
                            Spacer()
                            ResortDetailsView(resort: resort)
                            SkiDetailsView(resort: resort)
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height:0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            Button(favorities.contains(resort) ? "Remove from Favorities": "Add to Favorites"){
                if self.favorities.contains(self.resort){
                    self.favorities.remove(self.resort)
                }else {
                    self.favorities.add(self.resort)
                }
            }
        }
        .padding()
        .alert(item: $selectedFacility){facility in
            facility.alert
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"),displayMode: .inline)
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
