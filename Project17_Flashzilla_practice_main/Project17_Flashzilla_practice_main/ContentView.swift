//
//  ContentView.swift
//  Project17_Flashzilla_practice_main
//
//  Created by Ильдар Нигметзянов on 26.04.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import SwiftUI
import CoreHaptics

enum ViewType {
    case setting,addition
}

struct ContentView: View {
    @State var type = ViewType.addition
    @State private var showingEditScreen = false
    @State var onWrongArray = false
    @State var wrongAnswer = [Card]()
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var cards = [Card]()
    @State private var timeRemaining = 10
    @State private var isActive = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.vertical,5)
                    .background(Capsule()
                        .fill(Color.black)
                        .opacity(0.75))
                ZStack{
                    ForEach(0..<cards.count, id: \.self){
                        index in
                       
                        CardView(card: self.cards[index],arrayWrongAnswer: self.wrongAnswer){
                                withAnimation {
                                    self.removeCard(at: index)
                                }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                            
                    }
                .allowsHitTesting(timeRemaining > 0)
                   
                    if cards.isEmpty{
                        Button("Start Again",action: resetCards)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                }
            }
            
            VStack{
                HStack{
                    Button(action:{
                        self.type = .addition
                        self.showingEditScreen = true
                    }){
                        Image(systemName: "stop")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    Button(action:{
                        self.type = .setting
                        self.showingEditScreen = true
                    }){
                        Image(systemName: "plus.circle")
                        .padding()
                            .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled{
                VStack{
                    Spacer()
                    
                    HStack{
                        Button(action:{
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }){
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint:Text("Mark your answer as being incorrect."))
                        Spacer()
                        Button(action:{
                            withAnimation{
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }){
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                    .accessibility(label: Text("Correct"))
                    .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards){
            if self.type == .addition{
                EditCards()
            }else {
                Setting(isOn: self.$onWrongArray)
            }
        }
        .onAppear(perform:resetCards)
        .onReceive(timer){
            time in
            guard self.isActive else {return}
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
//                self.haptic()
                self.feedback.notificationOccurred(.success)
            } else {
                self.cards = self.wrongAnswer
                self.resetCards()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)){
            _ in self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){
            _ in if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }
//    override func touchesBegan(_ tousches: Set<UITouch>,with event: UIEvent?)
////        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: 0)
//        do {
//            let engine1 = try CHHapticEngine()
//            let pattern = try CHHapticPattern(events: [event], parameters: [])
//            let player = try engine1.makePlayer(with: pattern)
//            try player.stop(atTime: 10)
//        } catch {
//            print("error")
//        }
//    }
    
    func removeCard(at index: Int){
        guard index >= 0 else {return}
        cards.remove(at:index)
        if cards.isEmpty{
            isActive = false
        }
    }
    
    func resetCards(){
//        cards = [Card](repeating: Card.example,count:10)
        timeRemaining = 10
        isActive = true
        loadData()
    }
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards"){
            if let decoded = try? JSONDecoder().decode([Card].self, from: data){
                self.cards = decoded
            }
        }
    }
    
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
