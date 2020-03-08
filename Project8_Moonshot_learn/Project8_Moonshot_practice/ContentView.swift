//
//  ContentView.swift
//  Project8_Moonshot_practice
//
//  Created by Ильдар Нигметзянов on 07.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String){
        print("Creating a new CustomText")
        self.text = text
    }
}

struct ContentView: View {
    var body: some View {
//        ScrollView(.vertical){
//            VStack(spacing: 10){
//        List{
//        ForEach(0..<100){
//                    //Text("Item \($0)")
//                    CustomText("Item \($0)")
//                        .font(.title)
//                }
//        }
                //        GeometryReader{geo in
                //            Image("example")
                //                .resizable()
                //                .aspectRatio(contentMode: .fit)
                //                .frame(width:geo.size.width)
                
                //.frame(width:300,height:300)
                //.clipped()
//            }
//            .frame(maxWidth: .infinity)
//        }
//        NavigationView{
            
            
//            VStack{
//                NavigationLink(destination: Text("Detail View")){
//                Text("hello World")
//                }
//            }
//            List(0..<100){row in
//                NavigationLink(destination: Text("Detail \(row)")){
//                    Text("Row \(row)")
//                }
//            }
//        .navigationBarTitle("SwiftUI")
//        }
        
        Button("Decode JSON"){
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """
            
            struct User: Codable {
                var name: String
                var address: Address
            }

            struct Address: Codable {
                var street: String
                var city: String
            }
            
            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
