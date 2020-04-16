//
//  PickerImage.swift
//  Challenge6
//
//  Created by Ильдар Нигметзянов on 14.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import SwiftUI

struct PickerImage: UIViewControllerRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image : UIImage?
    @Binding var activeSheet: ActiveSheet
    
    class ImagePickerCordinator: NSObject,UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        @Binding var isShown: Bool
        @Binding var image : UIImage?
        @Binding var activeSheet: ActiveSheet
        
        init(isShown: Binding<Bool>,image:Binding<UIImage?>,activeSheet:Binding<ActiveSheet>){
            _isShown = isShown
            _image = image
            _activeSheet = activeSheet
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            activeSheet = .second
//            isShown = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
        }
    }
    
    func makeCoordinator() -> ImagePickerCordinator {
        return ImagePickerCordinator(isShown:$isShown,image:$image,activeSheet:$activeSheet)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,context: UIViewControllerRepresentableContext<PickerImage>){
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PickerImage>)-> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
}


