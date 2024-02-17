////
//  CountryPickerViewProxy.swift
//  bug-free-goggles
//
//  Created by Mac on 03/05/23.
//

import UIKit
import SwiftUI
import CountryPicker

struct CountryPickerViewProxy: UIViewControllerRepresentable {
    
    let onSelect: (( _ choosenCountry: Country) -> Void)?
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        UINavigationController(rootViewController: CountryPickerController.create {
            onSelect?($0)}
        )
    }
}
