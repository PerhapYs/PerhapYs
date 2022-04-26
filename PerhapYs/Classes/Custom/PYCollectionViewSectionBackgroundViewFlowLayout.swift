//
//  PYCollectionViewSectionBackgroundViewFlowLayout.swift
//  SwiftNote
//
//  Created by PerhapYs on 2021/12/28.
//


import UIKit

/// 设置UICollectionView每个Section的背景视图
protocol PyCollectionSectionBackgroundViewDelegate : AnyObject{
    
    /// 设置每个section的背景
    /// - Returns: 背景
    func sectionBgFlowLayout(layout:UICollectionViewFlowLayout,backgroundViewAt section:Int) -> UICollectionReusableView.Type?
    
    /// 是否需要背景包含section的头部HeaderView
    /// - Returns: 是否需要头部范围
    func sectionBgFlowLayout(layout:UICollectionViewFlowLayout ,isContainHeaderView section:Int) -> Bool
    
    /// 是否需要背景包含section的尾部FooterView
    /// - Returns: 是否需要尾部范围
    func sectionBgFlowLayout(layout:UICollectionViewFlowLayout ,isContainFooterView section:Int) -> Bool
}
class PYCollectionViewSectionBackgroundViewFlowLayout : UICollectionViewFlowLayout{
    
    weak var pyDelegate : PyCollectionSectionBackgroundViewDelegate?
    
    private let identifier : String = "identifier"
    
    private var decorationViewAttrs: [UICollectionViewLayoutAttributes] = []
    
    override func prepare() {
        super.prepare()
    
        guard let unwapCollectionView = self.collectionView else {
            return
        }
        let numberOfSections : Int = unwapCollectionView.numberOfSections
        
        self.decorationViewAttrs.removeAll()
        
        for section in 0..<numberOfSections {
            
            let sectionIdentifier = identifier + "\(section)"
            let indexPath = IndexPath(item: 0, section: section)
            // 获取每个section的背景
            let decorationAtts = self.layoutAttributesForDecorationView(ofKind: sectionIdentifier, at: indexPath)
            guard let unwapAtts = decorationAtts else {
                continue
            }
            // 获取cell数量
            guard let numberOfItems = self.collectionView?.numberOfItems(inSection: section) , numberOfItems > 0 else {
                continue
            }
            // 获取第一个cell与最后一个cell的布局
            guard let firstItem = self.layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
                  let lastItem = self.layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section))
            else{
                continue
            }
            // 添加上 所有Cell的范围
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            // 添加上 Inset 距离
            var sectionInset = self.sectionInset
            if let delegate = unwapCollectionView.delegate as? UICollectionViewDelegateFlowLayout, let inset = delegate.collectionView?(unwapCollectionView, layout: self, insetForSectionAt: section) {
                
                sectionInset = inset
            }
            if self.scrollDirection == .vertical{
                sectionFrame.origin.x = 0
                sectionFrame.origin.y -= sectionInset.top
                sectionFrame.size.width = unwapCollectionView.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
            else{
                sectionFrame.origin.x -= sectionInset.left
                sectionFrame.origin.y = 0
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = firstItem.frame.minX < lastItem.frame.minX ? unwapCollectionView.frame.height : lastItem.frame.maxY + sectionInset.bottom
            }
            
            // 添加上HeaderView的范围
            if let pyDelegate = self.pyDelegate , pyDelegate.sectionBgFlowLayout(layout: self, isContainHeaderView: section){
                if let headerAtts = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: indexPath){
                    
                    let headerRect = headerAtts.frame
                    if self.scrollDirection == .vertical{
                        sectionFrame.origin.y -= headerRect.height
                        sectionFrame.size.height += headerRect.height
                    }
                    else{
                        sectionFrame.origin.x -= headerRect.width
                        sectionFrame.size.width += headerRect.width
                    }
                }
            }
            // 添加上FooterView的范围
            if let pyDelegate = self.pyDelegate , pyDelegate.sectionBgFlowLayout(layout: self, isContainFooterView: section){
                if let footerAtts = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, at: indexPath){
                    
                    let footerRect = footerAtts.frame
                    if self.scrollDirection == .vertical{
                        sectionFrame.size.height += footerRect.height
                    }
                    else{
                        sectionFrame.size.width += footerRect.width
                    }
                }
            }
            unwapAtts.frame = sectionFrame
            unwapAtts.zIndex = -1
            
            self.decorationViewAttrs.append(unwapAtts)
        }
    }
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard let delegate = self.pyDelegate else {
            return nil
        }
        
        guard let className: UICollectionReusableView.Type = delegate.sectionBgFlowLayout(layout: self, backgroundViewAt: indexPath.section) else {
            return nil
        }
        self.register(className, forDecorationViewOfKind:elementKind)
        
        let atts = UICollectionViewLayoutAttributes.init(forDecorationViewOfKind: elementKind, with: indexPath)
        
        return atts
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var attrs = super.layoutAttributesForElements(in: rect)
        attrs?.append(contentsOf: self.decorationViewAttrs.filter {
            return rect.intersects($0.frame)
        })
        return attrs
    }
}
