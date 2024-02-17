//
//  PlaceSearchView.swift
//  cheffy
//
//  Created by Viswanath Reddy on 07/05/23.
//

import SwiftUI

struct AddressSearchTextField: View {
    // MARK: - PROPERTIES
    @ObservedObject var viewModel: AddressSearchViewModel
    @FocusState private var isFocusedTextField: Bool
    var placeholder: String = String.Hosting.enterLocation
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Image("location_on")
            TextField(placeholder, text: $viewModel.searchableText)
                .disableAutocorrection(true)
                .foregroundColor(Color.primary)
                //.focused($isFocusedTextField)
                .placeholder(placeholder, when: viewModel.searchableText.isEmpty)
                .font(.body)
                .onReceive(
                    viewModel.$searchableText.debounce(
                        for: .seconds(1),
                        scheduler: DispatchQueue.main
                    )
                ) {
                    viewModel.searchAddress($0)
                }
                .overlay {
                    ClearButton(text: $viewModel.searchableText, clicked: {
                        viewModel.clear()
                    })
                    .padding(.trailing)
                    .padding(.top, 5)
                }
                .onAppear {
                    isFocusedTextField = true
                }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            maxHeight: 30,
            alignment: .leading
        )
        .padding(10)
        .background(Capsule().fill(Color.secondaryLightGray))
    }
}

struct PlaceSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchTextField(viewModel: AddressSearchViewModel())
            .previewLayout(.sizeThatFits)
    }
}
