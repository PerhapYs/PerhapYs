//
//  NSAttributedString+Tool.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/11.
//

import Foundation

#if canImport(BSText)
import BSText
extension NSMutableAttributedString{
    
    /// 生成特定富文本
    /// - Parameters:
    ///   - content: UIImage/UIView/CALayer
    ///   - contentMode: 内容样式
    ///   - contentSize: 内容大小
    ///   - font: 对应的文本字号
    ///   - alignment: 排列方式
    /// - Returns: ～
    class func contentAttributedString_PY(with content:Any? , contentMode:UIView.ContentMode = .scaleAspectFit, contentSize:CGSize ,font:UIFont,alignment:TextVerticalAlignment = .center) -> NSMutableAttributedString?{
        
        let baseAttr = NSMutableAttributedString.bs_attachmentString(with: content, contentMode: contentMode, attachmentSize: contentSize, alignTo: font, alignment: alignment)
        
        return baseAttr
    }
}

extension NSMutableAttributedString{
    
    /// 富文本添加点击事件
    /// - Parameters:
    ///   - range: 点击范围
    ///   - color: 颜色
    ///   - backgroundColor: 背景颜色
    ///   - handle: 事件
    func addClick(at range:NSRange,color:UIColor?,backgroundColor:UIColor?,handle:@escaping () -> ()){
        
        self.bs_set(textHighlightRange: range, color: color, backgroundColor: backgroundColor) { view, att, range, rect in
            handle()
        }
    }
}
#endif
