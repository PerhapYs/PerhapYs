//
//  IQKBManager.swift
//  YuanJuBian
//
//  Created by apple on 2022/3/7.
//

import UIKit
import IQKeyboardManagerSwift


class IQKBManager: NSObject {

    
    class func registerSDK(){
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    class func closed(){
        
        IQKeyboardManager.shared.enable = false
    }
    class func opened(){
        
        IQKeyboardManager.shared.enable = true
    }
}
