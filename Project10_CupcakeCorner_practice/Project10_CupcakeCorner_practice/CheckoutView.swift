//
//  CheckoutView.swift
//  Project10_CupcakeCorner_practice
//
//  Created by Ильдар Нигметзянов on 18.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
