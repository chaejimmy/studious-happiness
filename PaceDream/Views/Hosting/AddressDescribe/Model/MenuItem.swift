////
//  MenuItem.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import Foundation

struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    var isselected: Bool = false
}
