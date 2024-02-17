////
//  ChipView.swift
//  bug-free-goggles
//
//  Created by Mac on 02/05/23.
//

import SwiftUI

struct ChipView: View {
    let title: String
    var imageName:String? = nil
    var bgColor: Color = .black
    var paddingHorizonatal: CGFloat = 16
    var isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack{
                if let imageName = imageName {
                    Image(imageName).renderingMode(.template)
                }
                Text(title)
            }
            .font(.system(size: 15, weight: .semibold))
            .foregroundColor(isSelected ? .white : .black)
            .padding(.horizontal, paddingHorizonatal)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(isSelected ? bgColor : .lightGray)
            )
        }
    }
}

struct ChipView_Previews: PreviewProvider {
    static var previews: some View {
        ChipView(title: GenderType.male.title, isSelected: true){}
    }
}
