//
//  UITableView+Extension.swift
//  Jimu
//
//  Created by Sam on 2018/3/6.
//  Copyright © 2018年 ubt. All rights reserved.
//

import UIKit

// 给 UITableView 进行方法扩展，增加使用类型进行注册和复用的方法
extension UITableView {
    
    ///注册一个代码cell
    func register_PY(_ cellClass: UITableViewCell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    ///解决复用返回代码 cell 需要进行强制类型转换, 用泛型来解决这个问题.
    func dequeueReusableCell_PY<T: UITableViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }
    
    /// 注册头部
    /// - Parameter headerClass: 头部类
    func registerHeaderFooterView_PY(_ headerFooterClass:UITableViewHeaderFooterView.Type){
        let identifier = String(describing: headerFooterClass)
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 注册Header/Footer
    /// - Parameter headerFooterClass: Header/Footer类
    /// - Returns: Header/Footer对象
    func dequeueReusableHeaderFooterView_PY<T:UITableViewHeaderFooterView>(_ headerFooterClass:UITableViewHeaderFooterView.Type) -> T{
        let identifier = String(describing: headerFooterClass)
        return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
    }
}

extension UICollectionView {
    ///注册一个代码cell
    func register_PY(_ cellClass: UICollectionViewCell.Type) {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    ///解决复用返回代码 cell 需要进行强制类型转换, 用泛型来解决这个问题.
    func dequeueReusableCell_PY<T: UICollectionViewCell>(with cellClass: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellClass)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
    /// 注册Header
    /// - Parameter headerClass: Header类
    func registerHeader_PY(_ headerClass:UICollectionReusableView.Type){
        
        let identifier = String(describing: headerClass)
        register(headerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    /// 注册Footer
    /// - Parameter footerClass: Footer类
    func registerFooter_PY(_ footerClass:UICollectionReusableView.Type){
        
        let identifier = String(describing: footerClass)
        register(footerClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
    /// 复用Header
    /// - Parameters:
    ///   - headerClass: Header类
    ///   - indexPath: IndexPath
    /// - Returns: Header类的对象
    func dequeueReusableHeader_PY<T:UICollectionReusableView>(_ headerClass:T.Type,for indexPath:IndexPath) -> T{
        let identifier = String(describing: headerClass)
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as! T
    }
    
    /// 复用Footer
    /// - Parameters:
    ///   - footerClass: Footer类
    ///   - indexPath: IndexPath
    /// - Returns: Footer类的对象
    func dequeueReusableFooter_PY<T:UICollectionReusableView>(_ footerClass:T.Type,for indexPath:IndexPath) -> T{
        let identifier = String(describing: footerClass)
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as! T
    }
}

