//
//  ContentView.swift
//  Project4_BetterSleep_Practice
//
//  Created by Ильдар Нигметзянов on 24.02.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var hidden = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var buttonTime = "Tap button for showing time"
    
    @State private var selected = 0
    var coffee = ["1","2","3","4","5"]
    
    var body: some View {
        NavigationView{
            Form{
                
                Section {
                    Text(buttonTime)
                        .font(.custom("",size: 15))
                }
                
                Section{
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("Please enter a time",selection:$wakeUp,displayedComponents:.hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section{
                    Text("Desired amount of sleep")
                        .font(.headline)
                    
                    Stepper(value: $sleepAmount,in: 4...12,step: 0.25){
                        Text("\(sleepAmount,specifier:"%g")hours")
                    }
                }
                
                Section{
                    Text("Daily coffee intake")
                        .font(.headline)
                    
//                    Stepper(value: $coffeeAmount, in: 1...20){
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount) cups")
//                        }
//                    }
                    Picker(selection: $selected,label:Text("test")) {
                        ForEach(0 ..< coffee.count){
                            Text(self.coffee[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            
    
            .navigationBarItems(trailing:
                Button(action: {
                    self.calculateBedtime()
                    
                }){
                   Text("Calculate")
                }
                   )
                .navigationBarHidden(hidden)
                .alert(isPresented:$showingAlert){
                    Alert(title:Text(alertTitle),message: Text(alertMessage),dismissButton: .default(Text("OK")))
            }
        }
    
        
    }
    
    func calculateBedtime(){
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour,.minute],from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute),estimatedSleep: sleepAmount, coffee: Double(selected+1))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry,there was a problem calculating your bedtime."
        }
        
        hidden = true
        buttonTime = "Your ideal time is \(alertMessage)"
        //showingAlert = true
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
