////
//  GlobalAlertController.swift
//  bug-free-goggles
//
//  Created by Mac on 12/05/23.
//

import UIKit

extension GlobalAlertController {
    static let errorMessage = "Something went wrong, please try again later!"
}

class GlobalAlertController: UIAlertController {
    
    var globalPresentationWindow: UIWindow?
    
    static func showAlert(title: String, message: String, leftBtn: String? = "OK", rightBtn: String? = nil, leftAction: ((UIAlertAction) -> Void)? = nil, rightAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = GlobalAlertController(title: title, message: message, preferredStyle: .alert)
        if let leftBtn = leftBtn {
            alertController.addAction(UIAlertAction(title: leftBtn, style: .default, handler: leftAction))
        }
        if let rightBtn = rightBtn {
            alertController.addAction(UIAlertAction(title: rightBtn, style: .default, handler: rightAction))
        }
        alertController.presentGlobally(animated: true, completion: nil)
    }
    
    @MainActor
    static func showAlertAsync(title: String, message: String, leftBtn: String? = "OK", rightBtn: String? = nil, leftAction: ((UIAlertAction) -> Void)? = nil, rightAction: ((UIAlertAction) -> Void)? = nil) async {
        showAlert(title: title, message: message, leftBtn: leftBtn, rightBtn: rightBtn, leftAction: leftAction, rightAction: rightAction)
    }
    
    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
        globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
        
        //This is needed when using scenes.
        if let currentWindowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            globalPresentationWindow?.windowScene = currentWindowScene
        }
        
        globalPresentationWindow?.rootViewController = UIViewController()
        globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
        globalPresentationWindow?.backgroundColor = .clear
        globalPresentationWindow?.makeKeyAndVisible()
        globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        globalPresentationWindow?.isHidden = true
        globalPresentationWindow = nil
    }
    
}
