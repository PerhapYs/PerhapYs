//
//  Array+Tool.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/18.
//

import Foundation

extension Array where Element : Equatable {

    /// 删除某个元素
    /// - Parameter element: 数组元素
    mutating func remove(_ element:Element){

        guard self.contains(element) else {
            return
        }
        guard let index = self.firstIndex(of: element) else {
            return
        }
        self.remove(at: index)
    }
}
