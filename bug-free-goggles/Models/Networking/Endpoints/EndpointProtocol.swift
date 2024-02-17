////
//  EndpointProtocol.swift
//  bug-free-goggles
//
//  Created by Mac on 23/05/23.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
}
