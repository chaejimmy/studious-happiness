////
//  AddressDescribeViewModel.swift
//  bug-free-goggles
//
//  Created by Mac on 10/05/23.
//

import Foundation

class AddressDescribeViewModel : ObservableObject, MenuItemProtocol {
    @Published var menuItems :[MenuItem] = [
        MenuItem(title: "Apartment", imageName: "apartment"),
        MenuItem(title: "House", imageName: "house"),
        MenuItem(title: "Hotel", imageName: "hotel"),
        MenuItem(title: "Single room", imageName: "singleroom"),
        MenuItem(title: "Shared room", imageName: "sharedroom"),
    ]
    
    func updateSelected(selecteMenuItem: MenuItem)  {
        resetSelection() // Call this function if want to select only one item.
        
        if let idx = menuItems.firstIndex(where: {$0.id == selecteMenuItem.id}){
            menuItems[idx].isselected.toggle()
        }
    }
    
    func resetSelection(){
        for i in 0..<menuItems.count {
            menuItems[i].isselected = false
        }
    }
    
    func isSelected() -> Bool {
        menuItems.filter({$0.isselected == true}).count > 0
    }
}
