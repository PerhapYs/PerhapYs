//
//  PYAlertViewController.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/9.
//

import UIKit

class PYAlertViewController: PYPopupViewController {
    
    var defaultContentBackgroundColor : UIColor = UIColor.white
    
    var defaultContentHeight : CGFloat = 200.F()
    
    var defaultContentWidth : CGFloat = 325.F()
    
    var defaultHandleHeight : CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(defaultContentHeight)
            make.width.equalTo(defaultContentWidth)
        }
        
        self.containerView.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(defaultHandleHeight)
        }
    }
    
    lazy var containerView: NoUserInterationView = {
        let view = NoUserInterationView()
        view.backgroundColor = defaultContentBackgroundColor
        
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 0
        view.axis = .horizontal
        view.distribution = .equalCentering
        view.alignment = .bottom
        return view
    }()
    
    override var actions: [PYPopupAction]{
        didSet{
            guard actions.count > 0 else {
                return
            }
            
            self.resetStackView()
            
            let btnWidth = defaultContentWidth / CGFloat(actions.count)
            for (index,action) in actions.enumerated() {
                
                let btn = UIButton.init(type: .custom)
                btn.setTitle(action.title, for: .normal)
                btn.setTitleColor(COLOR_7B61FF, for: .normal)
                btn.addTarget(self, action: #selector(selectedHandleEvent(_:)), for: .touchUpInside)
                btn.tag = 1000 + index
                self.stackView.addArrangedSubview(btn)
                btn.snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.width.equalTo(btnWidth)
                }
            }
        }
    }
    @objc func selectedHandleEvent(_ btn:UIButton){
        
        let index = btn.tag - 1000
        guard self.actions.count > index else {
            return
        }
        let action = self.actions[index]
        if let handle = action.handle{
            handle()
        }
        self.hideEvent()
    }
    func resetStackView(){
        guard self.stackView.arrangedSubviews.count > 0 else {
            return
        }
        let subViews = self.stackView.arrangedSubviews
        for subView in subViews {
            self.stackView.removeArrangedSubview(subView)
        }
    }
}


