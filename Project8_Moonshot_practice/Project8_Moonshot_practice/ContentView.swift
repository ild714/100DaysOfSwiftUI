//
//  ContentView.swift
//  Project8_Moonshot_practice
//
//  Created by Ильдар Нигметзянов on 08.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var check: Bool = true
    
    var body: some View {
        NavigationView{
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission:mission,astronauts: self.astronauts)){
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    if self.check {
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                                .font(.headline)
                            Text(mission.formattedLaunchDate)
                            
                            
                        }
                     } else{
                        VStack(alignment:.leading){
                            Text(mission.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(leading: Button("Show crew name") {
                self.check.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
