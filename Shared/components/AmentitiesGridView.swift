//
//  AmentitiesGridView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 14/05/2023.
//


import SwiftUI

struct AmentitesGridView: View {
    @Binding var selectedPlace: [Amentities]
    @State var totalHeight = CGFloat.zero
    
    var body: some View {
        gridItemView()
            .frame(height: totalHeight)
    }
    
    func gridItemView() -> some View {
            var width = CGFloat.zero
            var height = CGFloat.zero
            return GeometryReader { geo in
                ZStack(alignment: .topLeading, content: {
                    ForEach(Amentities.allCases, id: \.data.title) { rooms in
                        ChipView(
                            title: rooms.data.title,
                            bgColor: .appPrimary,
                            unBgColor: Color("DarkWhite"),
                            unSelectedTextCoor: .black,
                            isSelected: selectedPlace.contains(rooms),
                            showImage:true,
                            imagePath: rooms.data.image
                            
                        ){
                            roomSelection(roomType: rooms)
                        }
                        .padding(.trailing, 10)
                        .padding(.vertical, 8)
                            .alignmentGuide(.leading) { dimension in
                                if (abs(width - dimension.width) > geo.size.width) {
                                    width = 0
                                    height -= dimension.height
                                }
                                
                                let result = width
                                if rooms.data.title == Amentities.allCases.last!.data.title {
                                    width = 0
                                } else {
                                    width -= dimension.width
                                }
                                return result
                            }
                            .alignmentGuide(.top) { dimension in
                                let result = height
                                if rooms.data.title == Amentities.allCases.last!.data.title  {
                                    height = 0
                                }
                                return result
                            }
                    }
                })
                .background(viewHeightReader($totalHeight))
            }
        }
    
    private func roomSelection(roomType: Amentities) {
        if selectedPlace.contains(roomType) {
            if let i = selectedPlace.firstIndex(of: roomType) {
                selectedPlace.remove(at: i)
            }
        } else {
            selectedPlace.append(roomType)
        }
    }
        
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

