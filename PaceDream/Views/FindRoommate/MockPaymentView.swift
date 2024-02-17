//
//  PaymentView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct MockPaymentView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Payment successfully completed")
                .font(.title2)
            
            Image("PaymentInfo")
            
            Spacer()
            
            Button(action: {}) {
                Text("Download recipt")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.darkIndigo)
                    }
            }
            .padding(.horizontal)
            
            Button(action: {}) {
                Text("Skip")
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color("AliceBlue"))
                    }
            }
            .padding()
        }
    }
}

struct MockPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        MockPaymentView()
    }
}
