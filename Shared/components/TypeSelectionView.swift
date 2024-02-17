//
//  TypeSelectionView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 11/05/2023.
//

import SwiftUI

struct TypeSelectionView: View {
    var selectedType: BookedType
    var bgColor: Color = .appPrimary
    let action: (BookedType) -> Void
    
    var body: some View {
        HStack {
            ForEach(BookedType.allCases, id: \.title) { bookedType in
                ChipView(
                    title: bookedType.title,
                    bgColor: bgColor,
                    isSelected: selectedType == bookedType
                ) {
                    action(bookedType)
                }
            }
        }
    }
}

struct ShortSelectionView: View {
    var selectedShortType: ShortType
    var bgColor: Color = .appPrimary
    let action: (ShortType) -> Void
    
    var body: some View {
        HStack {
            ForEach(ShortType.allCases, id: \.title) { shortType in
                ChipView(
                    title: shortType.title,
                    bgColor: bgColor,
                    isSelected: selectedShortType == shortType
                ) {
                    action(shortType)
                }
            }
        }
    }
}



struct TypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectionView(selectedType: .alreadyBooked){_ in }
    }
}
