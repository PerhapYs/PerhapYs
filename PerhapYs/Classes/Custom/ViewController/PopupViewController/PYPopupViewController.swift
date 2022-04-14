//
//  PYPopupViewController.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/9.
//

import UIKit

class PYPopupAction{
    
    var title:String
    
    var handle:EmptyCompleteBlock?
    
    init(title:String,handle:EmptyCompleteBlock?) {
        
        self.title = title
        self.handle = handle
    }
}

class NoUserInterationView : UIView{
    
    init(){
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(closeHit))
        self.addGestureRecognizer(tap)
    }
    
    @objc func closeHit(){}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class PYPopupViewController: UIViewController {
    
    var actions : [PYPopupAction] = []
    
    var defaultBackgroundColor : UIColor = "#1D2131".HexColor(alpha: 0.6)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = defaultBackgroundColor
        
        let hideTap = UITapGestureRecognizer.init(target: self, action: #selector(hideEvent))
        self.view.addGestureRecognizer(hideTap)
    }
    /// 关闭
    @objc func hideEvent(){
        
        self.dismiss(animated: true)
    }
    /// 展示
    /// - Parameter presentVC: ~
    func show(to presentVC:UIViewController){
        
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .custom
        presentVC.present(self, animated: true)
    }
    
    /// 添加操作
    /// - Parameter actions: ~
    func addActions(actions:[PYPopupAction]){
        
        self.actions = actions
    }
    
    class func show(to viewController:UIViewController) -> Self{
        
        let childVC = Self()
        childVC.show(to: viewController)
        return childVC
    }
}
