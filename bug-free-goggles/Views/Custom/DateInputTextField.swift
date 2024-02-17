////
//  DateInputTextField.swift
//  bug-free-goggles
//
//  Created by Mac on 09/05/23.
//

import SwiftUI

enum DateKeyboardType {
    case date
    case time
}

struct DateInputTextField: UIViewRepresentable {
    
    var isAutoCorrectionDisabled = false
    var placeholder: String
    var placeholderColor: Color = .black
    var placeholderFont: UIFont = .systemFont(ofSize: 17)
    var textColor: Color = .black
    var textFont: UIFont = .systemFont(ofSize: 17)
    @Binding var text: String
    var date: Date = Date()
    var onCommit: (String,Bool,Bool,Bool) -> Void = {_, _, _, _ in}
    var maxCharacterLimit: Int = -1
    var keyboardType: DateKeyboardType = .date
    var isSecureField: Bool = false
    var icon: String = "chevron.down"
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: DateInputTextField
        var textField: UITextField = UITextField(frame: CGRect())
        var onCommit: (String,Bool,Bool,Bool) -> Void
        var type: DateKeyboardType = .date
        
        init(_ parent: DateInputTextField, type: DateKeyboardType, onCommit: @escaping (String,Bool,Bool,Bool) -> Void) {
            self.parent = parent
            self.type = type
            self.onCommit = onCommit
        }
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            self.onCommit(textField.text ?? "", true, false, false)
            return true
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            self.parent.$text.wrappedValue = textField.text ?? ""
            self.onCommit(textField.text ?? "", false, false, true)
        }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.textField = textField
            if type == .date {
                textField.addDatePicker(target: self, date: parent.date)
            } else {
//                textField.addTimePicker(target: self, date: parent.date)
            }
            self.parent.$text.wrappedValue = textField.text ?? ""
            self.onCommit(textField.text ?? "", false, true, false)
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
//            let currentText = textField.text ?? ""
//            guard let stringRange = Range(range, in: currentText) else { return false }
//            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//            self.parent.$text.wrappedValue = updatedText
//            self.onCommit(updatedText, false, true, false)
//            return (self.parent.maxCharacterLimit < 0) ? true : (updatedText.count <= self.parent.maxCharacterLimit)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, type: keyboardType, onCommit: onCommit)
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.text = text
        textField.font = textFont
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor(cgColor: placeholderColor.cgColor!),
                NSAttributedString.Key.font: placeholderFont
            ]
        )
        textField.textColor = UIColor(cgColor: textColor.cgColor!)
        textField.delegate = context.coordinator
        textField.clipsToBounds = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .default
        
        textField.rightViewMode = .always
        let imageView = UIImageView(frame: .zero)
//        let configuration = UIImage.SymbolConfiguration(pointSize: 12, weight: .bold)
        let image = UIImage(named: icon)//UIImage(systemName: icon, withConfiguration: configuration)
        imageView.frame = CGRect(x: 0, y: 0, width: 12, height: 8)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(cgColor: textColor.cgColor!)
        textField.rightView = imageView
        
        if isAutoCorrectionDisabled {
            textField.autocorrectionType = .no
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        // Don't uncomment below code it will create improper behaviour in text field
        uiView.text = text
        uiView.isSecureTextEntry = isSecureField
    }
    
}

extension UITextField {
    
    func addDatePicker(target: Any, date: Date) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .white
        datePicker.date = date
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePressed))
        UIToolbar.appearance().barTintColor = UIColor(cgColor: Color.white.cgColor!)
        UIToolbar.appearance().tintColor = UIColor(cgColor: Color.black.cgColor!)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
//    func addTimePicker(target: Any, date: Date) {
//
//        let screenWidth = UIScreen.main.bounds.width
//
//        //Add DatePicker as inputView
//        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
//        datePicker.datePickerMode = .time
//        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.backgroundColor = .white
//        datePicker.date = date
//        self.inputView = datePicker
//
//        //Add Tool Bar as input AccessoryView
//        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTimePressed))
//        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTimePressed))
//        UIToolbar.appearance().barTintColor = UIColor(cgColor: Color.white.cgColor!)
//        UIToolbar.appearance().tintColor = UIColor(cgColor: Color.black.cgColor!)
//        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
//
//        self.inputAccessoryView = toolBar
//    }
    
    @objc func cancelDatePressed() {
        self.resignFirstResponder()
    }
    
    @objc func doneDatePressed() {
        if let datePicker = self.inputView as? UIDatePicker {
            self.text = datePicker.date.string(.ddMMyyyySlashed, utc: false)
        }
        self.resignFirstResponder()
    }
    
    @objc func cancelTimePressed() {
        self.resignFirstResponder()
    }
    
//    @objc func doneTimePressed() {
//        if let datePicker = self.inputView as? UIDatePicker {
//            self.text = datePicker.date.string(.hmma, utc: false)
//        }
//        self.resignFirstResponder()
//    }
}

struct DateTextField_Previews: PreviewProvider {
    static var previews: some View {
        DateInputTextField(placeholder: "Placeholder", text: .constant(""))
    }
}
