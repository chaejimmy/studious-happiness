////
//  PickerTextField.swift
//  bug-free-goggles
//
//  Created by Mac on 15/05/23.
//

import SwiftUI
import Foundation
import UIKit

struct PickerTextField: UIViewRepresentable {
    
    var placeholder: String
    var placeholderColor: Color = .secondaryGray
    var placeholderFont: UIFont = .systemFont(ofSize: 15)
    var textColor: Color = .secondaryGray
    var textFont: UIFont = .systemFont(ofSize: 15)
    @Binding var text: String
    let pickerItems: [String]
    let icon: String
    var onCommit: (Bool) -> Void = {_ in}
    var onFocusChanged: (Bool) -> Void = { _ in }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: PickerTextField
        var textField: UITextField = UITextField(frame: CGRect())
        var onCommit: (Bool) -> Void
        var onFocusChanged: (Bool) -> Void = { _ in }
        
        init(_ parent: PickerTextField, onCommit: @escaping (Bool) -> Void, onFocusChanged: @escaping (Bool) -> Void) {
            self.parent = parent
            self.onCommit = onCommit
            self.onFocusChanged = onFocusChanged
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            return true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.$text.wrappedValue = textField.text ?? ""
            if self.parent.text.isEmpty {
                parent.text = parent.pickerItems.first ?? ""
            }
            self.onFocusChanged(false)
            self.onCommit(true)
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.textField = textField
            self.parent.$text.wrappedValue = textField.text ?? ""
            self.onFocusChanged(true)
        }
        
        func textFieldDidChange(_ textField: UITextField) {
            self.parent.$text.wrappedValue = textField.text ?? ""
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return false
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                       replacementString string: String) -> Bool
        {
            return false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, onCommit: onCommit, onFocusChanged: onFocusChanged)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.font = textFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: placeholderColor.toUIColor(),
                NSAttributedString.Key.font: placeholderFont
            ]
        )
        textField.textColor = textColor.toUIColor()
        textField.delegate = context.coordinator
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .default
        
        textField.rightViewMode = .always
        let imageView = UIImageView(frame: .zero)
        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        let image = UIImage(systemName: icon, withConfiguration: configuration)
        imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 8)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = textColor.toUIColor()
        textField.rightView = imageView
        
        let pickerView = ToolbarPickerView()
        pickerView.items = pickerItems
        if let index = pickerItems.firstIndex(of: text) {
            pickerView.selectRow(index, inComponent: 0, animated: true)
        }
        textField.inputView = pickerView
        pickerView.action = { index in
            self.text = pickerItems[index]
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        // Don't uncomment below code it will create improper behaviour in text field
        if (uiView.text?.isEmpty ?? false && !text.isEmpty) {
            if let index = pickerItems.firstIndex(of: text) {
                (uiView.inputView as! UIPickerView).selectRow(index, inComponent: 0, animated: true)
            }
        }
        uiView.text = text
    }
    
}

protocol ToolbarPickerViewDelegate: AnyObject {
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?
    
    var items: [String] = []
    var action: (Int) -> Void = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.delegate = self
        self.dataSource = self
    }
    
    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }
    
    @objc func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        action(row)
    }
}

struct PickerTextFieldView: View {
    var placeholder: String
    var placeholderColor: Color = .secondaryGray
    var placeholderFont: UIFont = .systemFont(ofSize: 15)
    var trailingIcon: String = "chevron.down"
    var textColor: Color = .secondaryGray
    var textFont: UIFont = .systemFont(ofSize: 15)
    @Binding var text: String
    let pickerItems: [String]
    var onCommit: (Bool) -> Void = {_ in}
    
    var body: some View {
        ZStack(alignment: .trailing) {
            PickerTextField(
                placeholder: placeholder,
                placeholderColor: placeholderColor,
                placeholderFont: placeholderFont,
                textColor: textColor,
                textFont: textFont,
                text: $text,
                pickerItems: pickerItems,
                icon: trailingIcon,
                onCommit: onCommit
            ).padding(.horizontal, 10)
        }
        .frame(height: 56, alignment: .center)
        .frame(maxWidth: .infinity)
        .background(Color.lightGray)
    }
}

struct PickerTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PickerTextFieldView(placeholder: "", text: .constant(""), pickerItems: []) {_ in }
    }
}
