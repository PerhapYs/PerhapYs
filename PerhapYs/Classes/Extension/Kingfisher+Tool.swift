//
//  Kingfisher+Tool.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2022/1/4.
//

import UIKit
#if canImport(Kingfisher)
import Kingfisher

extension UIImageView{
    
    /// 显示网络图片
    /// - Parameter url: 网络图片链接
    func setImage_PY(imageURL:URL?){
        
        self.kf.indicatorType = .activity  //设置图片下载动画
        self.kf.setImage(with: imageURL, placeholder: nil, options: nil, completionHandler: nil)
    }
    
    func setImage_PY(imageLink:String){
        
        self.py_setKFImage(with: URL.init(string: imageLink))
    }
}

extension UIButton{
    
    /// 设置按钮网络图片
    /// - Parameters:
    ///   - imageLink: 网络图片链接
    ///   - state: 图片的按钮状态
    func setImage_PY(with imageLink:String? , state:UIControl.State){
        guard imageLink != nil else {
            return
        }
        let imageURL = URL.init(string: imageLink!)
        self.kf.setImage(with: imageURL, for: state, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
#endif
