//
//  CustomImageTextButton.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/9.
//

import UIKit

enum ButtonImageTextLayoutType {
    case T2B    //图文从上到下
    case L2R    //图片从左到右
    case R2L    //图片从右到左
    case B2T    //图片从下到上
}

/// 图文按钮
class CustomImageTextButton: UIButton {
    
    var layoutType : ButtonImageTextLayoutType = .T2B
    
    var space : CGFloat = 0
    
    convenience init(with nTitle:String,nImage:UIImage?,layoutType:ButtonImageTextLayoutType) {
        
        self.init(type: layoutType)
        self.setTitle(nTitle, for: .normal)
        self.setImage(nImage, for: .normal)
    }
    
    convenience init(type:ButtonImageTextLayoutType) {
        self.init(type: .custom)
        
        self.layoutType = type
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let image = self.imageView , let label = self.titleLabel else {
            return
        }
        
        var imageRect = image.frame
        var textRect = label.frame
        let superRect = self.bounds
        
        let imageW = imageRect.size.width
        let imageH = imageRect.size.height
        
//        let textW = textRect.size.width //为0，不可用
        let textH = textRect.size.height
        
        let superW = superRect.size.width
        let superH = superRect.size.height
        
        switch layoutType {
        case .T2B:
            let imageX = superRect.midX - imageW / 2
            let imageY = 0.0
            let textW = superW
            let textX = superRect.midX - textW / 2
            let textY = imageH + space
            imageRect = CGRect.init(x: imageX, y: imageY, width: imageW, height: imageH)
            textRect = CGRect.init(x: textX, y: textY, width:textW , height: textH)
            
            label.textAlignment = .center
        case .L2R:
            let imageX = 0.0
            let imageY = superRect.midY - imageH / 2
            let textX = imageW + space
            let textW = superW - textX
            let textY = superRect.midY - textH / 2
            imageRect = CGRect.init(x: imageX, y: imageY, width: imageW, height: imageH)
            textRect = CGRect.init(x: textX, y: textY, width: textW, height: textH)
            
            label.textAlignment = .left
        case .R2L:
            let imageX = superW - imageW
            let imageY = superRect.midY - imageH / 2
            let textW = imageX - space
            let textX = 0.0
            let textY = superRect.midY - textH / 2
            imageRect = CGRect.init(x: imageX, y: imageY, width: imageW, height: imageH)
            textRect = CGRect.init(x: textX, y: textY, width: textW, height: textH)
            
            label.textAlignment = .right
        case .B2T:
            let imageX = superRect.midX - imageW / 2
            let imageY = superH - imageH
            let textW = superW
            let textX = superRect.midX - textW / 2
            let textY = imageY - space - textH
            imageRect = CGRect.init(x: imageX, y: imageY, width: imageW, height: imageH)
            textRect = CGRect.init(x: textX, y: textY, width: textW, height: textH)
            
            label.textAlignment = .center
        }
        image.frame = imageRect
        label.frame = textRect
    }
}
