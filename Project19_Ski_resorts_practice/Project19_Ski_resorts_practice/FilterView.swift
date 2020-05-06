//
//  FilterView.swift
//  Project19_Ski_resorts_practice
//
//  Created by Ильдар Нигметзянов on 06.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI

enum Size:String,CaseIterable{
       case large
       case average
       case small
   }

enum Price: String,CaseIterable{
    case oneDollad
    case twoDollars
    case threeDollars
}

struct FilterView: View {
    
    @Binding var sizeType: Size
    @Binding var price: Price
    
    var body: some View {
        Form{
            VStack{
                Section(header:Text("Choose the size")){
                    Picker("Type",selection:$sizeType){
                        ForEach(Size.allCases,id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header:Text("Choose prize")){
                    Picker("Price",selection:$price){
                        ForEach(Price.allCases,id: \.self){
                            Text($0.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
        }
    }
}

//struct FilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilterView()
//    }
//}
