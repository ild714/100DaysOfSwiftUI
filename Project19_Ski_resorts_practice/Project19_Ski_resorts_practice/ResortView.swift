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
        GeometryReader{geo in
        ScrollView{
            VStack(alignment:.leading,spacing: 0){
                Image(decorative: self.resort.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                    
                Group{
                    HStack{
                        if self.sizeClass == .compact{
                            Spacer()
                            ResortDetailsView(resort: self.resort)
                            SkiDetailsView(resort: self.resort)
                            Spacer()
                        } else {
                            ResortDetailsView(resort: self.resort)
                            Spacer().frame(height:0)
                            SkiDetailsView(resort: self.resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(self.resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    
                    HStack {
                        ForEach(self.resort.facilityTypes) { facility in
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
            Button(self.favorities.contains(self.resort) ? "Remove from Favorities": "Add to Favorites"){
                if self.favorities.contains(self.resort){
                    self.favorities.remove(self.resort)
                }else {
                    self.favorities.add(self.resort)
                }
            }
        }
        .padding()
        }
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
