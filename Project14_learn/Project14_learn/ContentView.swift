//
//  ContentView.swift
//  Project14_learn
//
//  Created by Ильдар Нигметзянов on 05.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
//        MapView()
//            .edgesIgnoringSafeArea(.all)
        VStack{
            if self.isUnlocked{
                Text("Unlocked")
            }else {
                Text("Locked")
            }
        }
    .onAppear(perform: authenticate)
    }
    
    func authenticate(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                DispatchQueue.main.async {
                    if success{
                        self.isUnlocked = true
                    }else {
                        
                    }
                }
            }
        } else {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
