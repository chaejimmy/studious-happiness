////
//  AppState.swift
//  bug-free-goggles
//
//  Created by Mac on 06/07/2023.
//

import SwiftUI

final class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var shouldShowSendProposal = false
    @Published var hostMode = false
    @Published var shouldShowHostingView = false
    @Published var shouldShowPartnerHostingView = false
    @Published var shouldShowAdds = false
    
    @Published var id = UUID()
    
}
