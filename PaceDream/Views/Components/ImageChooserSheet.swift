////
//  ImageChooserSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

class ImageChooserViewModel: ObservableObject {
    @Published var openChooserSheet: Bool = false
    @Published var isPickFromGallery: Bool = false
    
    func openImagePicker(isPickFromGallery: Bool = false) {
        self.isPickFromGallery = isPickFromGallery
        self.openChooserSheet = true
    }
}

struct ImageChooserSheet: View {
    @StateObject var vm = ImageChooserViewModel()
    
    let selectedImage: (UIImage) -> Void
    let dismiss: () -> Void
    
    var body: some View {
        SheetContent(topCorners: (16, 16)) {
            VStack(spacing: 12) {
                Button {
                    vm.openImagePicker()
                } label: {
                    Text("Take Photo")
                }
                .buttonStyle(BorderedButtonStyle())
                Button {
                    vm.openImagePicker(isPickFromGallery: true)
                } label: {
                    Text("Add from Gallery")
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .padding()
            .padding(.bottom)
            .sheet(isPresented: $vm.openChooserSheet, onDismiss: {
                dismiss()
            }){
                ImagePicker(sourceType: vm.isPickFromGallery ? .photoLibrary : .camera, selectedImage: selectedImage)
            }
        }
    }
}

struct ImageChooserSheet_Previews: PreviewProvider {
    static var previews: some View {
        ImageChooserSheet(selectedImage: {_ in}, dismiss: {})
    }
}
