//
//  NavigationController+Tool.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/18.
//

import Foundation
import UIKit

extension UINavigationController{
    
    /// 替换最上层pushViewController
    /// - Parameters:
    ///   - viewController: 需要替换的VC
    ///   - animated: 是否需要动画
    func replacePushViewController(_ viewController:UIViewController,animated:Bool){
        
        guard self.viewControllers.count > 0 else {
            self.pushViewController(viewController, animated: animated)
            return
        }
        var viewControllers = self.viewControllers
        viewControllers.removeLast()
        viewControllers.append(viewController)
        self.setViewControllers(viewControllers, animated: animated)
    }
}
