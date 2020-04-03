//
//  ImageSaver.swift
//  Project13_Instafilter_practice
//
//  Created by Ильдар Нигметзянов on 03.04.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import Foundation
import SwiftUI

class ImageSaver: NSObject{
    var successHandler: (()->Void)?
    var errorHandler: ((Error)->Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    @objc func saveError(_image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            errorHandler?(error)
        }else {
            successHandler?()
        }
    }
}
