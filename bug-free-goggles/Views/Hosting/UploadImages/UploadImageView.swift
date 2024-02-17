////
//  UploadImageView.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import SwiftUI
import PhotosUI

struct UploadImageView: View {
    // MARK: - PROPERTIES
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    @State var gridLayout: [GridItem] = [GridItem()]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        // MARK: - TOP HEADER
        VStack(alignment: .leading, spacing: 20){
            // MARK: - HEADER
            HeaderView(
                title: String.Hosting.uploadImagePageTitle,
                subTitle: String.Hosting.uploadImagePageSubTitle
            )
            
            
            
            ScrollView(showsIndicators: false) {
                // MARK: - ADD IMAGES BUTTON
                PhotosPicker(selection: $selectedItems, matching: .images) {
                    VStack(alignment: .center, spacing: 8){
                        Image("addIcon").padding(.bottom, 10)
                        Text(String.Hosting.addImages).style(.medium)
                        HStack(spacing: 5){
                            Text(String.Hosting.browseFiles)
                                .foregroundColor(.blue)
                                .style(.subheadline)
                            Text(String.Hosting.fromGallery).style(.subheadline1)
                        }//:HSTACK
                        
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 150)
                .background(
                    Rectangle()
                        .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [8]))
                )
                LazyVGrid(columns: gridLayout, spacing: 10) {
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        ImageView(image: selectedImages[i]) {
                            selectedImages.remove(at: i)
                        }
                    }
                }
            }
            
            // MARK: - BOTTOM VIEW
            HStack {
                //Back button
                BottomBackButtonView {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                // Next button
                NavigationLink {
                    GiveATitleView()
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle())
                
            }//: HSTACK
            .padding(.bottom, 20)
            
        }//: VSTACK
        .padding([.top, .horizontal], 16)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
            }//: TOOL BAR ITEM
        }//: TOOLBAR
        .onChange(of: selectedItems) { _ in
            Task {
                selectedImages.removeAll()
                
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            let image = Image(uiImage: uiImage)
                            selectedImages.append(image)
                        }
                    }
                }
            } //: TASK
        }//: ON CHANGE
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct UploadImageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UploadImageView()
        }
    }
}
