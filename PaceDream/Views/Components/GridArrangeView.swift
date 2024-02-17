////
//  GridArrangeView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct GridArrangeView: View {
    let list: [KeyValueModel]
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 42, verticalSpacing: 12) {
            ForEach(list, id: \.key) { item in
                GridRow(alignment: .top) {
                    Text(item.key)
                        
                        .foregroundColor(.secondaryGray)
                    Text(item.value)
                        .fixedSize()
                }
            }
        }
        .font(.circular(size: 17, weight: .book))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct GridArrangeView_Previews: PreviewProvider {
    static var previews: some View {
        GridArrangeView(list: PreviewData.userDescriptions)
    }
}
