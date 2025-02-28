//
//  ContentView.swift
//  Instafilter
//
//  Created by Shashank B on 28/02/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    //one to store the item that was selected, and one to store that selected item as a SwiftUI image. This distinction matters, because the selected item is just a reference to a picture in the user's photo library until we actually ask for it to be loaded.
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    //want several photoes
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()


    var body: some View {
        VStack {
            //add a PhotosPicker view somewhere in your SwiftUI view hierarchy //single photo
            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
            //show selected Image
            selectedImage?
                .resizable()
                .scaledToFit()
            
            //several photoes
            PhotosPicker("Select images", selection: $pickerItems, matching: .images)
            
            //custom label
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .images) {
                Label("Select a picture", systemImage: "photo")
                
            }
            
            //And the last way is to limit the kinds of pictures that can be imported. We've used .images here across the board, which means we'll get regular photos, screenshots, panoramas, and more. You can apply a more advanced filter using .any(), .all(), and .not(), and passing them an array. For example, this matches all images except screenshots:
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 3, matching: .any(of: [.images, .not(.images)])) {
                    Label("Select a picture", systemImage: "photo")
                }
        
            
            //can add limit
//            PhotosPicker("Select images", selection: $pickerItems, maxSelectionCount: 3, matching: .images)

            ScrollView {
                ForEach(0..<selectedImages.count, id: \.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }

            
            
        }
        //The fourth step is to watch pickerItem for changes, because when it changes it means the user has selected a picture for us to load. Once that's done, we can call loadTransferable(type:) on the picker item, which is a method that tells SwiftUI we want to load actual underlying data from the picker item into a SwiftUI image. If that succeeds, we can assign the resulting value to the selectedImage property.
        //for single image
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
        
        //for multiple image
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()

                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
