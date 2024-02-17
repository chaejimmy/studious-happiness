////
//  GivePriceLimitView.swift
//  bug-free-goggles
//
//  Created by Mac on 01/06/23.
//

import SwiftUI

struct GivePriceLimitView: View {
    @State var picker: DayHourPickerView.Picker = .day
    @State var price: Int = 80
    @State var rateRange: ClosedRange<Float> = 25...120
    var isFromPartner: Bool = false
    let action: (DayHourPickerView.Picker, Int, ClosedRange<Float>) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            if isFromPartner {
                DayHourPickerView(picker: $picker, pickers: DayHourPickerView.Picker.allCases)
            }
            
            VStack(alignment: .leading,spacing: 10) {
                PricingPerDayStepperView(
                    value: $price,
                    minimun: Double(rateRange.lowerBound),
                    maximum: Double(rateRange.upperBound),
                    intervalType: picker.rawValue.capitalized
                )
                if isFromPartner {
                    CustomRangeSlider(value: $rateRange, bounds: 25...200)
                }
                Group {
                    Text(
                        isFromPartner
                        ? "Prices your area usually range from "
                        : "His Bid rate is "
                    )
                    +
                    Text("$\(Int(rateRange.lowerBound)) to $\(Int(rateRange.upperBound))")
                }
                .font(.inter(size: 14))
                .foregroundColor(.lightGrayText)
            }
            Spacer()
        }
        .onChange(of: picker) { newValue in
            action(newValue, price, rateRange)
        }
        .onChange(of: price) { newValue in
            action(picker, newValue, rateRange)
        }
        .onChange(of: rateRange) { newValue in
            if price < Int(rateRange.lowerBound) {
                price = Int(rateRange.lowerBound)
            }
            
            if price > Int(rateRange.upperBound){
                price = Int(rateRange.upperBound)
            }
            action(picker, price, newValue)
        }
    }
}

struct GivePriceLimitView_Previews: PreviewProvider {
    static var previews: some View {
        GivePriceLimitView(){_,_,_ in
            
        }
    }
}
