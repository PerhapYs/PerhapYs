//
//  PYViewManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/12.
//

import Foundation

struct PYViewManager{
    
    static func currentWindow() -> UIWindow?{
        
        if #available(iOS 13.0, *) {
            let window : UIWindow? = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .last?.windows
                .filter({$0.isKeyWindow})
                .last
            return window
        } else {
            
            let window = UIApplication.shared.keyWindow
            
            return window
        }
    }
}
