////
//  CountUpView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/20/23.
//

import SwiftUI

struct CountUpView: View {
    var value: Int
    @State private var previousValue: Int?
    @State private var displayedValue: Int = 0
    private let animationDuration: Double = 0.3 // Duration for the animation
    
    init(value: Int) {
        self.value = value
    }
    
    var body: some View {
        Text("\(displayedValue)")
            .font(
                Font.custom("Inter", size: 16)
                    .weight(.semibold)
            )
            .foregroundColor(.black)
            .onAppear {
                startCountUpAnimation()
            }
            .onChange(of: value) { newValue in
                previousValue = displayedValue
                displayedValue = newValue
                startCountUpAnimation()
            }
    }
    
    private func startCountUpAnimation() {
        guard let previousValue = previousValue else {
            return
        }
        
        if displayedValue < value {
            Timer.scheduledTimer(withTimeInterval: animationDuration / Double(value - previousValue), repeats: true) { timer in
                if displayedValue < value {
                    displayedValue += 1
                } else {
                    timer.invalidate()
                }
            }
        } else if displayedValue > value {
            Timer.scheduledTimer(withTimeInterval: animationDuration / Double(previousValue - value), repeats: true) { timer in
                if displayedValue > value {
                    displayedValue -= 1
                } else {
                    timer.invalidate()
                }
            }
        }
    }
}
