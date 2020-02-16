//
//  ContentView.swift
//  Challenge1
//
//  Created by Ильдар Нигметзянов on 15.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var temperature = ""
    @State private var currentUnit = 0
    @State private var resultUnit = 0
    
    var converted: Double {
        let temperatureDouble = Double(temperature) ?? 0
        
        if currentUnit == 0 && resultUnit == 0{
            return temperatureDouble
        } else if currentUnit == 0 && resultUnit == 1 {
            return temperatureDouble * (9/5) + 32
        } else if currentUnit == 0 && resultUnit == 2 {
            return temperatureDouble + 273.15
        } else if currentUnit == 1 && resultUnit == 0 {
            return (temperatureDouble - 32) * 5/9
        } else if currentUnit == 1 && resultUnit == 1 {
            return temperatureDouble
        } else if currentUnit == 1 && resultUnit == 2 {
            return (temperatureDouble - 32) * 5/9
        } else if currentUnit == 2 && resultUnit == 0 {
            return (temperatureDouble-273.15)
        } else if currentUnit == 2 && resultUnit == 1 {
            return (temperatureDouble - 273.15) * 9/5 + 32
        } else if currentUnit == 2 && resultUnit == 2 {
            return temperatureDouble
        }
        
        
        return 21.2
    }
    
    var input = ["Celsius","Fahrenheit","Kelvin"]
    var output = ["Celsius","Fahrenheit","Kelvin"]
    
    var body: some View {
        Form {
            Section{
                
                TextField("Enter input temperature", text: $temperature)
                
            }
            Section{
                Picker("Current unit", selection: $currentUnit) {
                    ForEach(0..<input.count){
                        Text(self.input[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            
            }
            
            Section{
                Picker("resultUnit",selection: $resultUnit){
                    ForEach(0..<output.count){
                        Text(self.output[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section{
                Text("Converted: \(converted,specifier: "%.2f")")
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
