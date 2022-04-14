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
    
    func py_setKFImage(with url:URL?){
        
        self.kf.indicatorType = .activity
        
        self.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
    }
    func py_setKFImage(withUrlString:String){
        
        self.py_setKFImage(with: URL.init(string: withUrlString))
    }
}

extension UIButton{
    
    func py_setKFImage(with url:URL? , state:UIControl.State){
        
        self.kf.setImage(with: url, for: state, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
#endif
