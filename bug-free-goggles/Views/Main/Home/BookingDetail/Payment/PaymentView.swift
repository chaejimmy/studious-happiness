////
//  PaymentView.swift
//  bug-free-goggles
//
//  Created by Mac on 15/05/23.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedPaymentOption: PaymentOption? = nil
    @State var showAddNewCard: Bool = false
    var isForRefund: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 2) {
                CustomNavBar(title: isForRefund ? "Refund" : "Payment") {
                    dismiss()
                }
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 2) {
                        roomDetailView
                        if isForRefund {
                            RefundAmountView()
                        } else {
                            userDetailsView
                        }
                        PaymentMethodView(selectedPaymentOption: $selectedPaymentOption, showAddNewCard: $showAddNewCard)
                        Spacer(minLength: 100)
                    }
                }
            }
            
            Button {
                
            } label: {
                Text(isForRefund ? "Refund Now" : "Pay USD $920.00")
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding()
            .background(Color.white)
            
        }
        .toolbar(.hidden, for: .navigationBar)
        .modal(present: $showAddNewCard, view: AddCardSheet(){
            showAddNewCard = false
        })
    }
    
    var roomDetailView: some View {
        HStack(spacing: 10) {
            Image("image1")
                .resizable()
                .frame(width: 77, height: 85)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Room Details")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundColor(.secondaryGray)
                Text("Twentynine Palms, California")
                Text("11551 Fifth Street, CA, United States")
                Text("27 Mar - 30 March")
            }
            .font(.system(size: 15, weight: .regular))
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
    
    var userDetailsView: some View {
        HStack(alignment: .top, spacing: 10) {
            Image("profile")
                .resizable()
                .frame(width: 32, height: 32)
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("konsikan@totel.com")
                        .tint(.black)
                    Text("(123) 456-7890")
                    Text("*We’ll provide your profile to your roommate.")
                        .font(.system(size: 11, weight: .regular))
                        .foregroundColor(.secondaryGray)
                }
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.black)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondaryGray)
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct CheckView: View {
    var checked: Bool = false
    
    var body: some View {
        Group {
            if checked {
                Circle()
                    .stroke(Color.appPrimary, lineWidth: 2)
                    .frame(width: 28, height: 28)
                    .overlay {
                        Circle()
                            .fill(Color.appPrimary)
                            .padding(4)
                    }
            } else {
                Circle()
                    .stroke(Color.secondaryGray.opacity(0.3), lineWidth: 2)
                    .frame(width: 28, height: 28)
            }
        }
    }
}

struct RefundAmountView: View {
    var body: some View {
        VStack {
            Text("Refund Ammount")
                .font(.system(size: 17, weight: .semibold))
            Text("$1950")
                .font(.system(size: 57, weight: .semibold))
                .foregroundColor(.appPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.vertical, 46)
        .background(Color.lightIndigo)
        .cornerRadius(20)
        .padding(.horizontal)
    }
}
