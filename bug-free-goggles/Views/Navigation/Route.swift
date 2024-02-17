////
//  Route.swift
//  bug-free-goggles
//
//  Created by Mac on 12/06/2023.
//

import Foundation

enum Route: Hashable {
    case menuItem(item: String)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs){
        case (.menuItem(let lhsItem), .menuItem(let rhsItem)):
            return lhsItem == rhsItem
            return true
        }
    }
}


 
