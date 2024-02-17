////
//  AddCardSheet.swift
//  bug-free-goggles
//
//  Created by Mac on 15/05/23.
//

import SwiftUI

struct AddCardSheet: View {
    @State var cardNumber: String = ""
    @State var cvvNumber: String = ""
    @State var expMonth: String = "02"
    @State var expYear: String = "24"
    let dismissAction: () -> Void
    
    var body: some View {
        SheetContent {
            VStack(spacing: 12) {
                HStack {
                    Text("Add New Card")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    CloseButtonView {
                        dismissAction()
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Card Holder Name")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondaryGray)
                    TextField("eg.- John Due", text: .constant(""))
                        .padding()
                        .background(Color.lightGray)
                    
                    Text("Card Number")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.secondaryGray)
                        .padding(.top, 8)
                    
                    TextField("xxxx xxxx xxxx xxxx", text: .init(get: { cardNumber }, set: { value in
                        cardNumber = ""
                        let startIndex = value.startIndex
                        for index in 0..<value.count {
                            let stringIndex = value.index(startIndex, offsetBy: index)
                            cardNumber += String (value[stringIndex])
                            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                cardNumber.insert(" ", at: stringIndex)
                            }
                        }
                        // Removing Empty Space When Going Back
                        if value.last == " " {
                            cardNumber.removeLast ()
                        }
                        cardNumber = String(cardNumber.prefix (19))
                    }))
                    .padding()
                    .background(Color.lightGray)
                    
                    HStack(spacing: 12){
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Expiration Date")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryGray)
                            HStack {
                                PickerTextFieldView(placeholder: "02", text: $expMonth, pickerItems: (1...12).map { String(format: "%02d", $0) })
                                    .padding(.horizontal, 6)
                                    .background(Color.lightGray)
                                PickerTextFieldView(placeholder: "24", text: $expYear, pickerItems: (1...24).map { String(format: "%02d", $0) })
                                    .padding(.horizontal, 6)
                                    .background(Color.lightGray)
                            }
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("CVV/CVC")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.secondaryGray)
                            TextField("000", text: $cvvNumber.limit(4))
                                .padding()
                                .background(Color.lightGray)
                        }
                        
                    }
                    
                }
                .padding(.bottom, 12)
                Button {
                    
                } label: {
                    Text("Add New Card")
                }
                .buttonStyle(PrimaryButtonStyle(background: .black))
                
                Button {
                    dismissAction()
                } label: {
                    Text("Cancel")
                }
                .buttonStyle(PrimaryButtonStyle(foregroundColor: .black, background: .darkWhite))
            }
            .padding(16)
        }
        .ignoresSafeArea()
    }
}

struct AddCardSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddCardSheet(){ }
    }
}

