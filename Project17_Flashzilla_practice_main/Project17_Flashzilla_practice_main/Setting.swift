//
//  Setting.swift
//  Project17_Flashzilla_practice_main
//
//  Created by Ильдар Нигметзянов on 28.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

struct Setting: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isOn : Bool
    var body: some View {
        NavigationView{
            List {
                Button(action: {
                    self.isOn.toggle()
                }){
                    Text("Turn on array with wrong answer")
                }
                Text("\(String(isOn))")
            }
            .navigationBarItems(leading: Button("Done", action: dismiss))
        }
    }
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

//struct Setting_Previews: PreviewProvider {
//    static var previews: some View {
//        Setting()
//    }
//}
