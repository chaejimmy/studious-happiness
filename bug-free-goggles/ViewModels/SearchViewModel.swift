////
//  SearchViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 9/4/23.
//

import Foundation

class SearchViewModel: ObservableObject {
    static let shared = SearchViewModel()
    @Published var searchText: String = ""
    @Published var isWhereCollapsed: Bool = false
    @Published var isWheneCollapsed: Bool = true
    @Published var isWhoCollapsed: Bool = true
    @Published var guests: Int = 0
    
}
