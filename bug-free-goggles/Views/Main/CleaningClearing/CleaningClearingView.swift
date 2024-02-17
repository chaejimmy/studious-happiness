////
//  CleaningClearingView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct CleaningClearingView: View {
    @Environment(\.dismiss) var dismiss
    var isForCleaning: Bool = false
    @State private var images: [UIImage] = []
    @State private var showPhotoPicker: Bool = false
    @State var selectedPaymentOption: PaymentOption? = nil
    @State var showAddNewCard: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            isForCleaning
                            ? "Claim self cleaning fee" : "Upload room clearing pictures."
                        )
                        .font(.circular(size: 28, weight: .bold))
                        Text(
                           "This is not sure by uploading the pictures, you’ll claim the cleaning service fees. It’ll take up-to 14 days to confirm claim."
                        )
                        .font(.circular(size: 15, weight: .book))
                    }
                    
                    ImageListView(images: $images) {
                        showPhotoPicker = true
                    }
                    
                    if isForCleaning {
                        PaymentMethodView(selectedPaymentOption: $selectedPaymentOption, showAddNewCard: $showAddNewCard)
                    }
                    Spacer(minLength: 100)
                }
                .padding(.horizontal)
                .padding(.top)
            }
            footerView
        }
        .navigationBarBackButtonHidden(true)
        .toolbarBackground(Color.background, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
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
            }
        }
        .modal(
            present: $showPhotoPicker,
            view:
                ImageChooserSheet(
                    selectedImage:  { images.append($0) },
                    dismiss: { showPhotoPicker = false }
                )
        )
        .modal(present: $showAddNewCard, view: AddCardSheet(){
            showAddNewCard = false
        })
    }
    
    var footerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
                    
            }
            .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))

            Spacer()
            Button {
                
            } label: {
                Text("Submit")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
        .padding()
        .background(Color.white)
    }
}

struct CleaningClearingView_Previews: PreviewProvider {
    static var previews: some View {
        CleaningClearingView(isForCleaning: false)
    }
}
