//
//  ProspectsView.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct ProspectsView: View {
    enum FilterType{
        case none, contancted, uncontacted
    }
    
    @EnvironmentObject var prospects: Prospects
    let filter: FilterType
    var title: String{
        switch filter {
        case .none:
            return "Everyone"
        case .contancted:
            return "Contancted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect]{
        switch filter {
        case .none:
            return prospects.people
        case .contancted:
            return prospects.people.filter {
                $0.isContacted
            }
        case .uncontacted:
            return prospects.people.filter {
                !$0.isContacted
            }
        }
    }
    
    var body: some View {
        NavigationView{
            
            List{
                ForEach(filteredProspects) { prospects in
                    VStack(alignment: .leading){
                        Text(prospects.name)
                            .font(.headline)
                        Text(prospects.emailAddress)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationBarTitle(title)
                .navigationBarItems(trailing: Button(action:{
                    let prospect = Prospect()
                    prospect.name = "Paul Hudson"
                    prospect.emailAddress = "paul@hackingwithswift.com"
                    self.prospects.people.append(prospect)
                }){
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
