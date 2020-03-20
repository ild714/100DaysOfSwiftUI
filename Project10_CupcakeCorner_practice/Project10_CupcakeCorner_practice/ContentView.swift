//
//  ContentView.swift
//  Project10_CupcakeCorner_practice
//
//  Created by Ильдар Нигметзянов on 18.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type",selection: $order.order.type){
                        ForEach(0..<Order.types.count){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.order.quantity,in: 3...20){
                        Text("Number of cakes: \(order.order.quantity)")
                    }
                }
                
                Section{
                    Toggle(isOn: $order.order.specialRequestEnable.animation()){
                        Text("Any special requsts?")
                    }
                    
                    if order.order.specialRequestEnable{
                        Toggle(isOn: $order.order.extraFrosting){
                            Text("Add extra frosting")
                        }
                        Toggle(isOn: $order.order.addSprinkles){
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section{
                    NavigationLink(destination:AddressView(order:order)){
                        Text("Delivery details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
