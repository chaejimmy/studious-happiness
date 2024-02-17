////
//  CustomRangeSlider.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct CustomRangeSlider: View {
    let currentValue: Binding<ClosedRange<Float>>
    var sliderBounds: ClosedRange<Int>
    
    public init(value: Binding<ClosedRange<Float>>, bounds: ClosedRange<Int> = 100...1000) {
        self.currentValue = value
        self.sliderBounds = bounds
    }
    
    var body: some View  {
        VStack(spacing: 4) {
            GeometryReader { geometry in
                sliderView(sliderSize: geometry.size,
                           sliderViewYCenter: geometry.size.height / 2)
            }
            .frame(height: 28)
        }
        .padding(.horizontal)
        .padding(.bottom, 28)
    }
    
    
    @ViewBuilder private func sliderView(sliderSize: CGSize, sliderViewYCenter: CGFloat) -> some View {
        lineBetweenThumbs(from: leftThumbLocation(width: sliderSize.width,
                                                  sliderViewYCenter: sliderViewYCenter),
                          to: rightThumbLocation(width: sliderSize.width,
                                                 sliderViewYCenter: sliderViewYCenter))
        
        thumbView(position: leftThumbLocation(width: sliderSize.width,
                                              sliderViewYCenter: sliderViewYCenter),
                  value: Float(currentValue.wrappedValue.lowerBound))
        .highPriorityGesture(DragGesture().onChanged { dragValue in
            let newValue = newThumbLocation(dragLocation: dragValue.location,
                                                      width: sliderSize.width)
            
            if newValue < currentValue.wrappedValue.upperBound {
                currentValue.wrappedValue = newValue...currentValue.wrappedValue.upperBound
            }
        })
        
        thumbView(position: rightThumbLocation(width: sliderSize.width,
                                                         sliderViewYCenter: sliderViewYCenter),
                  value: Float(currentValue.wrappedValue.upperBound))
        .highPriorityGesture(DragGesture().onChanged { dragValue in
            let newValue = newThumbLocation(dragLocation: dragValue.location,
                                                      width: sliderSize.width)
            
            if newValue > currentValue.wrappedValue.lowerBound {
                currentValue.wrappedValue = currentValue.wrappedValue.lowerBound...newValue
            }
        })
    }
    
    @ViewBuilder func lineBetweenThumbs(from: CGPoint, to: CGPoint) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .frame(height: 8)
                .foregroundColor(Color.darkWhite1)
            
            
            Path { path in
                path.move(to: from)
                path.addLine(to: to)
            }
            .stroke(Color.appPrimary,
                    lineWidth: 8)
        }
    }
    
    @ViewBuilder func thumbView(position: CGPoint, value: Float) -> some View {
        ZStack {
            Circle()
                .frame(width: 18, height: 18)
                .foregroundColor(Color.appPrimary)
                .padding(.vertical, 16)
                .background(
                    Circle().stroke(Color.white , style: StrokeStyle(lineWidth: 4))
                )
                .contentShape(Rectangle())
            Text("$\(Int(value))")
                .font(.inter(size: 14, weight: .medium))
                .padding(.horizontal, 12)
                .padding(.top, 8)
                .padding(.bottom, 6)
                .foregroundColor(Color.gray700)
                .background(
                    Image("tooltipIcon")
                        .resizable()
                )
                .offset(y: 28)
        }
        .position(x: position.x, y: position.y)
    }
    
    func leftThumbLocation(width: CGFloat, sliderViewYCenter: CGFloat = 0) -> CGPoint {
        let sliderLeftPosition = CGFloat(currentValue.wrappedValue.lowerBound - Float(sliderBounds.lowerBound))
        return .init(x: sliderLeftPosition * stepWidthInPixel(width: width),
                     y: sliderViewYCenter)
    }
    
    func rightThumbLocation(width: CGFloat, sliderViewYCenter: CGFloat = 0) -> CGPoint {
        let sliderRightPosition = CGFloat(currentValue.wrappedValue.upperBound - Float(sliderBounds.lowerBound))
        
        return .init(x: sliderRightPosition * stepWidthInPixel(width: width),
                     y: sliderViewYCenter)
    }
    
    func newThumbLocation(dragLocation: CGPoint, width: CGFloat) -> Float {
        let xThumbOffset = min(max(0, dragLocation.x), width)
        return Float(sliderBounds.lowerBound) + Float(xThumbOffset / stepWidthInPixel(width: width))
    }
    
    private func stepWidthInPixel(width: CGFloat) -> CGFloat {
        width / CGFloat(sliderBounds.count - 1)
    }
}

struct CustomRangeSlider_Previews: PreviewProvider {
    struct Preview: View {
        @State var rateRange: ClosedRange<Float> = 25...120
        var body: some View {
            CustomRangeSlider(value: $rateRange, bounds: 25...200)
                .padding(.horizontal, 32)
        }
    }
    static var previews: some View {
        Preview()
    }
}
