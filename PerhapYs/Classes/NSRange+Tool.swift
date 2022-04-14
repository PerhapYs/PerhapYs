//
//  NSRange+Tool.swift
//  SwiftNote
//
//  Created by PerhapYs on 2021/12/29.
//

import Foundation

extension NSRange {
    
    func toRange(string: String) -> Range<String.Index>
    {
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        return startIndex..<endIndex
    }
}
