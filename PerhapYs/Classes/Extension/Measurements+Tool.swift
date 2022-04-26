//
//  Measurements+Tool.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/8.
//

import Foundation
import UIKit

extension Float{
    
    func toCGFloat() -> CGFloat{
        
        return CGFloat(self)
    }
}
extension Double{
    
    func toFloat() -> Float{
        
        return Float(self)
    }
}
extension CGFloat{
    
    func toFloat() -> Float{
        
        return Float(self)
    }
    func toString() -> String{
        
        return String.init(format: "%f", self)
    }
}
extension Int{
    
    func toString() -> String{
        
        return String(self)
    }
}
