//
//  PYChatView.swift
//  MetaU
//
//  Created by PerhapYs on 2022/4/13.
//

import UIKit

class PYChatView: UIView {

    init(){
        
        super.init(frame: .zero)
        self.initializeSubViews()
        
        self.registerKeyboard()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initializeSubViews(){
        
        self.addSubview(self.chatMenu)
        self.chatMenu.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(112.F())
            make.bottom.equalToSuperview().offset(-AdditionalFooterHeight)
        }
        
        self.addSubview(self.chatBox)
        self.chatBox.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.chatMenu.snp.top)
        }
        
        self.chatBox.reloadData()
    }
    //MARK: keyboard notification
    func registerKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardShow(noti:Notification){
        let endFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let endY = endFrame.origin.y
        let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        self.updateChatFrame(with: endY, animationTime: duration , isShow: true)
    }
    @objc func keyboardHide(noti:Notification){
        let endFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let endY = endFrame.origin.y
        let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        self.updateChatFrame(with: endY, animationTime: duration , isShow: false)
    }
    func updateChatFrame(with keyboardHeight:CGFloat , animationTime:TimeInterval , isShow:Bool){
        
        let superHeight = self.bounds.size.height
        let screeHeight = UIScreen.main.bounds.size.height
        let keyboardY = screeHeight - keyboardHeight
        
        let originMenuFrame = self.chatMenu.frame
        let menuSize = originMenuFrame.size
        let menuX = originMenuFrame.minX
        var menuY = superHeight - menuSize.height - keyboardY
        menuY = isShow ? menuY : menuY - AdditionalFooterHeight
        
        let originBoxFrame = self.chatBox.frame
        let boxSize = originBoxFrame.size
        let boxX = originBoxFrame.minX
        let boxY = menuY - originBoxFrame.size.height 

        UIView.animate(withDuration: animationTime) {
            
            self.chatMenu.snp.remakeConstraints { make in
                make.size.equalTo(menuSize)
                make.left.equalToSuperview().offset(menuX)
                make.top.equalToSuperview().offset(menuY)
            }
            
            self.chatBox.snp.remakeConstraints { make in
                make.size.equalTo(boxSize)
                make.left.equalToSuperview().offset(boxX)
                make.top.equalToSuperview().offset(boxY)
            }
            self.layoutIfNeeded()
        }
    }
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    //MARK: LAZY
    lazy var chatBox: PYChatBoxView = {
        
        return PYChatBoxView()
    }()
    lazy var chatMenu: PYChatMenuView = {
        
        return PYChatMenuView(with: self.chatBox)
    }()
}
