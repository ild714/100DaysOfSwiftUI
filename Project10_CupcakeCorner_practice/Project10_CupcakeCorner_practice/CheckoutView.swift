//
//  CheckoutView.swift
//  Project10_CupcakeCorner_practice
//
//  Created by Ильдар Нигметзянов on 18.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @State private var title = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    //@State private var internetProblem = false
    @ObservedObject var order: Order
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(removeTraits: .isImage)
                    
                    Text("Your total is $\(self.order.cost,specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order"){
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showingConfirmation){
            Alert(title: Text(title), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
//        .alert(isPresented:$internetProblem){
//            Alert(title: Text("Problem with internet connection"), message: Text("Check your internet"), dismissButton: .default(Text("OK")))
//        }
    }
    
    func placeOrder(){
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failded to encode order")
            return 
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request){data, response,error in
            guard let data = data else {
//                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                self.title = "Problem with internet connection"
                self.confirmationMessage = "Turn on your internet"
                self.showingConfirmation = true
                return
            }
            
            if let decoderOrder = try? JSONDecoder().decode(Order.self,from: data){
                self.title = "Thank you"
                self.confirmationMessage = "Your order for \(decoderOrder.order.quantity)x \(Order.types[decoderOrder.order.type].lowercased()) cupcakes is on its way!"
                print("res")
                self.showingConfirmation = true
            }else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
