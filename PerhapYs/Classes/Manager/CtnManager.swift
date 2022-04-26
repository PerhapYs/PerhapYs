//
//  CtnManager.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/7.
//

import UIKit

class CtnManager: NSObject {

    static let shared = CtnManager()
   
    lazy var rooter: UIViewController = {

        let navi = UIViewController()
        return navi
    }()
    lazy var window: UIWindow = {
        
        let window = UIWindow.init(frame: UIScreen.main.bounds)
        window.rootViewController = CtnManager.shared.rooter
        window.makeKeyAndVisible()
        return window
    }()
    
}
