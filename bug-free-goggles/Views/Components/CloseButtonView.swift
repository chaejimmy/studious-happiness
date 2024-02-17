////
//  CloseButtonView.swift
//  bug-free-goggles
//
//  Created by Mac on 08/05/23.
//

import SwiftUI

struct CloseButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 10, height: 10)
                .fontWeight(.bold)
                .padding(10)
                .foregroundColor(.secondaryGray)
                .background(Color.lightGray)
                .clipShape(Circle())
                .padding(6)
        }
    }
}

struct CloseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CloseButtonView(){}
    }
}
