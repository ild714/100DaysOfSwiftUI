//
//  ProspectsView.swift
//  Project16_HotProspects_practice
//
//  Created by Ильдар Нигметзянов on 19.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
//    enum sortType {
//        case sortByName, SortByData
//    }
    
    enum FilterType{
        case none, contancted, uncontacted
    }
    
    @State private var showingSheet = false
    @State private var isShowingScanner = false
    @EnvironmentObject var prospects: Prospects
    @State private var sortByName = false
//    var prospectSort: Prospects
    
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
    
    @State var filteredProspects2 = [Prospect]()
    @State var filteredProspects3 = [Prospect]()
    
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
            if sortByName == true {
                List{
                                ForEach(filteredProspects2) { prospect in
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text(prospect.name)
                                                .font(.headline)
                                            Text(prospect.emailAddress)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                //                        if prospect.iscontacted == true {
                                        Image(systemName: prospect.isContacted ? "checkmark.circle" : "questionmark.diamond")
                //                        }
                                    }
                                    .contextMenu {
                                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                                            self.prospects.toggle(prospect)
                                        }
                                        
                                        if !prospect.isContacted{
                                            Button("Remind Me"){
                                                self.addNotification(for: prospect)
                                            }
                                        }
                                    }
                                }
                            }
                            .navigationBarTitle(title)
                            .navigationBarItems(leading:Button(action: {
                                self.showingSheet = true
                            }){
                                Text("Sort")
                                },trailing: Button(action:{
                                    self.isShowingScanner = true
                                }){
                                    Image(systemName: "qrcode.viewfinder")
                                    Text("Scan")
                                })
                                .actionSheet(isPresented: $showingSheet){
                                    ActionSheet(title: Text("What do you want to do?"), buttons: [.cancel(),.default(Text("Sort by name"), action: sort),.default(Text("Sort by date"), action: sort2)])
                                }
                                .sheet(isPresented: $isShowingScanner){
                                    CodeScannerView(codeTypes:[.qr],simulatedData: "Aaul Hudson\npaul@hackingwithswift.com",completion: self.handleScan)
                            }
            }else {
            List{
                ForEach(filteredProspects) { prospect in
                    HStack{
                        VStack(alignment: .leading){
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
//                        if prospect.iscontacted == true {
                        Image(systemName: prospect.isContacted ? "checkmark.circle" : "questionmark.diamond")
//                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted" ) {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted{
                            Button("Remind Me"){
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading:Button(action: {
                self.showingSheet = true
            }){
                Text("Sort")
                },trailing: Button(action:{
                    self.isShowingScanner = true
                }){
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                })
                .actionSheet(isPresented: $showingSheet){
                    ActionSheet(title: Text("What do you want to do?"), buttons: [.cancel(),.default(Text("Sort by name"), action: sort),.default(Text("Sort by date"), action: sort2)])
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes:[.qr],simulatedData: "Aaul Hudson\npaul@hackingwithswift.com",completion: self.handleScan)
            }
            }
        }
    }
    
    func sort(){
        if sortByName == false {
            self.filteredProspects2 = Array(prospects.people).sorted()
            sortByName = true
        }
    }
    
    func sort2(){
        self.filteredProspects2 = prospects.people
        sortByName = false
    }
    
    func handleScan(result: Result<String,CodeScannerView.ScanError>){
        self.isShowingScanner = false
        
        switch result {
        case .success(let code):
            if sortByName == true {
                sortByName = false
            }
            
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else {return}
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            self.prospects.add(person)
            case .failure(let error):
            print("Scanning failed")
            
        }
    }
    
    func addNotification(for prospect: Prospect){
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized{
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}
//
//struct ProspectsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProspectsView(filter: .none)
//    }
//}
