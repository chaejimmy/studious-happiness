////
//  RangedSliderView.swift
//  bug-free-goggles
//
//  Created by Mac on 04/05/23.
//

import SwiftUI

struct RangeSlider: View {
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
            HStack {
                Text("$\(Int(currentValue.wrappedValue.lowerBound))")
                Spacer()
                Text("$\(Int(currentValue.wrappedValue.upperBound))")
            }
            .font(.system(size: 11, weight: .regular))
        }
        .padding(.horizontal)
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
                .fill(Color.primaryGray.opacity(0.2))
                .frame(height: 4)
            
            Path { path in
                path.move(to: from)
                path.addLine(to: to)
            }
            .stroke(Color.appPrimary,
                    lineWidth: 4)
        }
    }
    
    @ViewBuilder func thumbView(position: CGPoint, value: Float) -> some View {
        Circle()
            .frame(width: 28, height: 28)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.16), radius: 8, x: 0, y: 2)
            .contentShape(Rectangle())
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

struct RangedSliderView_Previews: PreviewProvider {
    static var previews: some View {
        RangeSlider(value: .constant(400...600), bounds: 100...1000)
    }
}
