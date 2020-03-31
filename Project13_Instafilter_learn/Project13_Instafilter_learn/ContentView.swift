//
//  ContentView.swift
//  Project13_Instafilter_learn
//
//  Created by Ильдар Нигметзянов on 30.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
//    @State private var blurAmount: CGFloat = 0
//
//    @State private var showingActionSheet = false
//    @State private var backgroundColor = Color.white
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack{
            image?
                .resizable
                .scaledToFit
            Button("Select Image"){
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker){
            ImagePicker()
        }
//    .sheet(i)
//
//        VStack{
//            image?
//            .resizable()
//            .scaledToFit()
//        }
//    .onAppear(perform: loadImage)
        
//        Text("Hello")
//            .frame(width:300,height: 300)
//            .background(backgroundColor)
//                .onTapGesture{
//                    self.showingActionSheet = true
//            }
//        .actionSheet(isPresented: $showingActionSheet){
//            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
//                .default(Text("Red")){
//                    self.backgroundColor = .red
//                },
//                .default(Text("Green")){
//                    self.backgroundColor = .green
//                },
//                .default(Text("Blue")){
//                    self.backgroundColor = .blue
//                }
//            ])
//        }
//        let blur = Binding<CGFloat>(
//            get:{
//                self.blurAmount
//        },
//            set: {
//                self.blurAmount = $0
//                print("New value is \(self.blurAmount)")
//        }
//        )
//
//        return
//            VStack{
//                Text("Hello,World!")
//                    .blur(radius: blurAmount)
//                Slider(value: blur, in: 0...20)
//        }
    }
    
//    func loadImage(){
//        //image = Image("photo")
//
//        guard let inputImage = UIImage(named:"photo") else {return}
//        let beginImage = CIImage(image: inputImage)
//
//        let context = CIContext()
////        let currentFilter = CIFilter.crystallize()
//        guard let currentFilter = CIFilter(name:"CITwirlDistortion") else {return}
//
////        currentFilter.inputImage = beginImage
////        currentFilter.setValue(beginImage,forKey: kCIInputImageKey)
////        currentFilter.radius = 100
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.setValue(200, forKey: kCIInputRadiusKey)
//        currentFilter.setValue(CIVector(x:inputImage.size.width/2,y:inputImage.size.height / 2), forKey: kCIInputCenterKey)
//
//        guard let outputImage = currentFilter.outputImage else {return}
//
//        if let cgimg = context.createCGImage(outputImage,from: outputImage.extent){
//            let uiImage = UIImage(cgImage: cgimg)
//            image = Image(uiImage: uiImage)
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
