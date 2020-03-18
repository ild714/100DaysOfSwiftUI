//
//  ContentView.swift
//  Project10_CupcakeCorner_learn
//
//  Created by Ильдар Нигметзянов on 17.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class User: ObservableObject,Codable {
    @Published var name = "Paul Hudson"

    enum CodingKeys: CodingKey{
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self,forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name,forKey: .name)
    }
}



struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {

    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId){ item in
            VStack(alignment: .leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        guard let url = URL(string:"https://itunes.apple.com/search?term=taylor+swift&entity=song") else{
            print("Invalid URL")
            return
        }
        let requset = URLRequest(url: url)

        URLSession.shared.dataTask(with: requset){ data,response,error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self,from:data){
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }

                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

//struct ContentView: View {
//    @State private var username = ""
//    @State private var email = ""
//
//    var disabledForm: Bool {
//        username.count < 5 || email.count < 5
//    }
//
//    var body: some View {
//        Form {
//            Section{
//                TextField("Username",text:$username)
//                TextField("Email",text:$email)
//            }
//            Section{
//                Button("Create account"){
//                    print ("Creating account..")
//                }
//            }
//            .disabled(disabledForm)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
