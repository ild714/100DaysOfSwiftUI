//
//  ContentView.swift
//  Project17_Flashzilla_practice
//
//  Created by Ильдар Нигметзянов on 25.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    
//    @State private var currentAmount: Angle = .degrees(0)
//    @State private var finalAmount: Angle = .degrees(0)
    
    @State private var engine: CHHapticEngine?
    
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//    @State private var offset = CGSize.zero
//    @State private var isDragging = false
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? Color.black:  Color.black.opacity(0.5))
            .foregroundColor(Color.white)
            .clipShape(Capsule())
        //        .scaleEffect(scale)
//            .onTapGesture {
//                if self.reduceMotion{
//                    self.scale *= 1.5
//                } else {
//                    withAnimation{
//                        self.scale *= 1.5
//                    }
//                }
        
        //}
//        HStack{
//            if differentiateWithoutColor{
//                Image(systemName: "checkmark.circle")
//            }
//            Text("Success")
//        }
//    .padding()
//        .background(differentiateWithoutColor ? Color.black : Color.green)
//        .foregroundColor(Color.white)
//    .clipShape(Capsule())
        
//        Text("Hello, World")
//            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)){
//                _ in
//                print("Moving to the background")
//        }
        
//        ZStack{
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture{
//                    print("Rectangle tapped!")
//            }
//
//            Circle()
//                .fill(Color.red)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Circle tapped")
//            }
//        }
        
//        Text("Hello,World!")
//            .onAppear(perform: prepareHaptics)
//            .onTapGesture(perform: complesSuccess)
        
//        Text("Hello, World!")
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(RotationGesture()
//                .onChanged{
//                    angle in
//                    self.currentAmount = angle
//                    print(self.currentAmount)
//            }
//            .onEnded{
//                angle in
//                self.finalAmount += self.currentAmount
//                self.currentAmount = .degrees(0)
//                }
//        )
        
//        VStack{
//            Text("Hello, World!")
//                .onTapGesture{
//                    print("Text tapped")
//            }
//            .highPriorityGesture (
//                TapGesture()
//                    .onEnded{ _ in
//                        print("VStack tapped")
//                }
//            )
//        }
        
//        let dragGesture = DragGesture()
//            .onChanged{ value in self.offset = value.translation}
//            .onEnded{value in
//                withAnimation{
//                    self.offset = value.translation
//                    self.isDragging = false
//                }
//        }
//
//        let pressGesture = LongPressGesture()
//            .onEnded{ value in
//                withAnimation{
//                    self.isDragging = true
//                }
//
//        }
//
//        let combined = pressGesture.sequenced(before: dragGesture)
//
//        return Circle()
//            .fill(Color.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
    }
//    func simpleSuccess() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.warning)
//    }
//
//    func prepareHaptics(){
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
//            return
//        }
//
//        do {
//            self.engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("There was an error creating the engine\(error.localizedDescription)")
//        }
//    }
    
    func complesSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0,to:1,by:0.1){
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: i)
        events.append(event)
        }
        
        for i in stride(from: 0,to:1,by:0.1){
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1-i))
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1-i))
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 1+i)
        events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch{
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
