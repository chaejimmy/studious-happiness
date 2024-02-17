////
//  CustomTextField.swift
//  bug-free-goggles
//
//  Created by Mac on 01/05/23.
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: String = "Name"
    @Binding var value: String
    var keyboardType: UIKeyboardType = .default
    var isSecureField: Bool = false
    @State var visible: Bool = false
    var onEditingChanged: (Bool) -> Void = {_ in}
    var onCommit: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                if isSecureField && !visible {
                    SecureField(placeholder, text: $value)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                        .autocapitalization((keyboardType == .emailAddress || isSecureField) ? .none : .sentences)
                } else {
                    TextField(placeholder, text: $value, onEditingChanged: onEditingChanged, onCommit: onCommit)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                        .autocapitalization((keyboardType == .emailAddress || isSecureField) ? .none : .sentences)
                }
                if isSecureField {
                    Button(action: {
                        visible.toggle()
                    }, label: {
                        Image(systemName: visible ? "eye.slash.fill": "eye.fill")
                            .foregroundColor(.secondaryGray)
                    }).frame(width: 15, height: 15)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 14)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.lightGray)
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(value: .constant("Abcdef"), isSecureField: true)
    }
}
