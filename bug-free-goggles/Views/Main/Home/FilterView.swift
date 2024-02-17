////
//  FilterView.swift
//  bug-free-goggles
//
//  Created by Mac on 04/05/23.
//

import SwiftUI

struct FilterView: View {
    @State var bookedType: BookedType = .hourlyRoom
    @State var shortType: ShortType = .highestPrice
    @State var selectedFacilities: [Hobbies] = []
    @State var rateRange: ClosedRange<Float> = 400...600
    let dismiss: () -> Void
    
    var body: some View {
        SheetContent {
            ScrollView(showsIndicators: false){
                content
            }
        }
    }
    var content: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Filter Search Results")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                CloseButtonView(){
                    dismiss()
                }
            }
            .padding(.horizontal)
            
            LabelContentView(title: "Type") {
                ScrollView(.horizontal, showsIndicators: false) {
                    TypeSelectionView(selectedType: bookedType, bgColor: .black) { bookedType in
                        withAnimation {
                            self.bookedType = bookedType
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            LabelContentView(title: "Short") {
                ScrollView(.horizontal, showsIndicators: false) {
                    ShortSelectionView(selectedShortType: shortType, bgColor: .black) { shortType in
                        withAnimation {
                            self.shortType = shortType
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            DateAndPersonSelectionView(showLabel: true, dateAction: {}, personsAction: {})
                .padding(.horizontal)
            
            LabelContentView(title: "Rate") {
                RangeSlider(value: $rateRange)
            }
            
            LabelContentView(title: "Facilities") {
                HobbiesGridView(selectedHobbies: $selectedFacilities)
                    .padding(.horizontal)
            }
            
            Button {
                dismiss()
            } label: {
                Text("Apply Filter")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal)

        }
        .padding(.top)
        .padding(.bottom, 90)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView() {}
    }
}

struct LabelContentView<Content: View>: View {
    var title: String
    var spacing: CGFloat = 8
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: spacing) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            content()
        }
    }
}

enum ShortType: CaseIterable {
    case highestPrice
    case lowestPrice
    case reccomended
    
    var title: String {
        switch self {
        case .highestPrice: return "Highest Price"
        case .lowestPrice: return "Lowest Price"
        case .reccomended: return "Reccomended"
        }
    }
}
