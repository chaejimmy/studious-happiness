////
//  MenuItemProtocol.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import Foundation

protocol MenuItemProtocol: AnyObject {
    func updateSelected(selecteMenuItem: MenuItem)
    func resetSelection()
    func isSelected() -> Bool
}
