//
//  Order.swift
//  Project10_CupcakeCorner_practice
//
//  Created by Ильдар Нигметзянов on 18.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

class Order: ObservableObject{
    static let types = ["Vanilla","Strawberry","Chocolate","Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnable = false
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnable == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
}
