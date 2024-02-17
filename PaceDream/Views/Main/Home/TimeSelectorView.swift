////
//  TimeSelectorView.swift
//  bug-free-goggles
//
//  Created by Mac on 9/6/23.
//

import SwiftUI

struct TimerSelectionView: View {
    @State private var selectedTime = 5 // Set the default time here
    let timeRange = 1...10 // Set the range of available times

    var body: some View {
        VStack {
            Text("Select Timer")
                .font(.title)
                .padding()

            HStack {
                Picker("Timer", selection: $selectedTime) {
                    ForEach(timeRange, id: \.self) { time in
                        Text("\(time)")
                            .font(.system(size: 30, weight: .bold, design: .default)) // Adjust font size
                            .tag(time)
                            .frame(maxWidth: .infinity) // Expand the frame to increase spacing
                    }
                }
                .pickerStyle(WheelPickerStyle())
            .frame(width: 150, height: 150)
                
//                                   Text("Hour")
//                                       .font(.title)
//                                       .foregroundColor(.black)
            } 

            Text("Minutes")
                .font(.title)
                .foregroundColor(.gray)

            Button(action: {
                // Handle starting the timer with the selected time
            }) {
                Text("Start Timer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct TimerSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSelectionView()
    }
}
