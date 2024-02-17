//
//  HobbiesGridView.swift
//  Totel (iOS)
//
//  Created by Hatesh Kumar on 08/05/2023.
//

import SwiftUI

struct HobbiesGridView: View {
    @Binding var selectedHobbies: [Hobbies]
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
                    ForEach(Hobbies.allCases, id: \.title) { hobby in
                        ChipView(title: hobby.title, isSelected: selectedHobbies.contains(hobby)) {
                            hobbiesSelection(hobby: hobby)
                        }
                        .padding(.trailing, 8)
                        .padding(.vertical, 6)
                            .alignmentGuide(.leading) { dimension in
                                if (abs(width - dimension.width) > geo.size.width) {
                                    width = 0
                                    height -= dimension.height
                                }
                                
                                let result = width
                                if hobby.title == Hobbies.allCases.last!.title {
                                    width = 0
                                } else {
                                    width -= dimension.width
                                }
                                return result
                            }
                            .alignmentGuide(.top) { dimension in
                                let result = height
                                if hobby.title == Hobbies.allCases.last!.title  {
                                    height = 0
                                }
                                return result
                            }
                    }
                })
                .background(viewHeightReader($totalHeight))
            }
        }
    
    private func hobbiesSelection(hobby: Hobbies) {
        if selectedHobbies.contains(hobby) {
            if let i = selectedHobbies.firstIndex(of: hobby) {
                selectedHobbies.remove(at: i)
            }
        } else {
            selectedHobbies.append(hobby)
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
struct HobbiesGridView_Previews: PreviewProvider {
    static var previews: some View {
        HobbiesGridView(selectedHobbies: .constant([.art, .cooking]))
    }
}
