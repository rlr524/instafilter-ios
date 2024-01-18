//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Rob Ranf on 12/18/23.
//

import Foundation
import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        // Tell the PHPickerViewController that when something happens, it
        // should tell the coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Intentionally left empty as needed to conform to UIViewControllerRepresentable
    }
    
    // ImagePicker should have a coordinator to handle communication
    // from the PHPickerViewController. We don't call makeCoordinator ourselves, SwiftUI
    // calls it automatically when an instance of ImagePicker is created. (Essentially
    // it has a built-in initializar).
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // Tell the picker to go away
            picker.dismiss(animated: true)
            
            // Exit if no selection was made
            guard let provider = results.first?.itemProvider else {
                return
            }
            
            // If there is an image to use, use it
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    

}
