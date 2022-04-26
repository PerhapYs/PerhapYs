//
//  UIImage+Tool.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/23.
//

import Foundation
import UIKit


/// 创建纯颜色图
/// - Parameters:
///   - color: 颜色
///   - size: 大小
/// - Returns: UIImage
func UIImageMake(With color:UIColor , size:CGSize) -> UIImage?{
    
    let rect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
    
    if let context = UIGraphicsGetCurrentContext() {
        
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage
    }
    return nil
}

/// 创建视图色图
/// - Parameters:
///   - view: 视图
///   - size: 视图大小
/// - Returns: 颜色
func UIImageMake(with view:UIView , size:CGSize) -> UIImage?{
    
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
        view.layer .render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return image
    }
    return nil
}
extension String{
    
    /// Base64转图片
    /// - Returns: ～
    func base64StringImage() -> UIImage?{
        
        let imageData = Data.init(base64Encoded: self, options: .ignoreUnknownCharacters)
        if imageData != nil{
            return UIImage.init(data: imageData!)
        }
        return nil
    }
}
extension UIImage{
    
    /// 图片转DATA
    /// - Returns: DATA数据
    func toData() -> Data?{
        
       return self.jpegData(compressionQuality: 0.5)
    }
    /**
     *  重设图片大小
     */
    func  reSizeImage(reSize: CGSize )-> UIImage  {
        
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions (reSize, false , UIScreen.main.scale)
        draw(in: CGRect.init(x: 0, y: 0, width: reSize.width, height: reSize.height))
        let  reSizeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext ();
        return  reSizeImage!;
    }
    
    /**
     *  等比率缩放
     */
    func  scaleImage(scaleSize: CGFloat )-> UIImage  {
        
        let  reSize = CGSize.init(width: self.size.width * scaleSize, height: self.size.height*scaleSize)
        return  reSizeImage(reSize:reSize)
    }
    
    /// 点九图
    /// - Parameter insets: 延深位置
    /// - Returns: ～
    func resizingImage(_ insets:UIEdgeInsets) -> UIImage {
        
        let newImage = self.resizableImage(withCapInsets: insets, resizingMode: .stretch)
        return newImage
    }
}
