////
//  ReviewUploadView.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

struct ReviewUploadView: View {
    @Environment(\.dismiss) var dismiss
    @State private var reviewText: String = "“Absolutely incredible. This place was definitely a dream! From the entryway, to each floor... stunning”"
    @State private var images: [UIImage] = []
    @State private var showPhotoPicker: Bool = false
    @State private var rating: Int = 0
    
    var submitValidation: Bool {
        images.count < 4
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 16) {
                Button {
                    dismiss()
                } label: {
                    Image("arrowBackIcon")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding(12)
                        .background(Color.darkWhite)
                        .clipShape(Circle())
                }
                .padding(.horizontal)
                
                ScrollView(showsIndicators: false){
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Add Review")
                                .font(.system(size: 28, weight: .bold))
                            
                            
                            Text("Choose at least 4 pictures.")
                                .font(.system(size: 15, weight: .regular))
                        }
                        
                        StepperSliderView(value: $rating, range: 0...5)
                            .padding(.top, -14)
                            .padding(.bottom, 6)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Review")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundColor(.secondaryGray)
                            
                            TextEditor(text: $reviewText)
                                .font(.system(size: 14, weight: .regular))
                                .frame(height: 84)
                                .scrollContentBackground(.hidden)
                                .rectangleBgStyle()
                            
                        }
                        ImageListView(images: $images) {
                            showPhotoPicker = true
                        }
                        Spacer(minLength: 100)
                    }
                    .padding(.horizontal)
                }
            }
            
            footerView
        }
        .toolbar(.hidden, for: .navigationBar)
        .modal(present: $showPhotoPicker,
               view:
                ImageChooserSheet(
                    selectedImage:  { images.append($0) },
                    dismiss: { showPhotoPicker = false }
                )
        )
    }
    
    var footerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
            }
            .buttonStyle(FixedPaddingButtonStyle(foregroundColor: .black, background: .darkWhite))

            Spacer()
            Button {
                
            } label: {
                Text("Submit")
            }
            .buttonStyle(FixedPaddingButtonStyle(isDisable: submitValidation))
            .disabled(submitValidation)
        }
        .padding()
        .background(Color.white)
    }
}

struct ReviewUploadView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewUploadView()
    }
}
