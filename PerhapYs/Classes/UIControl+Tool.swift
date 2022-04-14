//
//  UIControl+Tool.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/31.
//

import UIKit

extension UIControl{

    private struct AssociatedClickKeys {
        static var touchUpInside : String = "touchUpInside"
    }
    
    typealias PYClickBlock = () -> ()
    
    var py_clickBlock : PYClickBlock?{
        set{
            objc_setAssociatedObject(self, &AssociatedClickKeys.touchUpInside, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get{
            return objc_getAssociatedObject(self, &AssociatedClickKeys.touchUpInside) as? UIControl.PYClickBlock
        }
    }

    func addClick(click:@escaping PYClickBlock){
        
        self.addTarget(self, action: #selector(PYClickEvent(_:)), for: .touchUpInside)
        self.py_clickBlock = click
    }
    @objc func PYClickEvent(_ btn:UIControl){
        
        guard let clickBlock = self.py_clickBlock else {
            return
        }
        clickBlock()
    }
}

// 扩大点击范围
extension UIControl{
    
    private struct AssociatedKeys {
        static var left : String = "expandLeft"
        static var right : String = "expandRight"
        static var top : String = "expandTop"
        static var bottom : String = "expandBottom"
        static var perEdge : String = "expandEdge"
    }
    
    var perEdge : CGFloat{
        
        set{
            self.expandTop = newValue
            self.expandBottom = newValue
            self.expandLeft = newValue
            self.expandRight = newValue
            return objc_setAssociatedObject(self, &AssociatedKeys.perEdge, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.perEdge) as? CGFloat else {
                return 0
            }
            return value
        }
    }
    var expandLeft : CGFloat{
        set{
            return objc_setAssociatedObject(self, &AssociatedKeys.left, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.left) as? CGFloat else {
                return 0
            }
            return value
        }
    }
    var expandRight : CGFloat{
        set{
            return objc_setAssociatedObject(self, &AssociatedKeys.right, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.right) as? CGFloat else {
                return 0
            }
            return value
        }
    }
    var expandTop : CGFloat{
        set{
            return objc_setAssociatedObject(self, &AssociatedKeys.top, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.top) as? CGFloat else {
                return 0
            }
            return value
        }
    }
    var expandBottom : CGFloat{
        set{
            return objc_setAssociatedObject(self, &AssociatedKeys.bottom, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get{
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.bottom) as? CGFloat else {
                return 0
            }
            return value
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        let newRect = CGRect.init(x: self.bounds.origin.x - expandLeft,
                                  y: self.bounds.origin.y - expandTop,
                                  width: self.bounds.size.width + expandLeft + expandRight,
                                  height: self.bounds.size.height + expandTop + expandBottom)
        
        if newRect.equalTo(self.bounds){
            return super.point(inside: point, with: event)
        }
        
        return newRect.contains(point)
    }
}
