//
//  BackButtonView.swift
//  cheffy
//
//  Created by Viswanath Reddy on 05/05/23.
//

import SwiftUI

struct BackButtonView: View {
    var text: String? // TO DO
    var clicked: (() -> Void) /// use closure for callback
    
    var body: some View {
        Button(action: clicked) { /// call the closure here
            Image(systemName: "chevron.left")
                .frame(width: 40, height: 40, alignment: .center)
                .padding(5)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
                .background(Color.secondaryLightGray)
                .clipShape(Circle())
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView {
            print("Clicked!")
        }
    }
}
