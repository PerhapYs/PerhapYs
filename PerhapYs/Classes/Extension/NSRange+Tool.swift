//
//  NSRange+Tool.swift
//  SwiftNote
//
//  Created by PerhapYs on 2021/12/29.
//

import Foundation

extension NSRange {
    
    ///   NSRange转Range
    /// - Parameter string: 原字符串
    /// - Returns: Range
    func toRange(string: String) -> Range<String.Index>
    {
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}

extension String{
    
    /// 获取NSRange
    /// - Parameter of: ~
    /// - Returns: ~
    func nsRange(of: String) -> NSRange{
        
        guard let range = self.range(of: of) else {
            return NSRange()
        }
        return NSRange(range,in: self)
    }
}

