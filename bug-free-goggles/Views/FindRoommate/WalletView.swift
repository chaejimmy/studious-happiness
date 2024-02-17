//
//  WalletView.swift
//  Totel
//
//  Created by Jaykrushna Solanki on 24/08/23.
//

import SwiftUI

struct WalletView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    PaymentView()
                } label: {
                    Text("Open Paymet")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.darkIndigo)
                        }
                }
                .padding()
            }
        }
    }
}

struct WalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletView()
    }
}
