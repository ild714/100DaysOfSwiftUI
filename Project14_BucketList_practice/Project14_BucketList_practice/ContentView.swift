//
//  ContentView.swift
//  Project14_BucketList_practice
//
//  Created by Ильдар Нигметзянов on 07.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

enum ActiveAlert {
    case first,second
}

struct MapView1: View{
//    @State private var centerCoordinate = CLLocationCoordinate2D()
//    @State private var locations = [CodableMKPointAnnotation]()
    
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    
    @Binding var centerCoordinate : CLLocationCoordinate2D
    @Binding var locations : [CodableMKPointAnnotation]
    
    var body: some View{
        MapView(centerCoordinate: $centerCoordinate,annotations: locations,selectedPlace: $selectedPlace,showingPlaceDetails: $showingPlaceDetails)
            .edgesIgnoringSafeArea(.all)
    }
}

struct Circle1: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .opacity(0.3)
            .frame(width: 32, height: 32)
    }
}

struct Button1: View {
    
    @Binding var isUnlocked: Bool
    @Binding var activeaAlert: ActiveAlert
    @Binding var showingPlaceDetails: Bool
    
    var body: some View {
        
        Button("Unlock Places"){
            self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?

        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: &error){
            let reason = "Please authenticate yourself to unlock your places"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason){ success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
//                        self.activeaAlert = .second
//                        self.showingPlaceDetails = true
                    }
                }
            }
        } else {
        }
    }
}

struct ContentView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()

    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @State private var isUnlocked = false
    @State private var showingEditScreen = false
    
    @State var activeAlert : ActiveAlert = .first
    
//    @State private var bind : Bool = false
//    @State private var selectedPlace: MKPointAnnotation?
    
    var body: some View {
        ZStack{
            if isUnlocked{
//                MapView(centerCoordinate: $centerCoordinate,annotations: locations,selectedPlace: $selectedPlace,showingPlaceDetails: $showingPlaceDetails)
//                    .edgesIgnoringSafeArea(.all)
                MapView1(selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, centerCoordinate: $centerCoordinate, locations: $locations)
                Circle1()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            self.selectedPlace = newLocation
                            self.activeAlert = .first
                            self.showingEditScreen = true
                        }){
                            Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                        }
                        
                    }
                }
            } else {
                Button1(isUnlocked:$isUnlocked,activeaAlert: $activeAlert,showingPlaceDetails: $showingPlaceDetails)
            }
            
        }
        .alert(isPresented: $showingPlaceDetails){
            switch activeAlert {
            case .first:
            return Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing place information"), primaryButton: .default(Text("Ok")), secondaryButton: .default(Text("Edit")){
                self.showingEditScreen = true
                })
            case .second:
                return
                 Alert(title: Text("Error"), message: Text("Turn on authentification"), dismissButton: .cancel())
            }
        }
        .sheet(isPresented:$showingEditScreen,onDismiss: saveData){
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
