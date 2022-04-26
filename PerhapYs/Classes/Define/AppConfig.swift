//
//  AppConfig.swift
//  SwiftDevNote
//
//  Created by apple on 2022/3/7.
//

import Foundation
import UIKit

let ScreenWidth = UIScreen.main.bounds.size.width // 屏幕宽度

let ScreenHeight = UIScreen.main.bounds.size.height  // 屏幕高度

// 状态栏高度的
let StatusBarHeight = { () -> CGFloat in
    
    if #available(iOS 13.0, *){
        let window = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .last?.windows
            .filter({$0.isKeyWindow})
            .last

        guard let unwapWindow = window , let unwapScene = unwapWindow.windowScene , let unwapBarManager = unwapScene.statusBarManager  else{
            return 44
        }
        
        return unwapBarManager.statusBarFrame.size.height
    }
    else{

        return UIApplication.shared.statusBarFrame.height
    }
}()

// Tabbar高度
let TabBarHeight = { () -> CGFloat in
    
    if UIDevice.current.isIPhoneXOrLater(){
        
        return 49 + AdditionalFooterHeight
    }
    return 49
}()

/// 刘海高度
let FringeHeight : CGFloat = {
    if UIDevice.current.isIPhoneXOrLater(){
        return 24.0
    }
    else{
        return 0.0
    }
}()

// 刘海屏底部适配高度
let AdditionalFooterHeight : CGFloat = {
    
    if UIDevice.current.isIPhoneXOrLater(){
        return 34.0
    }else{
        return 0.0
    }
}()

extension UIDevice{
    // 判断是否为IPhoneX及以上
    func isIPhoneXOrLater() -> Bool {
        if #available(iOS 11, *){
            guard let window = UIApplication.shared.delegate?.window , let unwrapedWindow = window else{
                return false
            }
            if unwrapedWindow.safeAreaInsets.bottom > 0{
                return true
            }
        }
        return false
    }
}

let LayoutWidth = 375.0
let LayoutHeight = 812.0

let AdaptPercent : CGFloat = {
    
    let phoneWHP = ScreenWidth / ScreenHeight
    let layoutWHP = LayoutWidth / LayoutHeight
    if layoutWHP > phoneWHP{
        return phoneWHP / layoutWHP
    }
    return layoutWHP / phoneWHP
}()

extension Double{
    
    /// 尺寸适配，使用宽高中，比较短的作为计算尺寸，防止超屏
    /// - Returns: 调整后的尺寸
    func F() -> CGFloat{
        return self * AdaptPercent
    }
}

