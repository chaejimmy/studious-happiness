//
//  Helper.swift
//  PaceDream
//
//  Created by Vipin Saini on 06-01-2024.
//

import Foundation
import UIKit
import MBProgressHUD
import Toast

enum ToastPosition {
    case top
    case bottom
    case center
}

class Helper: NSObject {
    static let sharedInstance = Helper()
  
    private override init() {
    } 
}

let helper = Helper.sharedInstance


// Popup / Alert
extension Helper {
    
        // MARK: - Show/Hide Loader
    func showLoader() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if keyWindow != nil {
                MBProgressHUD.hide(for: keyWindow!, animated: true)
                
                let loader = MBProgressHUD.showAdded(to: keyWindow!, animated: true)
                loader.mode = MBProgressHUDMode.indeterminate
//                loader.contentColor = .primaryFull
                loader.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.3)
            }
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if keyWindow != nil {
                MBProgressHUD.hide(for: keyWindow!, animated: true)
            }
        }
    }
  
    func showToast(message: String, position: ToastPosition = .top, duration: TimeInterval? = 2, title: String? = "") {
        DispatchQueue.main.async {
            let rVC = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.view.window
            rVC?.hideToast()
            if title?.isEmpty == true {
                switch position {
                    case .top:
                        rVC?.makeToast(message, duration: duration!, position: .top, completion: nil)
                    case .bottom:
                        rVC?.makeToast(message, duration: duration!, position: .bottom, completion: nil)
                    case .center:
                        rVC?.makeToast(message, duration: duration!, position: .center, completion: nil)
                }
            } else {
                switch position {
                    case .top:
                        rVC?.makeToast(message, duration: duration!, position: .top, title: title, completion: nil)
                    case .bottom:
                        rVC?.makeToast(message, duration: duration!, position: .bottom, title: title, completion: nil)
                    case .center:
                        rVC?.makeToast(message, duration: duration!, position: .center, title: title, completion: nil)
                }
            }
        }
    }
}
