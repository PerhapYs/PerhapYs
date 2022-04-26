//
//  PYCollectionBackgroundViewFlowLayout.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2021/12/28.
//

import UIKit

/// UICollectionView设置背景视图
protocol PYCollectionBackgroundViewDelegate : AnyObject{
    
    func backgroundViewForCollectionView() -> UICollectionReusableView.Type
}

class PYCollectionBackgroundViewFlowLayout: UICollectionViewFlowLayout {

    private let identifier : String = "identifierForBgFlowLayout"
    
    var backgroundViewHeight : CGFloat = UIScreen.main.bounds.size.height
    
    var backgroundViewWidth : CGFloat = UIScreen.main.bounds.size.width
    
    weak var pyDelegate : PYCollectionBackgroundViewDelegate?
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let delegate = self.pyDelegate else {
            
            return nil
        }
        
        let className: UICollectionReusableView.Type = delegate.backgroundViewForCollectionView()
        
        self.register(className, forDecorationViewOfKind: identifier)
        
        let atts = UICollectionViewLayoutAttributes.init(forDecorationViewOfKind: identifier, with: indexPath)
        
        atts.frame = CGRect.init(x: 0, y: 0, width: backgroundViewWidth, height: backgroundViewHeight)
        
        atts.zIndex = -1
        
        return atts
    }
        
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let supAtts = super.layoutAttributesForElements(in: rect)
        var atts : [UICollectionViewLayoutAttributes] = []
        
        if let supAtts : [UICollectionViewLayoutAttributes] = supAtts {
            atts = NSMutableArray.init(array: supAtts) as! [UICollectionViewLayoutAttributes]
        }
        let a = NSIndexPath.init(row: 0, section: 0)
        let att = self.layoutAttributesForDecorationView(ofKind: identifier, at:a as IndexPath)
        guard let unwapAtt = att else {
            return atts
        }
        atts.append(unwapAtt)
        return atts
    }
}
