////
//  StepperSliderView.swift
//  bug-free-goggles
//
//  Created by Mac on 11/05/23.
//

import SwiftUI

struct StepperSliderView: View {
    @Binding var value: Int
    var range: ClosedRange<Int>
    
    @State private var slider: CGFloat = 0
    @State private var dragGestureTranslation: CGFloat = 0
    @State private var lastDragValue: CGFloat = 0
    
    var sliderWidth: CGFloat = 18
    var sliderPadding: CGFloat = 0
    
    func interval(width: CGFloat, increment: Int) -> CGFloat {
        let result = width * CGFloat(increment) / CGFloat(range.upperBound - range.lowerBound)
        return result
    }
    
    func roundToFactor(value: CGFloat, factor: CGFloat) -> CGFloat {
        return factor * round(value / factor)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                // Slider Bar
                ZStack (alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(height: 8)
                        .foregroundColor(Color.darkWhite1)
                    
                    ForEach(range, id: \.self) { number in
                        let text = number == 0 ? "0" : "\(number) Star"
                        Text(text)
                            .font(.system(size: 14, weight: .medium))
                            .padding(.horizontal, 12)
                            .padding(.top, 8)
                            .padding(.bottom, 6)
                            .foregroundColor(Color.gray700)
                            .background(
                                Image("tooltipIcon")
                                    .resizable()
                            )
                            .offset(x: number == 0 ? -8 : -20)
                            .offset(x: interval(width: (geometry.size.width - sliderWidth - 6), increment: number - range.lowerBound), y: 32)
                            .opacity((number == 0 || number == value) ? 1 : 0)
                        
                    }
                    
                    Capsule()
                        .fill(Color.darkIndigo)
                        .frame(width: CGFloat(slider) + 18, height: 8)
                    
                    ForEach(range, id: \.self) { i in
                        circleView
                            .offset(x: interval(width: (geometry.size.width - sliderWidth ), increment: i - range.lowerBound))
                            .opacity(i >= value ? 0 : 1)
                    }
                } // End of Slider Bar
                .frame(width: geometry.size.width, height: 18)
                .padding(.vertical, 16)
                
                // Set the slider value (Stepped)
                let size = (geometry.size.width - sliderWidth - (sliderPadding * 2)) / CGFloat(range.upperBound - range.lowerBound)
                
                circleView
                    .offset(x: CGFloat(slider))
                    .gesture(DragGesture(minimumDistance: 0)
                        .onChanged({ dragValue in
                            let translation = dragValue.translation
                            
                            dragGestureTranslation = CGFloat(translation.width) + lastDragValue
                            
                            // Set the start marker of the slider
                            dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                            
                            // Set the end marker of the slider
                            dragGestureTranslation = dragGestureTranslation > (geometry.size.width - sliderWidth - sliderPadding * 2) ? (geometry.size.width - sliderWidth - sliderPadding * 2) :  dragGestureTranslation
                            
                            
                            // Getting the stepper interval (where to place the marks)
                            let stepInterval = roundToFactor(value: dragGestureTranslation, factor: size)
                            
                            // Get the increments for the stepepdInterval
                            slider = min(max(0, stepInterval), stepInterval)
                            value = Int(round(slider/size)) + range.lowerBound
                        })
                            .onEnded({ dragValue in
                                // Set the start marker of the slider
                                dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0
                                
                                // Set the end marker of the slider
                                dragGestureTranslation = dragGestureTranslation > (geometry.size.width - sliderWidth - sliderPadding * 2) ? (geometry.size.width - sliderWidth - sliderPadding * 2) : dragGestureTranslation
                                
                                // Storing last drag value
                                lastDragValue = dragGestureTranslation
                            })
                    ) // End of DragGesture
                    .onAppear {
                        slider = CGFloat(value - range.lowerBound) * size
                    }
            } // End of GeometryReader
        } // End of VStack
        .frame(height: 64)
    }
    
    var circleView: some View {
        Circle()
            .frame(width: 18, height: 18)
            .foregroundColor(Color.darkIndigo)
            .padding(.vertical, 16)
            .background(
                Circle().stroke(Color.white , style: StrokeStyle(lineWidth: 4))
            )
    }
}

struct StepperSliderView_Previews: PreviewProvider {
    static var previews: some View {
        StepperSliderView(value: .constant(0), range: 0...5)
            .padding(.horizontal, 30)
    }
}
