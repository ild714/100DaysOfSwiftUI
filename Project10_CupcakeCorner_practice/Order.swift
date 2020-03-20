//
//  Order.swift
//  Project10_CupcakeCorner_practice
//
//  Created by Ильдар Нигметзянов on 18.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import Foundation

enum CodingKeys: CodingKey{
    case order
}

struct OrderStruct: Codable {
    
    var type = 0
    var quantity = 3
    
    //var specialRequestEnable = false
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var specialRequestEnable = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}

class Order:ObservableObject,Codable{
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    init() {
        self.order = OrderStruct()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        order = try container.decode(OrderStruct.self, forKey: .order)
//        specialRequestEnable = try container.decode(Bool.self,forKey: .specialRequestEnable)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
    }
    
      @Published var order : OrderStruct
    
//    @Published var type = 0
//    @Published var quantity = 3
//
//      @Published var specialRequestEnable = false
//      @Published var extraFrosting = false
//      @Published var addSprinkles = false
//
//    @Published var name = ""
//    @Published var streetAddress = ""
//    @Published var city = ""
//    @Published var zip = ""
    
    
    
    
    
    var hasValidAddress: Bool {
        if (order.name.isEmpty || order.name.trimmingCharacters(in: .whitespaces).isEmpty) || (order.streetAddress.isEmpty || order.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty) || (order.city.isEmpty || order.city.trimmingCharacters(in: .whitespaces).isEmpty) || (order.zip.isEmpty || order.zip.trimmingCharacters(in: .whitespaces).isEmpty) {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(order.quantity) * 2
        
        cost += (Double(order.type) / 2)
        
        if order.extraFrosting{
            cost += Double(order.quantity)
        }
        
        if order.addSprinkles {
            cost += Double(order.quantity) / 2
        }
        
        return cost
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(order, forKey: .order)
//        try container.encode(specialRequestEnable, forKey: .specialRequestEnable)
//
//        try container.encode(extraFrosting,forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name,forKey:.name)
//        try container.encode(streetAddress,forKey:.streetAddress)
//        try container.encode(city,forKey: .city)
//        try container.encode(zip,forKey: .zip)
    }
}
