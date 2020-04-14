//
//  Person.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation
import SwiftUI

enum CodingKeys: CodingKey {
    case id,photo, name, birthday
}

struct Person: Codable,Identifiable {
    @State var id = UUID()
    @State var photo: UIImage?
    @State var name: String = ""
    @State var birthday: String = ""
    
    init(photo: UIImage,name:String,birthday:String){
        self.photo = photo
        self.name = name
        self.birthday = birthday
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(UUID.self,forKey:.id)
        let data = try values.decode(Data.self,forKey: .photo)
        if let photo = UIImage(data: data){
            self.photo = photo
        }
        self.name = try values.decode(String.self,forKey: .photo)
        self.birthday = try values.decode(String.self,forKey: .birthday)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let data = self.photo?.jpegData(compressionQuality: 0.8)
        try container.encode(data,forKey: .photo)
        try container.encode(name,forKey:.name)
        try container.encode(birthday,forKey: .birthday)
        try container.encode(id,forKey: .id)
    }
}



