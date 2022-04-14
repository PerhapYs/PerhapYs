//
//  TypeDefine.swift
//  YuanJuBian
//
//  Created by mac on 2022/1/14.
//

import Foundation
import UIKit

typealias JXScrollBlock = (UIScrollView) -> ()

typealias EmptyCompleteBlock = (()->())

typealias ReturnValueBlock<T> = ((T)->())

typealias ReturnValuesBlock<P,Y> = ((P , Y) -> ())
