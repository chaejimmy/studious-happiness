////
//  AmenitiesDetailView.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

struct AmenitiesDetailView: View {
    
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = AmenitiesDetailViewModel()
    
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var basicAmin:[Amenity] = .basic
    var standardAmin:[Amenity] = .standout
    
    var body: some View {
        
        // MARK: - TOP HEADER
        VStack(alignment: .leading, spacing: 10) {
            ScrollView {
                // MARK: - HEADER
                HeaderView(
                    title: String.Hosting.amentiesInputPageTitle,
                    subTitle: String.Hosting.amentiesInputPageSubTitle
                )
                .padding([.top, .horizontal], 16)
                
                //AmenitiesContainerView(viewModel: viewModel)
                
                VStack(alignment: .leading) {
                    AmenitiesSelectionView(amenities: basicAmin, selection: $viewModel.selectedAmenities)
                    
                    Text("Any standout amenities?")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(10)
                        .padding([.top, .horizontal], 16)
                    
                    // AmenitiesStandardContainerView(viewModel: viewModel)
                    AmenitiesSelectionView(amenities: standardAmin, selection: $viewModel.selectedStandardAmenities)
                }
            }
            
            Spacer()
            // MARK: - BOTTOM VIEW
            HStack {
                //Back button
                BottomBackButtonView {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
                
                // Next button
                NavigationLink {
                    UploadImageView()
                } label: {
                    Text(String.Hosting.next)
                }
                .buttonStyle(secondaryButtonStyle())
                
            }//: HSTACK
            .padding(.bottom, 20)
            .padding([.top, .horizontal], 16)
            
        }
        .frame(maxWidth: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                CircleButton(size: 40, backgroundColor: .darkWhite) {
                    IconView(image: "chevron_left", size: 24)
                } action: {
                    presentationMode.wrappedValue.dismiss()
                }
            }//: TOOL BAR ITEM
        }//: TOOLBAR
        //: NAVIGATION
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbarBackground(Color.background, for: .navigationBar)
    }
}

struct AmenitiesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AmenitiesDetailView()
        }
    }
}
