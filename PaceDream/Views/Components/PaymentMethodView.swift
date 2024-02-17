////
//  PaymentMethodView.swift
//  bug-free-goggles
//
//  Created by Mac on 31/05/23.
//

import SwiftUI

struct PaymentMethodView: View {
    @Binding var selectedPaymentOption: PaymentOption?
    @Binding var showAddNewCard: Bool
    
    var body: some View {
        VStack(spacing: 2) {
            debitCreditCardView
            paymentMethodView
        }
    }
    
    var debitCreditCardView: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Debit/Credit Card")
                    .font(.system(size: 17, weight: .semibold))
                Spacer()
                Button {
                    showAddNewCard = true
                } label: {
                    HStack(spacing: 4) {
                        Text("Add New Card")
                            .font(.system(size: 15, weight: .semibold))
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
            ForEach(cards, id: \.id) { card in
                PaymentOptionItemView(
                    paymentMethod: card,
                    checked: selectedPaymentOption?.id == card.id
                ) {
                    selectedPaymentOption = card
                }
            }
        }
        .padding()
        .background(Color.white)
    }
    
    var paymentMethodView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Payment Methods")
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            ForEach(paymentMothods, id: \.id) { method in
                PaymentOptionItemView(
                    paymentMethod: method,
                    checked: selectedPaymentOption?.id == method.id
                ) {
                    selectedPaymentOption = method
                }
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}


struct PaymentOptionItemView: View {
    let paymentMethod: PaymentOption
    var checked: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack(spacing: 12) {
                    Image(paymentMethod.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                    Text(paymentMethod.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                    Spacer()
                    CheckView(checked: checked)
                }
                .padding(.vertical, 12)
                Divider()
                    .background(Color.darkWhite)
            }
        }
    }
}

struct PaymentMethodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodView(selectedPaymentOption: .constant(nil), showAddNewCard: .constant(false))
    }
}
