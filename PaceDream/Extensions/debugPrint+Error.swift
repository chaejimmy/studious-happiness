////
//  debugPrint+Error.swift
//  bug-free-goggles
//
//  Created by Mac on 22/05/23.
//

import Foundation

func debugPrint<T>(object: T, function: String, error: Error){
    debugPrint(object: object, function: function, message: error.localizedDescription)
}

func debugPrint<T>(object: T, function: String, message: String){
    debugPrint("\(type(of: object)) -> \(function) - \(message)")
}
