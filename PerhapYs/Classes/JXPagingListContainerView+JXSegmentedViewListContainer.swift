//
//  JXPagingListContainerView+JXSegmentedViewListContainer.swift
//  YuanJuBian
//
//  Created by PerhapYs on 2022/1/4.
//

import Foundation
#if canImport(JXPagingView) && canImport(JXSegmentedView)
import JXPagingView
import JXSegmentedView

extension JXPagingListContainerView: JXSegmentedViewListContainer {
    
}  //  用于 将pagerView的listContainerView联动到 jxSegmentedView的listContainer
#endif
