//
//  MissionView.swift
//  Project8_Moonshot_practice
//
//  Created by Ильдар Нигметзянов on 09.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: {$0.id == member.name}){
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView(.vertical){
                VStack{
                    
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
//                        .frame(width: CGFloat(geometry.frame(in:.local)), height: T##CGFloat?, alignment: T##Alignment)
                        //.accessibility(removeTraits: .isImage)
                        .accessibility(hint: Text("Under this image there is info about expedition"))
                        .frame(maxHeight:geo.frame(in:.global).midY)
                    .onTapGesture {
                            print("Global center: \(geo.frame(in: .global).minX) x \(geo.frame(in: .global).minY)")
                            print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                            print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                            
                    }
                        .padding(.top)
                    Text(self.mission.formattedLaunchDate)
                    Text(self.mission.description)
                        .padding()
                        .accessibility(hint: Text("Under this description,there is info about austronauts"))
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut,mission:self.mission)){
                        HStack {
                            Image(crewMember.astronaut.id)
                            .resizable()
                                .frame(width: 83,height:60)
                            .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary,lineWidth: 1))
                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundColor(.secondary)
                                .accessibility(hint: Text("Here is the info about crew member, tap two times to open more info"))
                                                           
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        }
                    .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName),displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions : [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission:missions[0],astronauts: astronauts)
    }
}
