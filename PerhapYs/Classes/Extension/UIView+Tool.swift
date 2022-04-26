//
//  UIView+Tool.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/22.
//

import Foundation
import UIKit

extension UIView{
    
    /// UIView添加渐变色
    /// - Parameters:
    ///   - frame: 渐变色大小
    ///   - startPoint: 起点
    ///   - endPoint: 终点
    ///   - colors: 渐变颜色集合
    ///   - locations: 渐变位置集合
    func gradientColor(frame:CGRect? = nil , startPoint:CGPoint , endPoint:CGPoint , colors:[String] , locations:[NSNumber]?) {
        
        let colorLayer = CAGradientLayer.init()
        colorLayer.frame = frame ?? self.bounds
        colorLayer.startPoint = startPoint
        colorLayer.endPoint = endPoint
        
        var layerColors : [Any] = []
        for colorString in colors {
            
            let color = colorString.HexColor()
            layerColors.append(color.cgColor)
        }
        colorLayer.colors = layerColors
        
        colorLayer.locations = locations
        self.layer.addSublayer(colorLayer)
    }
    
    /// 切指定角
    /// - Parameters:
    ///   - conrners: 切角位置
    ///   - radius: 切角大小
    func addCorner(conrners: UIRectCorner? = nil , radius: CGFloat) {
        if let conrners = conrners {
            let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
        }
        else{
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
    }
}

extension UILabel{
    
    convenience init(textColor:UIColor = UIColor.white,
                    font:UIFont,
                    textAlignment:NSTextAlignment = .left) {
        self.init()
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
    }
}

extension UIButton{
    
    convenience init(nTitle:String,
                     sTitle:String? = nil,
                     nTitleColor:UIColor? = nil,
                     sTitleColor:UIColor? = nil,
                     font:UIFont,
                     backgroundColor:UIColor? = nil) {
        self.init(type: .custom)
        self.setTitle(nTitle, for: .normal)
        self.titleLabel?.font = font
        self.backgroundColor = backgroundColor
        
        if let nTitleColor = nTitleColor {
            self.setTitleColor(nTitleColor, for: .normal)
        }
        if let sTitleColor = sTitleColor {
            self.setTitleColor(sTitleColor, for: .selected)
        }
        if let sTitle = sTitle {
            self.setTitle(sTitle, for: .selected)
        }
    }
    
    convenience init(nImage:UIImage?,sImage:UIImage?) {
        self.init(type: .custom)
        
        self.setImage(nImage, for: .normal)
        self.setImage(sImage, for: .selected)
    }
}

#if canImport(Kingfisher)
import Kingfisher
extension UIImageView{
    
    func setImage_PY(_ image:String){
        let url = URL.init(string: image)
        self.kf.setImage(with: url)
    }
}
#endif
