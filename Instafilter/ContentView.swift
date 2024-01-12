//
//  ContentView.swift
//  Instafilter
//
//  Created by Rob Ranf on 12/6/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                showingImagePicker = true
            }
            
            Button("Save Image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writePhotoToAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) {
            loadImage()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
    }
    
    
    
//    @State private var image: Image?
//    
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFit()
//        }
//        .onAppear(perform: loadImage)
//    }
//    
//    func loadImage() {
//        guard let inputImage = UIImage(named: "shalltear") else {
//            return
//        }
//        let beginImage = CIImage(image: inputImage)
//        
//        let context = CIContext()
//        let currentFilter = CIFilter.sepiaTone()
//        // let currentFilter = CIFilter.pixellate()
//        // let currentFilter = CIFilter.crystallize()
//        // let currentFilter = CIFilter.twirlDistortion()
//        
//        currentFilter.inputImage = beginImage
//        let amount = 1.0
//        let inputKeys = currentFilter.inputKeys
//        if inputKeys.contains(kCIInputIntensityKey) {
//            currentFilter.setValue(amount, forKey: kCIInputIntensityKey)
//        }
//        if inputKeys.contains(kCIInputRadiusKey) {
//            currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey)
//        }
//        if inputKeys.contains(kCIInputScaleKey) {
//            currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey)
//        }
//        // currentFilter.intensity = 1
//        // currentFilter.scale = 100
//        // currentFilter.radius = 200
//        // currentFilter.radius = 1000
//        // currentFilter.center = CGPoint(x: inputImage.size.width / 2, y: inputImage.size.height / 2)
//        
//        // Get a CIImage from our filter or exit if that fails
//        guard let outputImage = currentFilter.outputImage else {
//            return
//        }
//        
//        // Attempt to get a CGImage from the CIImage
//        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
//            // Convert that to a UIImage
//            let uiImage = UIImage(cgImage: cgimg)
//            
//            // And convert that to a SwiftUI image
//            image = Image(uiImage: uiImage)
//        }
//    }
}

class ImageSaver: NSObject {
    func writePhotoToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError: Error?, contextInfo: UnsafeRawPointer) {
        print("Save Finised!")
    }
}

//struct ContentView: View {
//    @State private var blurAmount: CGFloat = 0.0 {
//        didSet {
//            // This wont print anything for the slider because the slider is only a value
//            // bound to blurAmount and when it updates the View it doesn't actually update
//            // the @State struct. But there is a value printed when the button is clicked because
//            // that isn't a binding, it is actually updating the value of blurAmount, which is
//            // variable wrapped in a struct (State). As stated by Paul H:
//            /*
//             So, changing the property directly using a button works fine, because it goes
//             through the nonmutating setter and triggers the didSet observer, but using a
//             binding doesn’t because it bypasses the setter and adjusts the value directly.
//             */
//            print("New value is \(blurAmount)")
//        }
//    }
//    @State private var showingConfirmation = false
//    @State private var backgroundColor = Color.white
//    
//    var body: some View {
//        VStack {
//            Text("Hello, world!")
//                .frame(width: 300, height: 300)
//                .background(backgroundColor)
//                .blur(radius: blurAmount)
//                .onTapGesture {
//                    showingConfirmation = true
//                }
//                .confirmationDialog("Change Background", isPresented: $showingConfirmation) {
//                    Button("Red") { backgroundColor = .red }
//                    Button("Green") { backgroundColor = .green }
//                    Button("Blue") { backgroundColor = .blue }
//                    Button("Cancel", role: .cancel) {}
//                } message: {
//                    Text("Select a new color")
//                }
//            
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) {
//                    print("New value is \(blurAmount)")
//                }
//            
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
