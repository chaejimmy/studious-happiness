//
//  LookOptionView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct LookOptionView: View {
    
    let option: LookOption
    
    var body: some View {
        Image(option.image)
            .resizable()
            .aspectRatio(2 / 1, contentMode: .fit)
            .overlay {
                TextOverlay(title: option.title)
            }
            .cornerRadius(16.0)
    }
}

struct LookOptionView_Previews: PreviewProvider {
    static var previews: some View {
        LookOptionView(option: LookOption(title: "Men", image: "ImgMen"))
    }
}
