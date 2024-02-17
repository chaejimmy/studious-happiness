////
//  Wishlist.swift
//  bug-free-goggles
//
//  Created by Mac on 24/05/23.
//

import Foundation

extension WishlistData{
    struct AddResponse: Codable{
        let msg: String
    }
    
    struct UpdateResponse: Codable{
        let success: Bool?
        let errors: String?
    }
}
