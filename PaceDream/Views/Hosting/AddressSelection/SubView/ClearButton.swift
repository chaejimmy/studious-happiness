//
//  ClearButton.swift
//  cheffy
//
//  Created by Raveena on 07/05/23.
//

import SwiftUI

struct ClearButton: View {
    // MARK: - PROPERTIES
    @Binding var text: String
    var clicked: (() -> Void) /// use closure for callback
    ///
    // MARK: - BODY
    var body: some View {
        if text.isEmpty == false {
            HStack {
                Spacer()
                Button(action: clicked){
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color.secondaryGray)
                }
                .foregroundColor(.secondary)
            }
        } else {
            EmptyView()
        }
    }
}

struct ClearButton_Previews: PreviewProvider {
    static var previews: some View {
        ClearButton(text: .constant("London"), clicked: {
            print("Clicked")
        })
    }
}
