////
//  AmenitiesContainerView.swift
//  bug-free-goggles
//
//  Created by Mac on 21/05/23.
//

import SwiftUI

struct AmenitiesContainerView: View {
    @ObservedObject var viewModel = AmenitiesDetailViewModel()
    
    var body: some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return GeometryReader { geo in
            ZStack(alignment: .topLeading, content: {
                
                ForEach(viewModel.amenities, id: \.id) { item in
                    ChipView(
                        title: item.title,
                        imageName: item.imageName,
                        bgColor: Color.appPrimary,
                        isSelected: item.isselected,
                        action: { viewModel.updateSelected(selecteMenuItem: item)
                        })
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .alignmentGuide(.leading) { dimension in
                            if (abs(width - dimension.width) > geo.size.width) {
                                width = 0
                                height -= dimension.height
                            }
                            let result = width
                            if item.id == viewModel.amenities.last!.id {
                                width = 0
                            } else {
                                width -= dimension.width
                            }
                            return result
                        }
                        .alignmentGuide(.top) { dimension in
                            let result = height
                            if item.id == viewModel.amenities.last!.id {
                                height = 0
                            }
                            return result
                        }
                }
            })
        }
    }
}

struct AmenitiesContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesContainerView(viewModel: AmenitiesDetailViewModel())
    }
}
