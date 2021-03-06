//
//  IQKBManager.swift
//  YuanJuBian
//
//  Created by apple on 2022/3/7.
//

import UIKit
#if canImport(IQKeyboardManagerSwift)
import IQKeyboardManagerSwift

class IQKBManager: NSObject {

    /// 注册IQKeyboardManager
    class func registerSDK(){
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    /// 关闭IQKeyBoardManager管理
    class func closed(){
        
        IQKeyboardManager.shared.enable = false
    }
    
    /// 开启IQKeyBoardManager管理
    class func opened(){
        
        IQKeyboardManager.shared.enable = true
    }
}

#endif
