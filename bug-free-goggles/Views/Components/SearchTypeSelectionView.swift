////
//  SearchTypeSelectionView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/3/23.
//

import SwiftUI

struct SearchTypeSelectionView: View {
    var selectedType: SearchType
    let action: (SearchType) -> Void
    
    var body: some View {
        HStack {
            ForEach(SearchType.allCases, id: \.title) { searchType in
                Button{
                    action(searchType)
                } label: {
                    VStack {
                        Text(searchType.title)
                            .foregroundColor(searchType == selectedType ? .black : .gray)
                            .fontWeight(.bold)
                            .font(.system(size: 15, weight: .semibold))
                            .padding(.horizontal, 16)
                            .padding(.top, 10)
                            .lineLimit(1)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(searchType == selectedType ? .black : .white)
                            .padding(.horizontal,16)
                        
                    }
                }
            }
        }
    }
}

struct SearchTypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTypeSelectionView(selectedType: .stay){_ in }
    }
}
