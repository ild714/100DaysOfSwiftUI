//
//  ContentView.swift
//  Project16_HotProspects_learn
//
//  Created by Ильдар Нигметзянов on 16.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import UserNotifications
import SamplePackage

enum NetworkError: Error {
    case badURL, requestFailed, unknown
}

class DelayedUpdater: ObservableObject{
    var value = 0 {
        willSet{
            objectWillChange.send()
        }
    }
    init(){
        for i in 1...10{
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)){
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
        
    
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
//    @ObservedObject var updater = DelayedUpdater()
//
    @State private var backgroundColor = Color.red
    
    var body: some View {
        Text(results)
        
//        VStack{
//            Button("Request Permission"){
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) { (success, error) in
//                    if success {
//                        print("All set")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule Notification"){
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
        
//        VStack{
//            Text("Hello,World!")
//                .padding()
//                .background(backgroundColor)
//
//            Text("Cahnge Color")
//                .padding()
//                .contextMenu{
//                    Button(action: {
//                        self.backgroundColor = .red
//                    }){
//                        Text("red")
//                        Image(systemName: "checkmark.circle.fill")
////                            .foregroundColor(.blue)
//                    }
//                    Button(action:{
//                        self.backgroundColor = .green
//                    }){
//                        Text("Green")
//                    }
//
//            }
//        }
//        Image("example")
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(Color.black)
//            .edgesIgnoringSafeArea(.all)
//
        //        Text("Value is: \(updater.value)")
        
        
//        Text("Hello, World!")
//            .onAppear{
//                self.fetchData(from:"https://www.apple.com"){ result in
//                    switch result {
//                    case .success(let str):
//                        print(str)
//                    case .failure(let error):
//                        switch error {
//                        case .badURL:
//                            print("Bad URL")
//                        case .requestFailed:
//                            print("Network problems")
//                        case .unknown:
//                            print("Unknown error")
//                        }
//                    }
//                }
//        }
//
//    }
//
//    func fetchData(from urlString: String, completion: @escaping (Result<String,NetworkError>)->Void){
//
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.badURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url){data,response,error in
//
//            DispatchQueue.main.async {
//                if let data = data{
//                    let stringData = String(decoding:data, as:UTF8.self)
//                    completion(.success(stringData))
//                } else if error != nil{
//                    completion(.failure(.requestFailed))
//                } else {
//                    completion(.failure(.unknown))
//                }
//            }
//        }.resume()
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
