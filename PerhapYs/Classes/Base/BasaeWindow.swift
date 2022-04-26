//
//  BasaeWindow.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/19.
//

import UIKit

class BasaeWindow: UIWindow {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.topView.frame = self.bounds
        self.addSubview(self.topView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.bringSubviewToFront(self.topView)
    }
    lazy var topView: OverUserInteractionEnableView = {
        
        return OverUserInteractionEnableView()
    }()
}
class OverUserInteractionEnableView : UIView{
    
    /// 手势透过
    /// - Parameters:
    ///   - point: ~
    ///   - event: ~
    /// - Returns: ~
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        if let view = super.hitTest(point, with: event) , view == self{
            return nil
        }
        return super.hitTest(point, with: event)
    }
}
