////
//  SettingViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 08/05/23.
//

import SwiftUI

class SettingViewModel: ObservableObject {
    static let shared = SettingViewModel()
    
    @Published var showSignOutSheet: Bool = false
    @Published var showMyAccountItem: Bool = false
    @Published var showVersionSheet: Bool = false
    
    @Published var myAccountItem: MyAccount?
    
    
}
