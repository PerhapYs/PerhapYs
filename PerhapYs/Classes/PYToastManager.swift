//
//  PYToastManager.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2022/1/14.
//

import Foundation

#if canImport(Toast_Swift)
import Toast_Swift

func Toast(_ toast:String , toView:UIView){
    
    var style = ToastStyle()
    style.horizontalPadding = 40
    style.verticalPadding = 20
    toView.makeToast(toast,position:.center,style:style)
}

func Toast(_ toast:String){
    guard let window = PYViewManager.currentWindow() else {
        return
    }
    Toast(toast, toView: window)
}

func debugToast(_ toast:String){
    
    #if DEBUG
    Toast(toast)
    #endif
}
#endif
