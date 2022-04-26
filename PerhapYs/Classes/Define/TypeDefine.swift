//
//  TypeDefine.swift
//  YuanJuBian
//
//  Created by mac on 2022/1/14.
//

import Foundation
import UIKit

/// JXPagingView 使用的 子视图中的滑动交给JXPagingView的闭包
typealias JXScrollBlock = (UIScrollView) -> ()

///空返回闭包
typealias EmptyCompleteBlock = (()->())

/// 返回一个类型的闭包
typealias ReturnValueBlock<T> = ((T)->())

///返回2个类型的闭包
typealias ReturnValuesBlock<P,Y> = ((P , Y) -> ())
