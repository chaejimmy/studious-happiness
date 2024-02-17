////
//  BottomBackButtonView.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import SwiftUI

struct BottomBackButtonView: View {
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            Text(String.Hosting.back)
        }
        .buttonStyle(secondaryButtonStyle(
            foregroundColor: .black,
            background: .secondaryLightGray)
        )
    }
}

struct BottomBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBackButtonView {
            print("Back button click")
        }
    }
}
