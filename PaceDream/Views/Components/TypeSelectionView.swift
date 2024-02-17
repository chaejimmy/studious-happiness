////
//  TypeSelectionView.swift
//  bug-free-goggles
//
//  Created by Mac on 04/05/23.
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


struct CalendarTypeSelectionView: View {
    var selectedCalendarType: CalendarType
    var bgColor: Color = .appPrimary
    let action: (CalendarType) -> Void
    
    var body: some View {
        HStack {
            ForEach(CalendarType.allCases, id: \.title) { calendarType in
                Button {
                    action(calendarType)
                } label: {
                    Text(calendarType.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(selectedCalendarType == calendarType ? .blue : .blue.opacity(0.3))
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                }
            }
        }
    }
}


struct CustomSegmentedControl: View {
    @Binding public var selection: Int
    private let size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
    private let segmentLabels: [String]
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: size.width, height: size.height)
                .foregroundColor(Color(red: 0.97, green: 0.98, blue: 1))
            
            Group{
                if selection == 0 || selection == segmentLabels.count - 1{
                    RoundedRectangle(cornerRadius: 0)
                        .frame(width: segmentWidth(size), height: size.height)
                        .clipShape(RoundedCornerRectangle(cornerRadius: 20, corners: selection == segmentLabels.count - 1 ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight]))
                }else{
                    Capsule()
                        .frame(width: segmentWidth(size), height: size.height)
                }
            }
            .foregroundColor(Color(red: 0.77, green: 0.85, blue: 1))
            .offset(x: calculateSegmentOffset(size))
            .animation(Animation.easeInOut(duration: 0.5), value: calculateSegmentOffset(size))
            
            HStack(spacing: 0) {
                ForEach(0..<segmentLabels.count, id: \.self) { idx in
                    SegmentLabel(title: segmentLabels[idx], width: segmentWidth(size), textColour: selection != idx ? Color.black : .blue)
                        .onTapGesture {
                            withAnimation {
                                selection = idx
                            }
                        }
                }
            }
        }
    }
    
    public init(selection: Binding<Int>, segmentLabels: [String]) {
        self._selection = selection
        self.segmentLabels = segmentLabels
    }
    
    private func segmentWidth(_ mainSize: CGSize) -> CGFloat {
        var width = (mainSize.width / CGFloat(segmentLabels.count))
        if width < 0 {
            width = 0
        }
        return width
    }
    private func calculateSegmentOffset(_ mainSize: CGSize) -> CGFloat {
        segmentWidth(mainSize) * CGFloat(selection)
    }
}

struct RoundedCornerRectangle: Shape {
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return Path(path.cgPath)
    }
}

fileprivate struct SegmentLabel: View {
    
    let title: String
    let width: CGFloat
    let textColour: Color
    
    var body: some View {
        
        Text(title)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: false)
            .foregroundColor(textColour)
            .frame(width: width)
            .font(.headline.bold())
            .contentShape(Capsule())
    }
}




struct TypeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TypeSelectionView(selectedType: .hourlyRoom){_ in }
    }
}
