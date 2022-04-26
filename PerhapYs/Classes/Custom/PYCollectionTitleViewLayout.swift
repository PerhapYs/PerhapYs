//
//  PYCollectionTitleViewLayout.swift
//  SwiftDevNote
//
//  Created by PerhapYs on 2022/4/13.
//

import UIKit

/// UICollectionView添加Header
protocol PYCollectionTitleViewDelegate : AnyObject{
    
    func titleView_PY(in collectionView:UICollectionView) -> UICollectionReusableView.Type
    
    func sizeForTitleView_PY(in collectionView:UICollectionView) -> CGSize
    
    func spaceBetweenTitleAndCell_PY(in collectinView:UICollectionView) -> CGFloat
}
extension PYCollectionTitleViewDelegate{
    
    func spaceBetweenTitleAndCell_PY(in collectinView:UICollectionView) -> CGFloat{0.0}
}
class PYCollectionTitleViewLayout: UICollectionViewFlowLayout {
    
    weak var pyDelegate : PYCollectionTitleViewDelegate?
    var newAtts : [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else {
            return
        }
        self.newAtts.removeAll()
        let sectionNum = collectionView.numberOfSections
        for section in 0..<sectionNum{
            let rowNum = collectionView.numberOfItems(inSection: section)
            for row in 0..<rowNum {
                let indexPath = IndexPath.init(row: row, section: section)
                let cellAtt = self.layoutAttributesForItem(at: indexPath)
                
                //添加cell
                if let cellAtt = cellAtt {
                    let newCellAtt = self.updateLayoutAttributes(cellAtt)
                    self.newAtts.append(newCellAtt)
                }
                //添加Header
                if let headerAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath){
                    let newHeaderAtt = self.updateLayoutAttributes(headerAtt)
                    self.newAtts.append(newHeaderAtt)
                }
                
                //添加Footer
                if let footerAtt = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath){
                    let newFooterAtt = self.updateLayoutAttributes(footerAtt)
                    self.newAtts.append(newFooterAtt)
                }
            }
        }
        if let att = self.layoutAttributesForDecorationView(ofKind: "identifierForTitleFlowLayout", at:IndexPath()){
            self.newAtts.append(att)
        }
    }
    func updateLayoutAttributes(_ att:UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes{
        
        let titleSize = self.titleSize()
        let space = self.titleSpace()
        
        let newAtt : UICollectionViewLayoutAttributes = att.copy() as! UICollectionViewLayoutAttributes
        let oldFrame = att.frame
        let isVertical = self.scrollDirection == .vertical
        
        let newY = isVertical ? space + oldFrame.origin.y + titleSize.height : oldFrame.origin.y
        let newX = isVertical ? oldFrame.origin.x : oldFrame.origin.x + space + titleSize.width

        let newFrame = CGRect.init(x: newX, y: newY, width: oldFrame.size.width, height: oldFrame.size.height)
        newAtt.frame = newFrame
        return newAtt
    }
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let delegate = self.pyDelegate else {
            return nil
        }
        guard let collectionView = self.collectionView else{
            return nil
        }
        let className: UICollectionReusableView.Type = delegate.titleView_PY(in: collectionView)
        let size = self.titleSize()
        if size == .zero{
            return nil
        }
        let decorationKind = NSStringFromClass(className)
        self.register(className, forDecorationViewOfKind: decorationKind)
        
        let atts = UICollectionViewLayoutAttributes.init(forDecorationViewOfKind: decorationKind, with: indexPath)
        atts.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        atts.zIndex = -1
        return atts
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.newAtts
    }
    override var collectionViewContentSize: CGSize{
        
        let oldSize = super.collectionViewContentSize
        let titleSize = self.titleSize()
        let space = self.titleSpace()
        let isVertical = self.scrollDirection == .vertical
        let newWidth = isVertical ? oldSize.width : oldSize.width + titleSize.width + space
        let newHeight = isVertical ? oldSize.height + titleSize.height + space : oldSize.height
        let newSize = CGSize.init(width: newWidth, height: newHeight)
        
        return newSize
    }
    //MARK:
    func titleSpace() -> CGFloat{
        if let delegate = self.pyDelegate ,let collectionView = self.collectionView{
            return delegate.spaceBetweenTitleAndCell_PY(in: collectionView)
        }
        return 0
    }
    func titleSize() -> CGSize{
        
        if let delegate = self.pyDelegate ,let collectionView = self.collectionView{
            return delegate.sizeForTitleView_PY(in: collectionView)
        }
        return .zero
    }
}
