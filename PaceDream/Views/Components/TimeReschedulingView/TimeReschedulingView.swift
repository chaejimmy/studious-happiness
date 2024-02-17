////
//  TimeReschedulingView.swift
//  bug-free-goggles
//
//  Created by Mac on 17/05/23.
//

import SwiftUI

struct TimeReschedulingView: View {
    @State private var previousOffset: CGSize = .zero
    @State private var draggingCardOffset: CGSize = .zero
    @State private var selectedIndex: Int = 0
    @GestureState private var isDragging: Bool = false
    private let rowHeight: CGFloat = 36
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .trailing, spacing: 0) {
                ForEach(Array(hours.enumerated()), id: \.element) { index, hour in
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(hour.timeString)
                            .font(.system(size: 13, weight: .semibold, design: .default))
                            .foregroundColor(showHourSelected(index: index) ? .primary : .secondary)
                            .scaleEffect(showHourSelected(index: index) ? 1.1 : 1)
                            .animation(.default, value: selectedIndex)
                    }
                    .frame(height: rowHeight)
                    .id(index)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay {
                HStack {
                    Spacer(minLength: 80)
                    GeometryReader { bounds in
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.blue.opacity(0.2))
                            .frame(height: rowHeight * 4)
                            .offset(y: draggingCardOffset.height)
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.blue)
                            .frame(height: rowHeight * 4)
                            .scaleEffect(isDragging ? 1.1 : 1)
                            .overlay(content: {
                                Text("You reserved 4 hours")
                                    .font(.system(size: 13, weight: .semibold, design: .default))
                                    .foregroundColor(.white)
                            })
                            .offset(draggingCardOffset)
                            .animation(.default, value: draggingCardOffset)
                            .highPriorityGesture(
                                DragGesture()
                                    .updating($isDragging, body: { value, state, transaction in
                                        state = true
                                    })
                                    .onChanged({ value in
                                        var yOffset = previousOffset.height + value.translation.height
                                        
                                        selectedIndex = Int(yOffset / rowHeight)
                                        print("PG: \(selectedIndex)")
                                        
                                        yOffset = CGFloat(selectedIndex) * rowHeight
                                        
                                        withAnimation {
                                            self.draggingCardOffset = CGSize(width: value.translation.width, height: yOffset)
                                        }
                                    })
                            )
                            .onChange(of: isDragging) { newValue in
                                if !newValue {
                                    previousOffset = draggingCardOffset
                                    withAnimation {
                                        draggingCardOffset.width = 0
                                    }
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        .scrollDisabled(isDragging)
    }
    
    private func showHourSelected(index: Int) -> Bool {
        index >= selectedIndex && index < selectedIndex + 4
    }
    
    private var hours: [Date] {
        var hours: [Date] = []
        for i in 1...24 {
            hours.append(Calendar.current.date(byAdding: .hour, value: i, to: Date().startOfDay)!)
        }
        return hours
    }
}

struct TimeReschedulingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeReschedulingView()
    }
}
